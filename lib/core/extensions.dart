import 'dart:ui';

import 'package:flutter/material.dart';

extension ContextUtils on BuildContext {
  // AppLocalizations get tr => AppLocalizations.of(this)!;
  bool get isLtr => Directionality.of(this) == TextDirection.ltr;
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  ThemeData get theme => Theme.of(this);
  EdgeInsets get padding => MediaQuery.paddingOf(this);
  FlutterView get view => View.of(this);
  Size get size => MediaQuery.sizeOf(this);
  double get width => size.width;
  double get height => size.height;

  void removeFocus() {
    final FocusScopeNode currentScope = FocusScope.of(this);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  RenderBox? get renderBox {
    final RenderObject? box = findRenderObject();

    if (box == null || box is! RenderBox) {
      return null;
    }
    return box;
  }
}

extension Nullabilty on Object? {
  bool get isNull => this == null;
  bool get isNotNull => this != null;
}

extension ListEmptiness on List<dynamic>? {
  bool get isNullOrEmpty => (this ?? []).isEmpty;
  bool get isNotNullOrEmpty => (this ?? []).isNotEmpty;
}

extension StrngEmptiness on String? {
  bool get isNullOrEmpty {
    return (this ?? '').isEmpty;
  }

  bool get isNotNullOrEmpty {
    return (this ?? '').isNotEmpty;
  }

  bool get isNullOrEmptyTrim {
    return (this ?? '').trim().isEmpty;
  }

  bool get isNotNullOrEmptyTrim {
    return (this ?? '').trim().isNotEmpty;
  }
}

extension StringCappitalization on String {
  String firstLetterCapital() {
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }

  String allLetterSmaller() {
    return this[0].toLowerCase() + substring(1).toLowerCase();
  }
}
