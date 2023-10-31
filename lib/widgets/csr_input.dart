import 'package:flutter/material.dart';

import '/config/constants.dart';
import '/widgets/csr_label.dart';
import '/csr_design_system.dart';
import '/styles/input_styles.dart';
import '/helpers/form_helper.dart' as form_helper;

class CsrInput extends StatefulWidget {
  final bool readOnly;
  final String? title;
  final bool required;
  final bool hideText;
  final String? label;
  final double? height;
  final bool isLast;
  final Icon? labelIcon;
  final bool? background;
  final bool? enableInput;
  final String? placeholder;
  final void Function()? onTap;
  final TextInputType? textType;
  final double? labelHeightSpace;
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final MainAxisAlignment? labelAlignment;
  final String? Function(String? value)? validate;
  final void Function(String value)? onFieldSumitted;

  const CsrInput({
    Key? key,
    this.label,
    this.title,
    this.onTap,
    this.height,
    this.validate,
    this.onChanged,
    this.labelIcon,
    this.background,
    this.enableInput,
    this.placeholder,
    this.labelAlignment,
    this.isLast = false,
    this.required = true,
    this.onFieldSumitted,
    this.labelHeightSpace,
    this.hideText = false,
    this.readOnly = false,
    required this.controller,
    this.textType = TextInputType.text,
  }) : super(key: key);

  @override
  State<CsrInput> createState() => _InputState();
}

class _InputState extends State<CsrInput>
    with AutomaticKeepAliveClientMixin<CsrInput> {
  @override
  bool get wantKeepAlive => true;
  bool isPasswordVisible = false;
  late FocusNode _focusNode;

  bool get isDescriptionInput => widget.textType == TextInputType.multiline;
  TextInputAction get inputAction {
    return widget.isLast ? TextInputAction.done : TextInputAction.next;
  }

  bool _hasError = false;
  late Size _screenSize;
  late SizedBox _heightSpace;
  late double _defaultInputHeight;

  @override
  void initState() {
    _focusNode = FocusNode();

    if (!widget.isLast) {
      widget.controller.addListener(_controllerListener);
    }

    super.initState();
  }

  @override
  void didChangeDependencies() {
    _defaultInputHeight = CsrConstants.inputHeight(context);
    _screenSize = MediaQuery.of(context).size;
    _heightSpace = SizedBox(
      height: widget.labelHeightSpace ?? _screenSize.width * 0.05,
    );

    super.didChangeDependencies();
  }

  /// Listener que se ejecuta cuando el usuario digita las primeras 2 letras
  /// en el input, se hace un setState con el objetivo que el input pueda leer un contexto
  /// mas actualizado, el cual servirá para poder redireccionar al siguiente input
  /// cuando el usuario presione la tecla ENTER en su teclado.
  /// La redirección al siguiente input se realiza con la línea [FocusScope.of(context).nextFocus()]
  void _controllerListener() {
    if (widget.controller.text.length < 2) {
      setState(() {});
    } else {
      widget.controller.removeListener(_controllerListener);
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();

    try {
      widget.controller.removeListener(_controllerListener);
    } catch (_) {}

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final input = SizedBox(
      height: (widget.height ?? _defaultInputHeight) + (_hasError ? 20 : 0),
      child: TextFormField(
        onTap: () {
          _focusNode.requestFocus();
          if (widget.onTap != null) widget.onTap!();
        },
        focusNode: _focusNode,
        readOnly: widget.readOnly,
        validator: (value) {
          String? message;

          if (widget.validate != null) {
            message = widget.validate!(value);
          } else if (widget.required) {
            message = form_helper.requiredValue(context, value);
          }

          final isInvalid = message != null;
          if (_hasError != isInvalid) setState(() => _hasError = isInvalid);

          return message;
        },
        onChanged: widget.onChanged,
        enabled: widget.enableInput,
        textInputAction: inputAction,
        controller: widget.controller,
        keyboardType: widget.textType,
        minLines: isDescriptionInput ? 5 : 1,
        maxLines: isDescriptionInput ? 8 : 1,
        onFieldSubmitted: (value) {
          if (!widget.isLast) {
            FocusScope.of(context).nextFocus();
          }

          if (widget.onFieldSumitted != null) {
            widget.onFieldSumitted!(value);
          }
        },
        decoration: buildInputDecoration(context),
        obscureText: widget.hideText ? !isPasswordVisible : isPasswordVisible,
        style: const Subtitle1('', bold: false).getTextStyle(context),
      ),
    );

    if (widget.label != null) {
      return Column(
        children: [
          _heightSpace,
          Row(
            mainAxisAlignment:
                widget.labelAlignment ?? MainAxisAlignment.center,
            children: [
              if (widget.labelIcon != null) widget.labelIcon!,
              if (widget.labelIcon != null) const SizedBox(width: 3),
              CsrLabel(text: widget.label!)
            ],
          ),
          input,
        ],
      );
    }

    return input;
  }

  InputDecoration buildInputDecoration(BuildContext context) {
    Widget suffixIcon = Container(width: 0);
    final theme = Theme.of(context);

    final disabledColor = theme.brightness == Brightness.light
        ? const Color.fromARGB(255, 224, 224, 224)
        : const Color.fromARGB(255, 79, 79, 79);

    if (widget.hideText && widget.controller.text.isNotEmpty) {
      suffixIcon = IconButton(
        icon: isPasswordVisible
            ? const Icon(CSRIcons.eyeCrossed)
            : const Icon(CSRIcons.eye),
        onPressed: () => setState(
          () => isPasswordVisible = !isPasswordVisible,
        ),
      );
    } else if (!widget.hideText &&
        widget.controller.text.isNotEmpty &&
        !widget.readOnly) {
      suffixIcon = IconButton(
        icon: const Icon(CSRIcons.crossSmall),
        onPressed: () => widget.controller.clear(),
      );
    }

    return buildBasicInputDecoration(context).copyWith(
      hintText: widget.placeholder,
      contentPadding: EdgeInsets.fromLTRB(
        20,
        isDescriptionInput ? 8 : 0,
        0,
        isDescriptionInput ? 8 : 0,
      ),
      filled: widget.background,
      fillColor: widget.readOnly ? disabledColor : null,
      suffixIcon: suffixIcon,
    );
  }
}
