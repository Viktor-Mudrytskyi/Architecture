import 'package:bot_toast/bot_toast.dart';
import 'package:cmms_ship_flutter_app/app_config.dart';
import 'package:cmms_ship_flutter_app/core/routing/app_router.dart';
import 'package:cmms_ship_flutter_app/di.dart';
import 'package:cmms_ship_flutter_app/features/user/presentation/cubit/user_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Root application widget for [Template]
class TemplateApp extends StatefulWidget {
  const TemplateApp({super.key});

  @override
  State<TemplateApp> createState() => _TemplateAppState();
}

class _TemplateAppState extends State<TemplateApp> {
  @override
  void initState() {
    super.initState();
    _configureSystemUI();
    _initializeUser();
  }

  void _configureSystemUI() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  void _initializeUser() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      sl<UserCubit>().getOrCreateUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: sl<AppConfig>().showPerformanceOverlay,
      routerConfig: sl<AppRouter>().config,
      builder: BotToastInit(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
