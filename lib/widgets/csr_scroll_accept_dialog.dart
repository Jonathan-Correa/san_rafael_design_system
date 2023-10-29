import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:csr_design_system/csr_design_system.dart';

class ScrollAcceptDialog extends StatefulWidget {
  final bool showActions;
  final Widget title;
  final Widget body;
  final String acceptText;
  final String declineText;

  const ScrollAcceptDialog({
    Key? key,
    this.showActions = false,
    required this.acceptText,
    required this.declineText,
    required this.title,
    required this.body,
  }) : super(key: key);

  @override
  State<ScrollAcceptDialog> createState() => _ScrollAcceptDialogState();
}

class _ScrollAcceptDialogState extends State<ScrollAcceptDialog> {
  late ScrollController _scrollController;

  bool _deviceIsIos = false;

  @override
  void initState() {
    try {
      _deviceIsIos = Platform.isIOS;
    } catch (_) {}

    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_deviceIsIos) {
      return _CupertinoDialog(
        body: widget.body,
        title: widget.title,
        acceptText: widget.acceptText,
        declineText: widget.declineText,
        showActions: widget.showActions,
        scrollController: _scrollController,
      );
    }

    return _AndroidDialog(
      title: widget.title,
      body: widget.body,
      acceptText: widget.acceptText,
      showActions: widget.showActions,
      declineText: widget.declineText,
      scrollController: _scrollController,
    );
  }
}

class _AndroidDialog extends StatelessWidget {
  const _AndroidDialog({
    Key? key,
    required this.title,
    required this.body,
    this.showActions = true,
    required this.acceptText,
    required this.declineText,
    required this.scrollController,
  }) : super(key: key);

  final Widget title;
  final Widget body;
  final bool showActions;
  final String acceptText;
  final String declineText;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      title: title,
      content: SizedBox(
        height: screenSize.height * 0.6,
        width: screenSize.width,
        child: SingleChildScrollView(
          controller: scrollController,
          child: body,
        ),
      ),
      actions: showActions
          ? [
              _AndroidDialogAcceptButton(
                text: acceptText,
                scrollController: scrollController,
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                style: ButtonStyle(
                  shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                    (states) {
                      return RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                        side: BorderSide(color: theme.primaryColor),
                      );
                    },
                  ),
                ),
                child: Subtitle1(
                  declineText,
                  color: theme.primaryColor,
                  bold: false,
                ),
              ),
            ]
          : null,
    );
  }
}

class _AndroidDialogAcceptButton extends StatefulWidget {
  const _AndroidDialogAcceptButton({
    Key? key,
    required this.text,
    required this.scrollController,
  }) : super(key: key);

  final String text;
  final ScrollController scrollController;

  @override
  State<_AndroidDialogAcceptButton> createState() =>
      _AndroidDialogAcceptButtonState();
}

class _AndroidDialogAcceptButtonState
    extends State<_AndroidDialogAcceptButton> {
  bool _enableAcceptButton = false;

  @override
  void initState() {
    widget.scrollController.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    if (widget.scrollController.position.pixels >=
        widget.scrollController.position.maxScrollExtent - 200) {
      setState(() => _enableAcceptButton = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (states) {
            if (states.contains(MaterialState.disabled)) {
              return theme.primaryColor.withOpacity(0.5);
            }

            return theme.primaryColor;
          },
        ),
      ),
      onPressed:
          _enableAcceptButton ? () => Navigator.of(context).pop(true) : null,
      child: Subtitle1(
        widget.text,
        color: Colors.white,
        bold: false,
      ),
    );
  }
}

class _IosDialogAcceptButton extends StatefulWidget {
  const _IosDialogAcceptButton({
    Key? key,
    required this.text,
    required this.scrollController,
  }) : super(key: key);

  final String text;
  final ScrollController scrollController;

  @override
  State<_IosDialogAcceptButton> createState() => _IosDialogAcceptButtonState();
}

class _IosDialogAcceptButtonState extends State<_IosDialogAcceptButton> {
  bool _enableAcceptButton = false;

  @override
  void initState() {
    widget.scrollController.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    if (widget.scrollController.position.pixels >=
        widget.scrollController.position.maxScrollExtent - 200) {
      setState(() => _enableAcceptButton = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoDialogAction(
      onPressed: _enableAcceptButton
          ? () {
              Navigator.of(context).pop(true);
            }
          : null,
      child: Text(widget.text),
    );
  }
}

class _CupertinoDialog extends StatelessWidget {
  const _CupertinoDialog({
    Key? key,
    required this.body,
    required this.title,
    required this.acceptText,
    required this.showActions,
    required this.declineText,
    required this.scrollController,
  }) : super(key: key);

  final Widget body;
  final Widget title;
  final bool showActions;
  final String acceptText;
  final String declineText;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return CupertinoAlertDialog(
      title: title,
      content: SizedBox(
        height: screenSize.height * 0.6,
        child: SingleChildScrollView(
          controller: scrollController,
          child: body,
        ),
      ),
      actions: showActions
          ? [
              CupertinoDialogAction(
                textStyle: const TextStyle(color: Colors.red),
                child: Text(declineText),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              _IosDialogAcceptButton(
                text: acceptText,
                scrollController: scrollController,
              ),
            ]
          : [],
    );
  }
}
