import 'package:app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class AppInputText extends StatelessWidget {
  final String name;
  final String? label;
  final List<String? Function(String?)>? validators;
  final bool isObstructedText;
  final String? hintText;
  final String? initialValue;
  final bool showShadow;
  final bool isRequired, isHidden;
  final int? minLines;
  final int? maxLines;
  final  Function(String?)? onChanged;
  final TextInputType? textInputType;
  final String? autofillHints;
  final TextEditingController? textEditingController;
  const AppInputText({
    Key? key,
    required this.name,
    this.label,
    this.onChanged,
    this.validators,
    this.isObstructedText = false,
    this.hintText,
    this.initialValue,
    this.showShadow = false,
    this.isRequired = true,
    this.textInputType,
    this.isHidden = false,
    this.minLines,
    this.maxLines,
    this.autofillHints, this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      controller: textEditingController,
      name: name,
      validator: FormBuilderValidators.compose(validators ?? []),
      obscureText: isObstructedText,
      minLines: minLines,
      maxLines: maxLines,
      keyboardType: textInputType,
      style: isHidden ? kMediumRegular.copyWith(color: Colors.transparent) : null,
      decoration: InputDecoration(
        hintText: hintText ?? "",
      ),
      onChanged: onChanged,
      initialValue: initialValue,
      autofillHints: autofillHints != null ? [autofillHints!] : null,

    );
  }
}
