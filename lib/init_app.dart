import 'package:architecture_templates/core/di.dart';
import 'package:architecture_templates/core/exception/app_exception.dart';
import 'package:architecture_templates/env/flavor.dart';
import 'package:flutter/material.dart';

Future<void> initApp(Flavor flavor) async {
  FlutterError.onError = (FlutterErrorDetails details) {
    AppException.from(details.exception, details.stack);
  };
  WidgetsFlutterBinding.ensureInitialized();
  await initDI(flavor);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: Center(child: Text('Hello World!'))),
    );
  }
}
