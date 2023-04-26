// ignore_for_file: depend_on_referenced_packages

import 'package:app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class AppInputPassword extends StatefulWidget {
  final String? defaultValue;
  final String? label;
  final String name;
  final List<String? Function(String?)>? validators;
  final bool isObstructedText;
  final String? hintText;
  final int maxLines;
  final Widget? prefixIcon;
  final bool isDarkBackground;
  final TextEditingController? textEditingController;
  final InputDecoration? inputDecoration;

  final bool showShadow;

  const AppInputPassword({
    Key? key,
    this.defaultValue,
    this.label,
    required this.name,
    required this.validators,
    this.maxLines = 1,
    this.isDarkBackground = true,
    this.isObstructedText = true,
    this.hintText,
    this.prefixIcon,
    this.showShadow = false,
    this.textEditingController,
    this.inputDecoration,
  }) : super(key: key);

  @override
  State<AppInputPassword> createState() => _AppInputPasswordState();
}

class _AppInputPasswordState extends State<AppInputPassword> {
  bool isObstructedText = true;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      controller: widget.textEditingController,
      name: widget.name,
      initialValue: widget.defaultValue,
      maxLines: widget.maxLines,
      validator: FormBuilderValidators.compose(widget.validators ?? []),
      obscureText: isObstructedText,
      cursorColor: Styles.kPrimaryColor,
      style: kMediumMedium.copyWith(),
      decoration: InputDecoration(
        hintText: widget.hintText ?? "",
        prefixIcon: widget.prefixIcon,
        label: widget.label != null ? Text(widget.label!) : null,
        suffixIconConstraints: const BoxConstraints(
          minWidth: 40,
          minHeight: 20,
          maxHeight: 20,
          maxWidth: 40,
        ),
        suffixIcon: InkWell(
          onTap: () {
            setState(() {
              isObstructedText = !isObstructedText;
            });
          },
          child: ImageIcon(
            AssetImage(
              isObstructedText
                  ? "assets/images/icons/iconHide.png"
                  : "assets/images/icons/iconShow.png",
            ),
            size: 16,
            color: Styles.kActiveGrey,
          ),
        ),
      ),
    );
  }
}

class AppInputPasswordUnderline extends StatefulWidget {
  final String? defaultValue;
  final String? label;
  final String name;
  final List<String? Function(String?)>? validators;
  final bool isObstructedText;
  final String? hintText;
  final int maxLines;
  final Widget? prefixIcon;
  final bool isDarkBackground;
  final TextEditingController? textEditingController;
  final InputDecoration? inputDecoration;

  final bool showShadow;

  const AppInputPasswordUnderline({
    Key? key,
    this.defaultValue,
    this.label,
    required this.name,
    required this.validators,
    this.maxLines = 1,
    this.isDarkBackground = true,
    this.isObstructedText = true,
    this.hintText,
    this.prefixIcon,
    this.showShadow = false,
    this.textEditingController,
    this.inputDecoration,
  }) : super(key: key);

  @override
  State<AppInputPasswordUnderline> createState() =>
      _AppInputPasswordStateUnderline();
}

class _AppInputPasswordStateUnderline extends State<AppInputPasswordUnderline> {
  bool isObstructedText = true;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      controller: widget.textEditingController,
      name: widget.name,
      initialValue: widget.defaultValue,
      maxLines: widget.maxLines,
      validator: FormBuilderValidators.compose(widget.validators ?? []),
      obscureText: isObstructedText,
      cursorColor: Styles.kPrimaryColor,
      style: kMediumMedium.copyWith(),
      decoration: InputDecoration(
        hintText: widget.hintText ?? "",
        counterText: "",
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Styles.kBorderColor),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Styles.kBorderColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Styles.kBorderColor),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Styles.kBorderColor.withOpacity(0.3)),
        ),
        prefixIcon: widget.prefixIcon,
        label: widget.label != null ? Text(widget.label!) : null,
        suffixIconConstraints: const BoxConstraints(
          minWidth: 40,
          minHeight: 20,
          maxHeight: 20,
          maxWidth: 40,
        ),
        suffixIcon: InkWell(
          onTap: () {
            setState(() {
              isObstructedText = !isObstructedText;
            });
          },
          child: Icon(
            isObstructedText ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye,
            color: Styles.kSubTextColor,
            size: 15,
          ),
        ),
      ),
    );
  }
}
