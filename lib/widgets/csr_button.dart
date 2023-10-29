import 'package:flutter/material.dart';
import 'package:csr_design_system/csr_design_system.dart';

class CsrButton extends StatelessWidget {
  final Widget? icon;
  final double pv; // Padding vertical
  final Color color;
  final String text;
  final double? width;
  final bool? isLoading;
  final EdgeInsets? margin;
  final void Function()? onPressed;

  const CsrButton({
    Key? key,
    this.icon,
    this.width,
    this.margin,
    this.pv = 10.0,
    required this.text,
    required this.color,
    this.isLoading = false,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;
    final button = icon != null || isLoading == true
        ? _getButtonWithIcon(context)
        : _getNormalButton(context);

    return Container(
      padding: margin ??
          EdgeInsets.symmetric(
            vertical: sizeScreen.width * 0.022,
          ),
      width: width ?? sizeScreen.width,
      child: button,
    );
  }

  ElevatedButton _getButtonWithIcon(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return ElevatedButton.icon(
      icon: Container(
        margin: const EdgeInsets.only(right: 5),
        height: screenSize.width * 0.057,
        width: screenSize.width * 0.055,
        child: Center(
          child: isLoading == true
              ? const CircularProgressIndicator(color: Colors.white)
              : icon!,
        ),
      ),
      label: Text(text),
      style: _getButtonStyle(context),
      onPressed: onPressed,
    );
  }

  ElevatedButton _getNormalButton(BuildContext context) {
    return ElevatedButton(
      style: _getButtonStyle(context),
      onPressed: onPressed,
      child: Text(text),
    );
  }

  ButtonStyle _getButtonStyle(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return ButtonStyle(
      foregroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          return Colors.white;
        },
      ),
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) {
            return color;
          } else if (states.contains(MaterialState.disabled)) {
            return color.withOpacity(0.8);
          }

          return color;
        },
      ),
      padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>((states) {
        return EdgeInsets.symmetric(vertical: pv);
      }),
      textStyle: MaterialStateProperty.resolveWith<TextStyle>((states) {
        if (mediaQuery.textScaleFactor >= 2.5) {
          return const Caption('', color: Colors.white).getTextStyle(context);
        }

        if (mediaQuery.textScaleFactor >= 2.0) {
          return const Subtitle2('', color: Colors.white).getTextStyle(context);
        }

        return const Subtitle1('', color: Colors.white).getTextStyle(context);
      }),
      shape: MaterialStateProperty.resolveWith<OutlinedBorder>((states) {
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(17.0),
        );
      }),
    );
  }
}
