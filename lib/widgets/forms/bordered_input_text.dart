import 'package:app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class BorderedAppInputText extends StatelessWidget {
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

  const BorderedAppInputText({
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
    return Stack(
      children: [
        Container(
          height: 45,
          decoration: BoxDecoration(
            border: Border.all(color: Styles.kBorderColor),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
        SizedBox(
          height: 45,
          child: FormBuilderTextField(
            controller: textEditingController,
            name: name,
            focusNode: focusNode,
            validator: FormBuilderValidators.compose(validators ?? []),
            obscureText: isObstructedText,
            minLines: minLines ?? 1,
            maxLines: maxLines ?? 1,
            keyboardType: textInputType,
            maxLength: maxLength,
            style:
            isHidden ? kMediumRegular.copyWith(color: Colors.transparent) : null,
            decoration: InputDecoration(
              //hintText: hintText ?? "",
              labelText: hintText ?? "",
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder:InputBorder.none,
              disabledBorder:InputBorder.none,
              border: InputBorder.none,

              prefix: prefix,
              suffix: suffix,
              counterText: "",
            ),
            inputFormatters: inputFormatters,
            onChanged: onChanged,
            readOnly: readOnly,
            initialValue: initialValue,
            autofillHints: autofillHints != null ? [autofillHints!] : null,
          ),
        ),
      ],
    );
  }
}
