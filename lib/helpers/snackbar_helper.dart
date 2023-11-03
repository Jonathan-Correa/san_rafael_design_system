import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '/csr_design_system.dart';

void csrSuccessSnackBar(
  BuildContext context,
  String message, [
  IconData icon = Icons.check,
  int duration = 5,
]) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  csrSnackBar(context, message, Colors.green, icon, duration);
}

void csrErrorSnackBar(
  BuildContext context,
  String message, [
  IconData icon = Icons.error,
  int duration = 10,
]) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  csrSnackBar(
    context,
    message,
    Theme.of(context).colorScheme.error,
    icon,
    duration,
  );
}

void csrSnackBar(
  BuildContext context,
  String text,
  Color color,
  IconData icon, [
  int duration = 3,
]) {
  final sizeScreen = MediaQuery.of(context).size;

  final snackBar = SnackBar(
    elevation: 5,
    behavior: SnackBarBehavior.floating,
    duration: Duration(seconds: duration),
    backgroundColor: color.withOpacity(0.7),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    content: Stack(children: [
      Positioned(
        right: 5,
        child: SvgPicture.asset(
          'assets/icon/Logo.svg',
          color: Colors.white.withOpacity(0.4),
          width: 23,
          height: 23,
        ),
      ),
      Row(
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(width: sizeScreen.width * 0.05),
          Expanded(
            child: Subtitle1(text, color: Colors.white, bold: false),
          )
        ],
      )
    ]),
  );

  try {
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  } catch (e) {
    // Error al mostrar mensaje
  }
}
