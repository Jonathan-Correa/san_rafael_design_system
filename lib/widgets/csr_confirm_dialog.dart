import 'dart:io';

import 'package:csr_design_system/widgets/csr_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CsrAlertDialog extends StatelessWidget {
  const CsrAlertDialog({
    Key? key,
    required this.content,
    this.modalHeight,
    this.onCancel,
    required this.cancelText,
    required this.confirmText,
    this.onConfirm,
  }) : super(key: key);

  final Widget content;
  final String cancelText;
  final double? modalHeight;
  final String confirmText;
  final void Function(BuildContext context)? onCancel;
  final void Function(BuildContext context)? onConfirm;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenSize = mediaQuery.size;

    bool deviceIsIos = false;

    try {
      deviceIsIos = Platform.isIOS;
    } catch (_) {}

    final modalBody = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Image.asset(
            'assets/icons/logo-csr.png',
            height: screenSize.height * 0.047,
          ),
        ),
        content,
      ],
    );

    if (deviceIsIos) {
      return CupertinoAlertDialog(
        content: modalBody,
        actions: [
          if (onCancel != null)
            CupertinoDialogAction(
              textStyle: const TextStyle(color: Colors.red),
              child: Text(cancelText),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          if (onConfirm != null)
            CupertinoDialogAction(
              child: Text(confirmText),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
        ],
      );
    }

    final theme = Theme.of(context);
    var buttonWidthMultiplier = 0.25;

    if (mediaQuery.textScaleFactor >= 2.0) {
      buttonWidthMultiplier = 0.37;
    } else if (mediaQuery.textScaleFactor >= 1.75) {
      buttonWidthMultiplier = 0.35;
    } else if (mediaQuery.textScaleFactor >= 1.5) {
      buttonWidthMultiplier = 0.3;
    }

    return AlertDialog(
      backgroundColor: theme.scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        if (onCancel != null) ...[
          CsrButton(
            pv: 0,
            color: Colors.grey,
            width: screenSize.width * buttonWidthMultiplier,
            onPressed: () => onCancel!(context),
            text: cancelText,
          ),
          const SizedBox(width: 10)
        ],
        if (onConfirm != null)
          CsrButton(
            pv: 0,
            width: screenSize.width * buttonWidthMultiplier,
            onPressed: () => onConfirm!(context),
            text: confirmText,
            color: Theme.of(context).colorScheme.secondary,
          )
      ],
      content: modalBody,
    );
  }
}
