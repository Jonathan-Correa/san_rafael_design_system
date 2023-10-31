import 'package:flutter/material.dart';

import '/config/constants.dart';
import '/csr_design_system.dart';

InputDecoration buildBasicInputDecoration(BuildContext context) {
  final theme = Theme.of(context);

  return InputDecoration(
    errorMaxLines: 2,
    fillColor: Theme.of(context).scaffoldBackgroundColor,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: theme.primaryColor),
      borderRadius: CsrConstants.circularBorderN,
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: ThemeChanger.of(context).isDark
            ? theme.colorScheme.primary
            : theme.colorScheme.secondary,
        width: 2,
      ),
      borderRadius: CsrConstants.circularBorderN,
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red, width: 2),
      borderRadius: CsrConstants.circularBorderN,
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red, width: 2),
      borderRadius: CsrConstants.circularBorderN,
    ),
    border: InputBorder.none,
  );
}
