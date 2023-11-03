import 'package:flutter/material.dart';

import '/csr_design_system.dart';
import '/styles/input_styles.dart';
import '/helpers/responsive_helper.dart';

class CsrConstants {
  // iniciar las variables globales
  static final circularBorder = BorderRadius.circular(8.0);
  static final circularBorderN = BorderRadius.circular(42.0);
  static final btnBorder = BorderRadius.circular(17.0);
  static const circularRadius8 = Radius.circular(8.0);
  static const circularRadius = Radius.circular(37.0);
  static const circularRadiusLg = Radius.circular(48);
  static const sizeLeadingIcon = 0.07;

  static const accentColor = Color(0xff1D9CD8);
  static const primaryColor = Color(0xff582C5F);

// Diseño de tarjetas
  static const double heightImgSmallCard = 180.0;
  static const double widthtImgSmallCard = 120.0;

  static const Color darkThemeTextColor = Color(0xffdedee3);

// Colores Opcionales
  static const optionColorPrimary = Color(0xff76C3E8);
  static const optionColorGrey = Color(0xff808080);

// Otros estilos
  static const sizeBox20 = SizedBox(height: 20.0);
  static const sizeBox8 = SizedBox(height: 8.0);
  static const sizeWBox8 = SizedBox(width: 8.0);
  static const sizeWBox20 = SizedBox(width: 20.0);

  // Input height
  static double inputHeight(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final deviceType = getDeviceType(context);
    return screenSize.width * (deviceType == DeviceType.tablet ? 0.09 : 0.10);
  }

  static Widget dateRangeBuilder(context, child) {
    final theme = Theme.of(context);

    if (ThemeChanger.of(context).isDark) {
      return Theme(
        data: ThemeData.dark().copyWith(
          colorScheme: ColorScheme.dark(
            primary: theme.primaryColor,
            onPrimary: Colors.white,
            surface: theme.colorScheme.background,
            onSurface: Colors.white,
          ),
          canvasColor: theme.colorScheme.background,
          hintColor: Colors.white,
        ),
        child: child!,
      );
    }

    return Theme(
      data: ThemeData.light().copyWith(
        colorScheme: ColorScheme.light(
          primary: theme.colorScheme.primary,
          onPrimary: Colors.white,
          surface: Colors.white,
          onSurface: Colors.black,
        ),
        dialogBackgroundColor: Colors.white,
        hintColor: theme.colorScheme.secondary,
      ),
      child: child!,
    );
  }

  static InputDecoration buildSelectSearchDecoration(context) {
    final theme = Theme.of(context);
    return buildBasicInputDecoration(context).copyWith(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: theme.colorScheme.primary),
        borderRadius: BorderRadius.circular(15.0),
      ),
      prefixIcon: const Icon(Icons.search_outlined),
      contentPadding: const EdgeInsets.only(top: 5),
      hintStyle: const Subtitle1('', bold: false).getTextStyle(context),
    );
  }

  static BoxDecoration buildSedesCardContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).scaffoldBackgroundColor,
      borderRadius: BorderRadius.only(
        topLeft: CsrConstants.circularRadius * 2,
        topRight: CsrConstants.circularRadius * 2,
      ),
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 38,
          offset: Offset(0, 8),
        )
      ],
    );
  }
}
