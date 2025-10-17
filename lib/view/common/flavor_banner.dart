import 'package:architecture_templates/core/di.dart';
import 'package:architecture_templates/service/env/env_manager.dart';
import 'package:architecture_templates/service/env/flavor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FlavorBanner extends StatefulWidget {
  const FlavorBanner({super.key, required this.flavor, required this.child});
  final Flavor flavor;
  final Widget child;

  @override
  State<FlavorBanner> createState() => _FlavorBannerState();
}

class _FlavorBannerState extends State<FlavorBanner> {
  final EnvService _envManager = getIt();
  String _label = '';
  bool _isVisible = false;

  @override
  void initState() {
    _isVisible = _envManager.map(
      onDev: () => true,
      onProd: () => !kReleaseMode,
    );
    _label = widget.flavor.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isVisible) {
      return widget.child;
    }
    return Banner(
      location: BannerLocation.topEnd,
      message: _label,
      child: widget.child,
    );
  }
}
