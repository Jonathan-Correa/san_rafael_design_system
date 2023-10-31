import 'package:flutter/material.dart';
import 'package:csr_design_system/csr_design_system.dart';

class CsrLabel extends StatelessWidget {
  const CsrLabel({
    Key? key,
    required this.text,
    this.icon,
    this.alignment = MainAxisAlignment.start,
  }) : super(key: key);

  final String text;
  final Widget? icon;
  final MainAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    final textWidget = Subtitle1(
      text,
      color: ThemeChanger.of(context).isDark ? null : Colors.black,
    );

    if (icon != null) {
      return Row(
        mainAxisAlignment: alignment,
        children: [icon!, textWidget],
      );
    }

    return textWidget;
  }
}
