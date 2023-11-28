library csr_design_system;

import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:csr_design_system/widgets/csr_confirm_dialog.dart';
import 'package:csr_design_system/widgets/csr_scroll_accept_dialog.dart';

class CsrDesign {
  static ThemeData get lightTheme {
    final light = ThemeData.light();
    final appBarTheme = light.appBarTheme;

    const accentColor = Color(0xff1D9CD8);
    const primaryColor = Color(0xff582C5F);
    const backgroundColor = Colors.white;

    return light.copyWith(
      cardColor: Colors.white,
      primaryColor: primaryColor,
      canvasColor: Colors.transparent,
      dialogBackgroundColor: backgroundColor,
      scaffoldBackgroundColor: backgroundColor,
      shadowColor: Colors.grey.withOpacity(0.5),
      textTheme: TextTheme(
        titleLarge: _getTextStyleByColor(Colors.black),
        titleSmall: _getTextStyleByColor(Colors.black),
        bodyLarge: _getTextStyleByColor(Colors.black),
        bodyMedium: _getTextStyleByColor(Colors.black),
        displayLarge: _getTextStyleByColor(Colors.black),
        displayMedium: _getTextStyleByColor(Colors.black87),
        displaySmall: _getTextStyleByColor(Colors.black87),
        headlineLarge: _getTextStyleByColor(Colors.black87),
        headlineMedium: _getTextStyleByColor(Colors.black87),
        headlineSmall: _getTextStyleByColor(Colors.black87),
        bodySmall: _getTextStyleByColor(const Color(0xff808080)),
        titleMedium: const TextStyle(
          fontFamily: 'Cabin',
          color: Color(0xff808080),
        ),
      ),
      iconTheme: const IconThemeData(color: primaryColor),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: appBarTheme.copyWith(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xff808080)),
        actionsIconTheme: const IconThemeData(color: primaryColor),
        toolbarTextStyle: _getTextStyleByColor(const Color(0xffb0b0b0)),
        titleTextStyle: const TextStyle(
          color: Color(0xff808080),
          fontFamily: 'Cabin',
        ),
      ),
      primaryTextTheme: TextTheme(
        bodySmall: const TextStyle(color: primaryColor),
        displayLarge: _getTextStyleByColor(primaryColor),
        displayMedium: _getTextStyleByColor(primaryColor),
        displaySmall: _getTextStyleByColor(primaryColor),
        headlineLarge: _getTextStyleByColor(primaryColor),
        headlineMedium: _getTextStyleByColor(primaryColor),
        headlineSmall: _getTextStyleByColor(primaryColor),
        titleLarge: _getTextStyleByColor(primaryColor),
        titleSmall: _getTextStyleByColor(primaryColor),
        titleMedium: _getTextStyleByColor(primaryColor),
        bodyLarge: _getTextStyleByColor(primaryColor),
        bodyMedium: _getTextStyleByColor(primaryColor),
      ),
      colorScheme: light.colorScheme.copyWith(
        error: Colors.red,
        onPrimary: Colors.black,
        secondary: accentColor,
        primary: primaryColor,
        background: Colors.white,
      ),
    );
  }

  static ThemeData get darkTheme {
    final dark = ThemeData.dark();
    const accentColor = Color(0xff582C5F);
    const primaryColor = Color(0xff1D9CD8);
    const accentTextColor = Color(0xffb0b0b0);
    const darkThemeTextColor = Color(0xffdedee3);
    const backgroundColor = Color.fromARGB(255, 31, 31, 31);

    return dark.copyWith(
      primaryColor: primaryColor,
      canvasColor: Colors.transparent,
      cardColor: const Color(0xff252525),
      shadowColor: const Color(0xff303030),
      scaffoldBackgroundColor: backgroundColor,
      dialogBackgroundColor: backgroundColor,
      textTheme: TextTheme(
        titleLarge: _getTextStyleByColor(darkThemeTextColor),
        titleSmall: _getTextStyleByColor(darkThemeTextColor),
        bodyLarge: _getTextStyleByColor(darkThemeTextColor),
        bodyMedium: _getTextStyleByColor(darkThemeTextColor),
        displayLarge: _getTextStyleByColor(darkThemeTextColor),
        headlineLarge: _getTextStyleByColor(darkThemeTextColor),
        displayMedium: _getTextStyleByColor(darkThemeTextColor),
        displaySmall: _getTextStyleByColor(darkThemeTextColor),
        headlineMedium: _getTextStyleByColor(darkThemeTextColor),
        headlineSmall: _getTextStyleByColor(darkThemeTextColor),
        bodySmall: _getTextStyleByColor(accentTextColor),
        titleMedium: _getTextStyleByColor(darkThemeTextColor),
      ),
      primaryTextTheme: TextTheme(
        bodySmall: const TextStyle(color: darkThemeTextColor),
        displayLarge: _getTextStyleByColor(darkThemeTextColor),
        displayMedium: _getTextStyleByColor(darkThemeTextColor),
        displaySmall: _getTextStyleByColor(darkThemeTextColor),
        headlineLarge: _getTextStyleByColor(darkThemeTextColor),
        headlineMedium: _getTextStyleByColor(darkThemeTextColor),
        headlineSmall: _getTextStyleByColor(darkThemeTextColor),
        titleLarge: _getTextStyleByColor(darkThemeTextColor),
        titleSmall: _getTextStyleByColor(darkThemeTextColor),
        titleMedium: _getTextStyleByColor(darkThemeTextColor),
        bodyLarge: _getTextStyleByColor(darkThemeTextColor),
        bodyMedium: _getTextStyleByColor(darkThemeTextColor),
      ),
      primaryColorDark: Colors.white,
      iconTheme: const IconThemeData(color: primaryColor),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: accentTextColor),
        actionsIconTheme: const IconThemeData(color: primaryColor),
        titleTextStyle: _getTextStyleByColor(const Color(0xff808080)),
        toolbarTextStyle: _getTextStyleByColor(const Color(0xffb0b0b0)),
      ),
      colorScheme: dark.colorScheme.copyWith(
        primary: primaryColor,
        secondary: accentColor,
        onPrimary: Colors.white,
        background: const Color.fromARGB(255, 31, 31, 31),
      ),
    );
  }

  static Future<String?> selectDate(
    BuildContext context, [
    DateTime? firstDate,
    DateTime? lastDate,
    DateTime? initialDate,
  ]) async {
    lastDate ??= DateTime.now();
    // Fecha inicial será la fecha de hace 110 años.
    firstDate ??= DateTime.now().subtract(const Duration(days: 365 * 110));
    initialDate ??= DateTime.now();

    DateTime? selectedDate;
    bool deviceIsIos = false;

    try {
      deviceIsIos = Platform.isIOS;
    } catch (_) {}

    if (deviceIsIos) {
      selectedDate = await _showCupertinoDateDialog(
        context,
        firstDate,
        lastDate,
        initialDate,
      );
    } else {
      selectedDate = await showDatePicker(
        context: context,
        lastDate: lastDate,
        firstDate: firstDate,
        builder: dateBuilder,
        initialDate: initialDate,
      );
    }

    if (selectedDate != null) {
      return toOriginalFormatString(selectedDate);
    }

    return null;
  }

  static Future<String?> selectTime(
    BuildContext context,
  ) async {
    TimeOfDay? selectedTime;
    bool deviceIsIos = false;

    try {
      deviceIsIos = Platform.isIOS;
    } catch (_) {}

    if (deviceIsIos) {
      final time = await _showCupertinoDateDialog(
        context,
        null,
        null,
        null,
        CupertinoDatePickerMode.time,
      );

      if (time == null) return null;
      selectedTime = TimeOfDay(hour: time.hour, minute: time.minute);
    } else {
      selectedTime = await showTimePicker(
        context: context,
        builder: dateBuilder,
        initialTime: TimeOfDay.now(),
      );
    }

    if (selectedTime != null) {
      final hour =
          selectedTime.hour < 10 ? '0${selectedTime.hour}' : selectedTime.hour;

      final minute = selectedTime.minute < 10
          ? '0${selectedTime.minute}'
          : selectedTime.minute;
      return '$hour:$minute';
    }

    return null;
  }

  static Future<bool> showConfirmDialog(
    BuildContext context, {
    required Widget body,
    String confirmText = 'Confirmar',
    String cancelText = 'Cancelar',
    bool barrierDismissible = true,
  }) async {
    bool deviceIsIOS = false;

    try {
      deviceIsIOS = Platform.isIOS;
    } catch (_) {}

    final dialog = CsrAlertDialog(
      content: body,
      cancelText: cancelText,
      confirmText: confirmText,
      onCancel: (context) => Navigator.of(context).pop(false),
      onConfirm: (context) => Navigator.of(context).pop(true),
    );

    if (deviceIsIOS) {
      final response = await showCupertinoDialog<bool>(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) => dialog,
      );

      return response ?? false;
    }

    final response = await showDialog<bool>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => dialog,
    );

    return response ?? false;
  }

  static Future<bool> showScrollAcceptDialog(
    BuildContext context, {
    required Widget title,
    required Widget body,
    String acceptText = 'Si, acepto',
    String declineText = 'No acepto',
    bool barrierDismissible = true,
    bool showActions = true,
  }) async {
    bool deviceIsIOS = false;

    try {
      deviceIsIOS = Platform.isIOS;
    } catch (_) {}

    final dialog = ScrollAcceptDialog(
      body: body,
      title: title,
      acceptText: acceptText,
      showActions: showActions,
      declineText: declineText,
    );

    if (deviceIsIOS) {
      final response = await showCupertinoDialog<bool>(
        context: context,
        builder: (context) => dialog,
        barrierDismissible: barrierDismissible,
      );

      return response ?? false;
    }

    final response = await showDialog<bool>(
      context: context,
      builder: (context) => dialog,
      barrierDismissible: barrierDismissible,
    );

    return response ?? false;
  }
}

Future<DateTime?> _showCupertinoDateDialog(
  BuildContext context, [
  DateTime? firstDate,
  DateTime? lastDate,
  DateTime? initialDate,
  CupertinoDatePickerMode mode = CupertinoDatePickerMode.date,
]) async {
  DateTime? date;

  await showCupertinoModalPopup<DateTime?>(
    context: context,
    builder: (BuildContext context) {
      final mediaQuery = MediaQuery.of(context);
      return Container(
        height: mediaQuery.size.height * 0.3,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: mediaQuery.viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: CupertinoDatePicker(
            minimumDate: firstDate,
            maximumDate: lastDate,
            initialDateTime: initialDate,
            mode: mode,
            dateOrder: DatePickerDateOrder.ymd,
            onDateTimeChanged: (newDate) => date = newDate,
          ),
        ),
      );
    },
  );

  return date;
}

String toOriginalFormatString(DateTime dateTime) {
  final d = dateTime.day.toString().padLeft(2, '0');
  final y = dateTime.year.toString();
  final m = dateTime.month.toString().padLeft(2, '0');
  return '$y-$m-$d';
}

Widget dateBuilder(BuildContext context, Widget? child) {
  final theme = Theme.of(context);

  if (theme.brightness == Brightness.dark) {
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

TextStyle _getTextStyleByColor(Color color) {
  return TextStyle(
    color: color,
    fontFamily: 'Cabin',
  );
}

class _CustomText extends StatelessWidget {
  const _CustomText({
    Key? key,
    required this.text,
    required this.style,
    required this.bold,
    required this.center,
    required this.scaleFactor,
    this.overflow,
    this.maxLines,
    this.color,
    this.shadows,
  }) : super(key: key);

  final bool bold;
  final String text;
  final bool center;
  final Color? color;
  final int? maxLines;
  final TextStyle style;
  final double scaleFactor;
  final List<Shadow>? shadows;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style.copyWith(
        color: color,
        shadows: shadows,
        fontSize: style.fontSize! *
            _ScaleSize.textScaleFactor(
              context,
              maxTextScaleFactor: scaleFactor,
            ),
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      ),
      textAlign: center ? TextAlign.center : null,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

class H4 extends StatelessWidget {
  const H4(
    this.text, {
    super.key,
    this.color,
    this.shadows,
    this.overflow,
    this.maxLines,
    this.bold = true,
    this.center = false,
    this.scaleFactor = 3.5,
  });

  final String text;
  final Color? color;
  final bool bold;
  final bool center;
  final int? maxLines;
  final double scaleFactor;
  final TextOverflow? overflow;
  final List<Shadow>? shadows;

  TextStyle getTextStyle(BuildContext context) {
    final style = Theme.of(context).textTheme.headlineMedium;
    return style!.copyWith(
      color: color,
      shadows: shadows,
      fontSize: style.fontSize! *
          _ScaleSize.textScaleFactor(
            context,
            maxTextScaleFactor: scaleFactor,
          ),
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _CustomText(
      text: text,
      bold: bold,
      color: color,
      center: center,
      shadows: shadows,
      maxLines: maxLines,
      overflow: overflow,
      scaleFactor: scaleFactor,
      style: Theme.of(context).textTheme.headlineMedium!,
    );
  }
}

class H1 extends StatelessWidget {
  const H1(
    this.text, {
    super.key,
    this.color,
    this.shadows,
    this.overflow,
    this.maxLines,
    this.bold = true,
    this.center = false,
    this.scaleFactor = 3.5,
  });

  final String text;
  final Color? color;
  final bool bold;
  final bool center;
  final int? maxLines;
  final double scaleFactor;
  final TextOverflow? overflow;
  final List<Shadow>? shadows;

  TextStyle getTextStyle(BuildContext context) {
    final style = Theme.of(context).textTheme.displayLarge;
    return style!.copyWith(
      color: color,
      shadows: shadows,
      fontSize: style.fontSize! *
          _ScaleSize.textScaleFactor(
            context,
            maxTextScaleFactor: scaleFactor,
          ),
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _CustomText(
      text: text,
      bold: bold,
      color: color,
      center: center,
      shadows: shadows,
      maxLines: maxLines,
      overflow: overflow,
      scaleFactor: scaleFactor,
      style: Theme.of(context).textTheme.displayLarge!,
    );
  }
}

class H2 extends StatelessWidget {
  const H2(
    this.text, {
    super.key,
    this.color,
    this.shadows,
    this.overflow,
    this.maxLines,
    this.bold = true,
    this.center = false,
    this.scaleFactor = 3.5,
  });

  final String text;
  final Color? color;
  final bool bold;
  final bool center;
  final int? maxLines;
  final double scaleFactor;
  final TextOverflow? overflow;
  final List<Shadow>? shadows;

  TextStyle getTextStyle(BuildContext context) {
    final style = Theme.of(context).textTheme.displayMedium;
    return style!.copyWith(
      color: color,
      shadows: shadows,
      fontSize: style.fontSize! *
          _ScaleSize.textScaleFactor(
            context,
            maxTextScaleFactor: scaleFactor,
          ),
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _CustomText(
      text: text,
      bold: bold,
      color: color,
      center: center,
      shadows: shadows,
      maxLines: maxLines,
      overflow: overflow,
      scaleFactor: scaleFactor,
      style: Theme.of(context).textTheme.displayMedium!,
    );
  }
}

class H3 extends StatelessWidget {
  const H3(
    this.text, {
    super.key,
    this.color,
    this.shadows,
    this.overflow,
    this.maxLines,
    this.bold = true,
    this.center = false,
    this.scaleFactor = 3.5,
  });

  final String text;
  final Color? color;
  final bool bold;
  final bool center;
  final int? maxLines;
  final double scaleFactor;
  final TextOverflow? overflow;
  final List<Shadow>? shadows;

  TextStyle getTextStyle(BuildContext context) {
    final style = Theme.of(context).textTheme.displaySmall;
    return style!.copyWith(
      color: color,
      shadows: shadows,
      fontSize: style.fontSize! *
          _ScaleSize.textScaleFactor(
            context,
            maxTextScaleFactor: scaleFactor,
          ),
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _CustomText(
      text: text,
      bold: bold,
      color: color,
      center: center,
      shadows: shadows,
      maxLines: maxLines,
      overflow: overflow,
      scaleFactor: scaleFactor,
      style: Theme.of(context).textTheme.displaySmall!,
    );
  }
}

class H5 extends StatelessWidget {
  const H5(
    this.text, {
    super.key,
    this.color,
    this.shadows,
    this.overflow,
    this.maxLines,
    this.bold = true,
    this.center = false,
    this.scaleFactor = 3.5,
  });

  final String text;
  final Color? color;
  final bool bold;
  final bool center;
  final int? maxLines;
  final double scaleFactor;
  final TextOverflow? overflow;
  final List<Shadow>? shadows;

  TextStyle getTextStyle(BuildContext context) {
    final style = Theme.of(context).textTheme.headlineSmall;
    return style!.copyWith(
      color: color,
      shadows: shadows,
      fontSize: style.fontSize! *
          _ScaleSize.textScaleFactor(
            context,
            maxTextScaleFactor: scaleFactor,
          ),
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _CustomText(
      text: text,
      bold: bold,
      color: color,
      center: center,
      shadows: shadows,
      maxLines: maxLines,
      overflow: overflow,
      scaleFactor: scaleFactor,
      style: Theme.of(context).textTheme.headlineSmall!,
    );
  }
}

class Subtitle1 extends StatelessWidget {
  const Subtitle1(
    this.text, {
    super.key,
    this.color,
    this.shadows,
    this.overflow,
    this.maxLines,
    this.bold = true,
    this.center = false,
    this.scaleFactor = 3.5,
  });

  final String text;
  final Color? color;
  final bool bold;
  final bool center;
  final int? maxLines;
  final double scaleFactor;
  final List<Shadow>? shadows;
  final TextOverflow? overflow;

  TextStyle getTextStyle(BuildContext context) {
    final style = Theme.of(context).textTheme.titleMedium;

    return style!.copyWith(
      color: color,
      shadows: shadows,
      fontSize: style.fontSize! *
          _ScaleSize.textScaleFactor(
            context,
            maxTextScaleFactor: scaleFactor,
          ),
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _CustomText(
      text: text,
      bold: bold,
      color: color,
      center: center,
      shadows: shadows,
      overflow: overflow,
      maxLines: maxLines,
      scaleFactor: scaleFactor,
      style: Theme.of(context).textTheme.titleMedium!,
    );
  }
}

class Subtitle2 extends StatelessWidget {
  const Subtitle2(
    this.text, {
    super.key,
    this.color,
    this.shadows,
    this.overflow,
    this.maxLines,
    this.bold = true,
    this.center = false,
    this.scaleFactor = 3.5,
  });

  final String text;
  final Color? color;
  final bool bold;
  final bool center;
  final int? maxLines;
  final double scaleFactor;
  final List<Shadow>? shadows;
  final TextOverflow? overflow;

  TextStyle getTextStyle(BuildContext context) {
    final style = Theme.of(context).textTheme.titleSmall;

    return style!.copyWith(
      color: color,
      shadows: shadows,
      fontSize: style.fontSize! *
          _ScaleSize.textScaleFactor(
            context,
            maxTextScaleFactor: scaleFactor,
          ),
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _CustomText(
      text: text,
      style: Theme.of(context).textTheme.titleSmall!,
      bold: bold,
      color: color,
      center: center,
      shadows: shadows,
      maxLines: maxLines,
      overflow: overflow,
      scaleFactor: scaleFactor,
    );
  }
}

class Caption extends StatelessWidget {
  const Caption(
    this.text, {
    super.key,
    this.color,
    this.shadows,
    this.maxLines,
    this.overflow,
    this.bold = true,
    this.center = false,
    this.scaleFactor = 3.5,
  });

  final String text;
  final Color? color;
  final bool bold;
  final bool center;
  final int? maxLines;
  final double scaleFactor;
  final List<Shadow>? shadows;
  final TextOverflow? overflow;

  TextStyle getTextStyle(BuildContext context) {
    final style = Theme.of(context).textTheme.bodySmall;

    return style!.copyWith(
      color: color,
      shadows: shadows,
      fontSize: style.fontSize! *
          _ScaleSize.textScaleFactor(
            context,
            maxTextScaleFactor: scaleFactor,
          ),
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _CustomText(
      text: text,
      bold: bold,
      color: color,
      center: center,
      shadows: shadows,
      maxLines: maxLines,
      overflow: overflow,
      scaleFactor: scaleFactor,
      style: Theme.of(context).textTheme.bodySmall!,
    );
  }
}

class H6 extends StatelessWidget {
  const H6(
    this.text, {
    super.key,
    this.color,
    this.shadows,
    this.maxLines,
    this.overflow,
    this.bold = true,
    this.center = false,
    this.scaleFactor = 3.5,
  });

  final String text;
  final Color? color;
  final bool bold;
  final bool center;
  final int? maxLines;
  final double scaleFactor;
  final List<Shadow>? shadows;
  final TextOverflow? overflow;

  TextStyle getTextStyle(BuildContext context) {
    final style = Theme.of(context).textTheme.titleLarge;

    return style!.copyWith(
      color: color,
      shadows: shadows,
      fontSize: style.fontSize! *
          _ScaleSize.textScaleFactor(
            context,
            maxTextScaleFactor: scaleFactor,
          ),
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _CustomText(
      text: text,
      bold: bold,
      color: color,
      center: center,
      shadows: shadows,
      overflow: overflow,
      maxLines: maxLines,
      scaleFactor: scaleFactor,
      style: Theme.of(context).textTheme.titleLarge!,
    );
  }
}

class _ScaleSize {
  static double textScaleFactor(
    BuildContext context, {
    double maxTextScaleFactor = 3.5,
  }) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 1400) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }
}

class ThemeChanger extends InheritedWidget {
  const ThemeChanger({
    Key? key,
    required Widget child,
    required this.changeTheme,
    required this.currentTheme,
  }) : super(key: key, child: child);

  final ThemeMode currentTheme;
  final ValueChanged<ThemeMode> changeTheme;

  bool get isDark => currentTheme == ThemeMode.dark;
  bool get isLight => currentTheme == ThemeMode.light;

  static ThemeChanger of(BuildContext context) {
    return context.findAncestorWidgetOfExactType<ThemeChanger>()!;
  }

  @override
  bool updateShouldNotify(ThemeChanger oldWidget) {
    return oldWidget.currentTheme != currentTheme;
  }
}

class CSRIcons {
  // Oicon Icons
  static const _oiconFam = 'Oicon';
  static const String? _kFontPkg = null;

  static const IconData cloudy = IconData(
    0xe800,
    fontFamily: _oiconFam,
    fontPackage: _kFontPkg,
  );

  static const IconData moon = IconData(
    0xe801,
    fontFamily: _oiconFam,
    fontPackage: _kFontPkg,
  );
  static const IconData sun = IconData(
    0xe802,
    fontFamily: _oiconFam,
    fontPackage: _kFontPkg,
  );

  // CustomIcons icons
  static const String _customFam = 'CustomIcons';
  static const IconData stethoscopeSolid = IconData(
    0xe800,
    fontFamily: _customFam,
    fontPackage: _kFontPkg,
  );

  // Cicon Icons
  static const _ciconFam = 'Cicon';

  static const IconData plataformaSocimedicos =
      IconData(0xe915, fontFamily: _ciconFam);
  static const IconData ajustes = IconData(0xe900, fontFamily: _ciconFam);
  static const IconData changePassword =
      IconData(0xe901, fontFamily: _ciconFam);
  static const IconData colaborador = IconData(0xe902, fontFamily: _ciconFam);
  static const IconData comoLlegar = IconData(0xe903, fontFamily: _ciconFam);
  static const IconData educacionContinua =
      IconData(0xe904, fontFamily: _ciconFam);
  static const IconData eventosAdversos =
      IconData(0xe905, fontFamily: _ciconFam);
  static const IconData familiar = IconData(0xe906, fontFamily: _ciconFam);
  static const IconData horario = IconData(0xe907, fontFamily: _ciconFam);
  static const IconData manualUsuario = IconData(0xe908, fontFamily: _ciconFam);
  static const IconData nuestrasSedes = IconData(0xe909, fontFamily: _ciconFam);
  static const IconData paciente = IconData(0xe90a, fontFamily: _ciconFam);
  static const IconData portafolioServicios =
      IconData(0xe90b, fontFamily: _ciconFam);
  static const IconData quienesSomos = IconData(0xe90c, fontFamily: _ciconFam);
  static const IconData revistaCsr = IconData(0xe90d, fontFamily: _ciconFam);
  static const IconData sanRafaelContigo =
      IconData(0xe90e, fontFamily: _ciconFam);
  static const IconData soporte = IconData(0xe90f, fontFamily: _ciconFam);
  static const IconData soyColaborador =
      IconData(0xe910, fontFamily: _ciconFam);
  static const IconData telefonos = IconData(0xe911, fontFamily: _ciconFam);
  static const IconData tipsSeguridad = IconData(0xe912, fontFamily: _ciconFam);
  static const IconData tutorialInstitucional =
      IconData(0xe913, fontFamily: _ciconFam);
  static const IconData ubicacion = IconData(0xe914, fontFamily: _ciconFam);

  // Uicon Icons
  static const _uiconFam = 'Uicon';
  static const IconData bowling =
      IconData(0xe800, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData box =
      IconData(0xe801, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData boxAlt =
      IconData(0xe802, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData briefcase =
      IconData(0xe803, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData broom =
      IconData(0xe804, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData browser =
      IconData(0xe805, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData brush =
      IconData(0xe806, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData bug =
      IconData(0xe807, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData building =
      IconData(0xe808, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData bulb =
      IconData(0xe809, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData calculator =
      IconData(0xe80a, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData calendar =
      IconData(0xe80b, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData camera =
      IconData(0xe80c, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData caretDown =
      IconData(0xe80d, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData caretLeft =
      IconData(0xe80e, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData caretRight =
      IconData(0xe80f, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData caretUp =
      IconData(0xe810, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData check =
      IconData(0xe811, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData checkbox =
      IconData(0xe812, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData chess =
      IconData(0xe813, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData circle =
      IconData(0xe814, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData circleSmall =
      IconData(0xe815, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData clip =
      IconData(0xe816, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData clock =
      IconData(0xe817, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData cloud =
      IconData(0xe818, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData cloudCheck =
      IconData(0xe819, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData cloudDisabled =
      IconData(0xe81a, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData cloudDownload =
      IconData(0xe81b, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData cloudShare =
      IconData(0xe81c, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData cloudUpload =
      IconData(0xe81d, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData comment =
      IconData(0xe81e, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData commentAlt =
      IconData(0xe81f, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData compress =
      IconData(0xe820, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData compressAlt =
      IconData(0xe821, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData computer =
      IconData(0xe822, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData cookie =
      IconData(0xe823, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData copy =
      IconData(0xe824, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData copyAlt =
      IconData(0xe825, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData copyright =
      IconData(0xe826, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData cream =
      IconData(0xe827, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData creditCard =
      IconData(0xe828, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData cross =
      IconData(0xe829, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData crossCircle =
      IconData(0xe82a, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData crossSmall =
      IconData(0xe82b, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData crown =
      IconData(0xe82c, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData cursor =
      IconData(0xe82d, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData cursorFinger =
      IconData(0xe82e, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData cursorPlus =
      IconData(0xe82f, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData cursorText =
      IconData(0xe830, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData cursorTextAlt =
      IconData(0xe831, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData dart =
      IconData(0xe832, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData dashboard =
      IconData(0xe833, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData database =
      IconData(0xe834, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData dataTransfer =
      IconData(0xe835, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData delete =
      IconData(0xe836, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData diamond =
      IconData(0xe837, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData dice =
      IconData(0xe838, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData diploma =
      IconData(0xe839, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData disk =
      IconData(0xe83a, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData doctor =
      IconData(0xe83b, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData document =
      IconData(0xe83c, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData documentSigned =
      IconData(0xe83d, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData dollar =
      IconData(0xe83e, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData download =
      IconData(0xe83f, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData duplicate =
      IconData(0xe840, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData earnings =
      IconData(0xe841, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData edit =
      IconData(0xe842, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData editAlt =
      IconData(0xe843, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData eLearning =
      IconData(0xe844, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData envelope =
      IconData(0xe845, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData euro =
      IconData(0xe846, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData exclamation =
      IconData(0xe847, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData expand =
      IconData(0xe848, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData eye =
      IconData(0xe849, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData eyeCrossed =
      IconData(0xe84a, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData eyeDropper =
      IconData(0xe84b, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData feather =
      IconData(0xe84c, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData file =
      IconData(0xe84d, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData fileAdd =
      IconData(0xe84e, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData fileAi =
      IconData(0xe84f, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData fileCheck =
      IconData(0xe850, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData fileDelete =
      IconData(0xe851, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData fileEps =
      IconData(0xe852, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData fileGif =
      IconData(0xe853, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData fileMusic =
      IconData(0xe854, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData filePsd =
      IconData(0xe855, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData fill =
      IconData(0xe856, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData film =
      IconData(0xe857, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData filter =
      IconData(0xe858, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData fingerprint =
      IconData(0xe859, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData flag =
      IconData(0xe85a, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData flame =
      IconData(0xe85b, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData flipHorizontal =
      IconData(0xe85c, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData folder =
      IconData(0xe85d, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData folderAdd =
      IconData(0xe85e, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData following =
      IconData(0xe85f, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData football =
      IconData(0xe860, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData form =
      IconData(0xe861, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData forward =
      IconData(0xe862, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData ftp =
      IconData(0xe863, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData gallery =
      IconData(0xe864, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData glasses =
      IconData(0xe865, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData globe =
      IconData(0xe866, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData globeAlt =
      IconData(0xe867, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData golf =
      IconData(0xe868, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData graduationCap =
      IconData(0xe869, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData graphicTablet =
      IconData(0xe86a, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData grid =
      IconData(0xe86b, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData gridAlt =
      IconData(0xe86c, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData gym =
      IconData(0xe86d, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData headphones =
      IconData(0xe86e, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData headset =
      IconData(0xe86f, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData heart =
      IconData(0xe870, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData home =
      IconData(0xe871, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData hourglass =
      IconData(0xe872, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData hourglassEnd =
      IconData(0xe873, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData iceSkate =
      IconData(0xe874, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData idBadge =
      IconData(0xe875, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData inbox =
      IconData(0xe876, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData incognito =
      IconData(0xe877, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData indent =
      IconData(0xe878, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData infinity =
      IconData(0xe879, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData info =
      IconData(0xe87a, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData interactive =
      IconData(0xe87b, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData interlining =
      IconData(0xe87c, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData interrogation =
      IconData(0xe87d, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData italic =
      IconData(0xe87e, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData jpg =
      IconData(0xe87f, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData key =
      IconData(0xe880, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData keyboard =
      IconData(0xe881, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData label =
      IconData(0xe882, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData laptop =
      IconData(0xe883, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData lasso =
      IconData(0xe884, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData layers =
      IconData(0xe885, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData layoutFluid =
      IconData(0xe886, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData letterCase =
      IconData(0xe887, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData lifeRing =
      IconData(0xe888, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData lineWidth =
      IconData(0xe889, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData link =
      IconData(0xe88a, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData lipstick =
      IconData(0xe88b, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData list =
      IconData(0xe88c, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData listCheck =
      IconData(0xe88d, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData locationAlt =
      IconData(0xe88e, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData lock =
      IconData(0xe88f, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData lockAlt =
      IconData(0xe890, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData magicWand =
      IconData(0xe891, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData makeupBrush =
      IconData(0xe892, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData marker =
      IconData(0xe893, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData markerTime =
      IconData(0xe894, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData medicine =
      IconData(0xe895, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData megaphone =
      IconData(0xe896, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData microphone =
      IconData(0xe89a, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData mobile =
      IconData(0xe89d, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData modeLandscape =
      IconData(0xe89e, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData modePortrait =
      IconData(0xe89f, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData money =
      IconData(0xe8a0, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData mouse =
      IconData(0xe8a1, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData music =
      IconData(0xe8a2, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData musicAlt =
      IconData(0xe8a3, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData network =
      IconData(0xe8a4, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData networkCloud =
      IconData(0xe8a5, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData notebook =
      IconData(0xe8a6, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData opacity =
      IconData(0xe8a7, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData package =
      IconData(0xe8a8, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData paintBrush =
      IconData(0xe8a9, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData palette =
      IconData(0xe8aa, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData paperPlane =
      IconData(0xe8ab, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData password =
      IconData(0xe8ac, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData pause =
      IconData(0xe8ad, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData pencil =
      IconData(0xe8ae, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData pharmacy =
      IconData(0xe8af, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData physics =
      IconData(0xe8b0, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData picture =
      IconData(0xe8b1, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData pingPong =
      IconData(0xe8b2, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData play =
      IconData(0xe8b3, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData playAlt =
      IconData(0xe8b4, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData playingCards =
      IconData(0xe8b5, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData plus =
      IconData(0xe8b6, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData plusSmall =
      IconData(0xe8b7, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData pokerChip =
      IconData(0xe8b8, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData portrait =
      IconData(0xe8b9, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData pound =
      IconData(0xe8ba, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData power =
      IconData(0xe8bb, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData presentation =
      IconData(0xe8bc, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData print =
      IconData(0xe8bd, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData protractor =
      IconData(0xe8be, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData pulse =
      IconData(0xe8bf, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData quoteRight =
      IconData(0xe8c0, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData rec =
      IconData(0xe8c1, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData receipt =
      IconData(0xe8c2, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData rectangleHorizontal =
      IconData(0xe8c3, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData rectanglePanoramic =
      IconData(0xe8c4, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData rectangleVertical =
      IconData(0xe8c5, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData redo =
      IconData(0xe8c6, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData reflect =
      IconData(0xe8c7, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData refresh =
      IconData(0xe8c8, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData resize =
      IconData(0xe8c9, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData resources =
      IconData(0xe8ca, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData rewind =
      IconData(0xe8cb, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData rocket =
      IconData(0xe8cc, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData rotateRight =
      IconData(0xe8cd, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData rugby =
      IconData(0xe8ce, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData scale =
      IconData(0xe8cf, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData school =
      IconData(0xe8d0, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData schoolBus =
      IconData(0xe8d1, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData scissors =
      IconData(0xe8d2, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData screen =
      IconData(0xe8d3, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData search =
      IconData(0xe8d4, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData searchAlt =
      IconData(0xe8d5, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData settings =
      IconData(0xe8d6, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData settingsSliders =
      IconData(0xe8d7, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData share =
      IconData(0xe8d8, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData shield =
      IconData(0xe8d9, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData shieldCheck =
      IconData(0xe8da, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData shieldExclamation =
      IconData(0xe8db, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData shieldInterrogation =
      IconData(0xe8dc, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData shieldPlus =
      IconData(0xe8dd, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData shop =
      IconData(0xe8de, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData shoppingBag =
      IconData(0xe8df, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData shoppingBagAdd =
      IconData(0xe8e0, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData shoppingCart =
      IconData(0xe8e1, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData shoppingCartAdd =
      IconData(0xe8e2, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData shoppingCartCheck =
      IconData(0xe8e3, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData shuffle =
      IconData(0xe8e4, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData signalAlt =
      IconData(0xe8e5, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData signalAlt1 =
      IconData(0xe8e6, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData signalAlt2 =
      IconData(0xe8e7, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData signIn =
      IconData(0xe8e8, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData signOut =
      IconData(0xe8e9, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData skateboard =
      IconData(0xe8ea, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData smartphone =
      IconData(0xe8eb, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData soap =
      IconData(0xe8ec, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData spa =
      IconData(0xe8ed, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData speaker =
      IconData(0xe8ee, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData spinner =
      IconData(0xe8ef, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData spinnerAlt =
      IconData(0xe8f0, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData square =
      IconData(0xe8f1, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData squareRoot =
      IconData(0xe8f2, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData star =
      IconData(0xe8f3, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData stats =
      IconData(0xe8f4, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData stethoscope =
      IconData(0xe8f5, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData sticker =
      IconData(0xe8f6, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData stop =
      IconData(0xe8f7, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData stopwatch =
      IconData(0xe8f8, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData subtitles =
      IconData(0xe8f9, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData surfing =
      IconData(0xe8fa, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData sword =
      IconData(0xe8fb, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData syringe =
      IconData(0xe8fc, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData tablet =
      IconData(0xe8fd, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData target =
      IconData(0xe8fe, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData tennis =
      IconData(0xe8ff, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData test =
      IconData(0xe900, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData testTube =
      IconData(0xe901, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData text =
      IconData(0xe902, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData textCheck =
      IconData(0xe903, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData thumbsDown =
      IconData(0xe904, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData thumbsUp =
      IconData(0xe905, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData ticket =
      IconData(0xe906, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData timeAdd =
      IconData(0xe907, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData timeCheck =
      IconData(0xe908, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData timeDelete =
      IconData(0xe909, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData timeFast =
      IconData(0xe90a, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData timeForward =
      IconData(0xe90b, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData timeForwardSixty =
      IconData(0xe90c, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData timeForwardTen =
      IconData(0xe90d, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData timeHalfPast =
      IconData(0xe90e, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData timeOclock =
      IconData(0xe90f, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData timePast =
      IconData(0xe910, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData timeQuarterPast =
      IconData(0xe911, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData timeQuarterTo =
      IconData(0xe912, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData timeTwentyFour =
      IconData(0xe913, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData toolCrop =
      IconData(0xe914, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData toolMarquee =
      IconData(0xe915, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData tooth =
      IconData(0xe916, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData transform =
      IconData(0xe917, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData trash =
      IconData(0xe918, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData treatment =
      IconData(0xe919, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData trophy =
      IconData(0xe91a, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData umbrella =
      IconData(0xe91b, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData underline =
      IconData(0xe91c, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData undo =
      IconData(0xe91d, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData unlock =
      IconData(0xe91e, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData upload =
      IconData(0xe91f, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData usbDrive =
      IconData(0xe920, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData user =
      IconData(0xe921, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData userAdd =
      IconData(0xe922, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData userDelete =
      IconData(0xe923, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData userRemove =
      IconData(0xe924, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData users =
      IconData(0xe925, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData userTime =
      IconData(0xe926, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData vector =
      IconData(0xe927, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData vectorAlt =
      IconData(0xe928, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData videoCamera =
      IconData(0xe929, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData volleyball =
      IconData(0xe92a, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData volume =
      IconData(0xe92b, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData wifiAlt =
      IconData(0xe92c, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData world =
      IconData(0xe92d, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData yen =
      IconData(0xe92e, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData zoomIn =
      IconData(0xe92f, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData zoomOut =
      IconData(0xe930, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData add =
      IconData(0xe931, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData alarmClock =
      IconData(0xe932, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData alignCenter =
      IconData(0xe933, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData alignJustify =
      IconData(0xe934, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData alignLeft =
      IconData(0xe935, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData alignRight =
      IconData(0xe936, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData ambulance =
      IconData(0xe937, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData angleDoubleLeft =
      IconData(0xe938, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData angleDoubleRight =
      IconData(0xe939, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData angleDoubleSmallLeft =
      IconData(0xe93a, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData angleDoubleSmallRight =
      IconData(0xe93b, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData angleDown =
      IconData(0xe93c, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData angleLeft =
      IconData(0xe93d, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData angleRight =
      IconData(0xe93e, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData angleSmallDown =
      IconData(0xe93f, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData angleSmallLeft =
      IconData(0xe940, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData angleSmallRight =
      IconData(0xe941, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData angleSmallUp =
      IconData(0xe942, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData angleUp =
      IconData(0xe943, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData apps =
      IconData(0xe944, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData appsAdd =
      IconData(0xe945, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData appsDelete =
      IconData(0xe946, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData appsSort =
      IconData(0xe947, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData archive =
      IconData(0xe948, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData arrowDown =
      IconData(0xe949, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData arrowLeft =
      IconData(0xe94a, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData arrowRight =
      IconData(0xe94b, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData arrowSmallDown =
      IconData(0xe94c, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData arrowSmallLeft =
      IconData(0xe94d, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData arrowSmallRight =
      IconData(0xe94e, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData arrowSmallUp =
      IconData(0xe94f, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData arrowUp =
      IconData(0xe950, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData asterisk =
      IconData(0xe951, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData backpack =
      IconData(0xe952, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData badge =
      IconData(0xe953, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData ban =
      IconData(0xe954, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData bandAid =
      IconData(0xe955, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData bank =
      IconData(0xe956, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData barberShop =
      IconData(0xe957, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData baseball =
      IconData(0xe958, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData basketball =
      IconData(0xe959, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData bell =
      IconData(0xe95a, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData bellRing =
      IconData(0xe95b, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData bellSchool =
      IconData(0xe95c, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData billiard =
      IconData(0xe95d, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData bold =
      IconData(0xe95e, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData book =
      IconData(0xe95f, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData bookAlt =
      IconData(0xe960, fontFamily: _uiconFam, fontPackage: _kFontPkg);
  static const IconData bookmark =
      IconData(0xe961, fontFamily: _uiconFam, fontPackage: _kFontPkg);
}
