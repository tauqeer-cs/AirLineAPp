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
  final bool isRequired;
  final int? minLines;
  final int? maxLines;
  final TextInputType? textInputType;

  const AppInputText({
    Key? key,
    required this.name,
    this.label,
    this.validators,
    this.isObstructedText = false,
    this.hintText,
    this.initialValue,
    this.showShadow = false,
    this.isRequired = true,
    this.textInputType,
    this.minLines,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: name,
      validator: FormBuilderValidators.compose(validators ?? []),
      obscureText: isObstructedText,
      minLines: minLines,
      maxLines: maxLines,
      keyboardType: textInputType,
      decoration: InputDecoration(
        hintText: hintText ?? "",
      ),
      initialValue: initialValue,
    );
  }
}
