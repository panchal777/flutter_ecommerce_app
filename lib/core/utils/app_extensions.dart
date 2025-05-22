import 'package:flutter/material.dart';

extension PaddingExtension on Widget {
  /// Adds padding to any widget using [EdgeInsets]
  Widget withPadding([EdgeInsetsGeometry padding = const EdgeInsets.all(8.0)]) {
    return Padding(padding: padding, child: this);
  }

  /// Adds symmetric padding
  Widget withSymmetricPadding({double horizontal = 0, double vertical = 0}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: this,
    );
  }

  /// Adds only-specific padding
  Widget withOnlyPadding({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: left,
        top: top,
        right: right,
        bottom: bottom,
      ),
      child: this,
    );
  }
}

extension StringCasingExtension on String {
  String capitalizeFirst() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}
