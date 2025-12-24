import 'package:flutter/material.dart';

import 'service/env/flavor.dart';
import 'view/common/flavor_banner.dart';
import 'view/home/home_screen.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.flavor});
  final Flavor flavor;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      builder: (context, child) {
        return FlavorBanner(flavor: flavor, child: child!);
      },
    );
  }
}
