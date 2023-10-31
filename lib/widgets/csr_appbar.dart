import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:csr_design_system/csr_design_system.dart';

class CsrAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CsrAppBar({
    Key? key,
    this.title,
    this.actions,
    this.onBackPress,
    this.elevation = 3,
  }) : super(key: key);

  final String? title;

  /// Elevación del AppBar
  final double elevation;

  /// Lista de widgets a desplegar en la barra (Iconos)
  final List<Widget>? actions;

  /// Función personalizada para volver a la vista anterior.
  final Function(BuildContext context)? onBackPress;

  @override
  final preferredSize = const Size.fromHeight(
    kToolbarHeight,
  ); // default is 56.0

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sizeScreen = MediaQuery.of(context).size;

    return AppBar(
      centerTitle: true,
      elevation: elevation,
      actions: actions ?? [],
      leadingWidth: double.infinity,
      backgroundColor: theme.scaffoldBackgroundColor,
      title: SvgPicture.asset(
        'assets/icon/logo-simple-icon.svg',
        height: sizeScreen.height * 0.047,
      ),
      leading: Container(
        alignment: Alignment.centerLeft,
        child: TextButton.icon(
          onPressed: onBackPress != null
              ? () => onBackPress!(context)
              : () => Navigator.of(context).maybePop(),
          icon: Icon(
            CSRIcons.angleLeft,
            color: theme.appBarTheme.iconTheme!.color,
          ),
          label: Text(
            'Volver',
            style: theme.appBarTheme.toolbarTextStyle,
          ),
        ),
      ),
    );
  }
}
