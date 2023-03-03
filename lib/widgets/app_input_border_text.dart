import 'package:app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class AppInputTextWithBorder extends StatelessWidget {
  final String name;
  final String? label;
  final List<String? Function(String?)>? validators;
  final bool isObstructedText;
  final String? hintText;
  final String? initialValue;
  final bool showShadow;
  final bool isRequired, isHidden, readOnly;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;

  final Function(String?)? onChanged;
  final TextInputType? textInputType;
  final String? autofillHints;
  final TextEditingController? textEditingController;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final Widget? suffix, prefix;

  const AppInputTextWithBorder({
    Key? key,
    required this.name,
    this.label,
    this.onChanged,
    this.validators,
    this.isObstructedText = false,
    this.hintText,
    this.initialValue,
    this.readOnly = false,
    this.showShadow = false,
    this.isRequired = true,
    this.inputFormatters,
    this.textInputType,
    this.isHidden = false,
    this.minLines,
    this.maxLines,
    this.autofillHints,
    this.textEditingController,
    this.focusNode,
    this.suffix,
    this.prefix, this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      controller: textEditingController,
      name: name,
      focusNode: focusNode,
      validator: FormBuilderValidators.compose(validators ?? []),
      obscureText: isObstructedText,
      minLines: minLines ?? 1,
      maxLines: maxLines ?? 1,
      keyboardType: textInputType,
      maxLength: maxLength,
      style: isHidden ? kMediumRegular.copyWith(color: Colors.transparent) : null,
      decoration: InputDecoration(
        hintText: hintText ?? "",
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Styles.kInactiveColor,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Styles.kInactiveColor,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Styles.kInactiveColor,
            width: 1.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Styles.kPrimaryColor,
            width: 1.0,
          ),
        ),
        errorStyle: TextStyle(color:Styles.kPrimaryColor),
        errorMaxLines: 1,
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Styles.kPrimaryColor,
            width: 1.0,
          ),
        ),
        counterText: "",
        prefix: prefix,
        suffix: suffix,
      ),
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      readOnly: readOnly,
      initialValue: initialValue,
      autofillHints: autofillHints != null ? [autofillHints!] : null,
    );



  }
}
//kDisabledButton
