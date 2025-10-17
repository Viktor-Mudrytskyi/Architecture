import 'package:architecture_templates/service/env/flavor.dart';
import 'package:architecture_templates/view/common/flavor_banner.dart';
import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.flavor});
  final Flavor flavor;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Center(child: Text('Hello World!'))),
      builder: (context, child) {
        return FlavorBanner(flavor: flavor, child: child!);
      },
    );
  }
}
