import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/theme_controller.dart';

/// A round text field that has a secondary border color.
class NewsFeedInputField extends StatefulWidget {
  const NewsFeedInputField({
    Key? key,
    required this.onChanged,
    required this.hintText,
    this.isError = false,
    this.inputType,
    this.minLines = 1,
    this.maxLines = 1,
    this.maxLength = 64,
    this.initialText,
    this.controller,
    this.borderWidth = 3,
    this.hintTextSize = 16,
    this.disable = false,
    this.textCapitalization = TextCapitalization.none,
    this.showCounter = false,
  })  : hideText = false,
        super(key: key);

  const NewsFeedInputField.longerInput({
    Key? key,
    required this.onChanged,
    required this.hintText,
    this.isError = false,
    this.inputType,
    this.minLines = 1,
    this.maxLines = 1,
    this.initialText,
    this.controller,
    this.hintTextSize = 16,
    this.disable = false,
    this.textCapitalization = TextCapitalization.none,
    this.maxLength = 512,
    this.showCounter = true,
  })  : hideText = false,
        borderWidth = 3,
        super(key: key);

  const NewsFeedInputField.obscure({
    Key? key,
    required this.onChanged,
    required this.hintText,
    this.isError = false,
    this.inputType,
    this.initialText,
    this.controller,
    this.hintTextSize = 16,
    this.disable = false,
    this.textCapitalization = TextCapitalization.none,
  })  : maxLength = 512,
        borderWidth = 3,
        showCounter = false,
        hideText = true,
        minLines = 1,
        maxLines = 1,
        super(key: key);

  final String? initialText;
  final String hintText;
  final bool isError;
  final int maxLength;
  final TextInputType? inputType;
  final bool hideText;
  final int? minLines;
  final int? maxLines;
  final TextEditingController? controller;
  final double hintTextSize;
  final bool disable;
  final TextCapitalization textCapitalization;
  final bool showCounter;
  final double borderWidth;

  /// [Return] true if there is an error.
  final bool Function(String) onChanged;

  @override
  State<NewsFeedInputField> createState() => _NewsFeedInputFieldState();
}

class _NewsFeedInputFieldState extends State<NewsFeedInputField> {
  late bool _hideText;
  var _hasError = false;

  @override
  void initState() {
    super.initState();
    _hideText = widget.hideText;
  }

  @override
  void dispose() {
    super.dispose();
  }

  _obscureButton() => GestureDetector(
      onTap: () => setState(() => _hideText = !_hideText),
      child: Padding(
          padding: const EdgeInsets.only(right: 30, left: 15),
          child: Icon(_hideText ? Icons.visibility : Icons.visibility_off,
              color: Colors.black)));

  @override
  Widget build(BuildContext context) =>
      GetBuilder<ThemeController>(builder: (_) => _textField());

  TextField _textField() {
    return TextField(
        enabled: !widget.disable,
        controller: widget.controller,
        onChanged: (val) {
          final hasError = widget.onChanged(val.trim());
          if (val.length >= widget.maxLength || hasError) {
            setState(() => _hasError = true);
          } else {
            setState(() => _hasError = false);
          }
        },
        obscureText: _hideText,
        keyboardType: widget.inputType ?? TextInputType.text,
        textCapitalization: widget.textCapitalization,
        style: const TextStyle(
            fontSize: 14 * 1.5,
            fontWeight: FontWeight.normal,
            color: Colors.black),
        maxLength: widget.maxLength,
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        decoration: InputDecoration(
            suffixIcon: widget.hideText ? _obscureButton() : null,
            label: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(widget.hintText,
                    maxLines: 1,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: widget.hintTextSize,
                      color: Colors.black,
                    ))),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            counterText: widget.showCounter ? null : "",
            counterStyle: const TextStyle(color: Colors.black),
            alignLabelWithHint: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            hintStyle: const TextStyle(color: Colors.black),
            enabledBorder: _defaultBorder(),
            focusedBorder: _okayBorder(),
            focusedErrorBorder: _errorBorder(),
            disabledBorder: _defaultBorder(),
            errorBorder: _errorBorder(),
            filled: true,
            fillColor: Colors.white54));
  }

  _defaultBorder() => _hasError || widget.isError
      ? _errorBorder()
      : OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
              width: widget.borderWidth, color: Colors.deepPurpleAccent));

  _okayBorder() => _hasError || widget.isError
      ? _errorBorder()
      : OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide:
              const BorderSide(width: 3, color: Colors.deepPurpleAccent));

  _errorBorder() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(width: 3, color: Colors.red));
}
