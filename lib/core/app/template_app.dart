import 'package:architecture_templates/lib_src.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Root application widget for Template
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
  }

  void _configureSystemUI() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: sl<EnvConfig>().showPerformanceOverlay,
      routerConfig: sl<AppRouter>().config,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
