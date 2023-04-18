import 'package:app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final bool isRequired, isHidden, readOnly;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;

  final bool fillDisabledColor;
  final Function(String?)? onChanged;
  final TextInputType? textInputType;
  final String? autofillHints;
  final InputDecoration? inputDecoration;
  final TextEditingController? textEditingController;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final Widget? suffix, prefix;
  final Color? fillColor;

  final double topPadding;

  const AppInputText({
    Key? key,
    required this.name,
    this.label,
    this.onChanged,
    this.validators,
    this.isObstructedText = false,
    this.hintText,
    this.initialValue,
    this.readOnly = false,
    this.inputDecoration,
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
    this.fillDisabledColor = false,
    this.topPadding = 8.0 ,
    this.prefix, this.maxLength,
    this.fillColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(top: topPadding),
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
        decoration: inputDecoration ?? InputDecoration(
          hintText: hintText ?? "",
         // fillColor: fillColor, // add this line to set the background color

          border: isHidden ? InputBorder.none : null,
          errorBorder: isHidden ? InputBorder.none : null,
          enabledBorder: isHidden ? InputBorder.none : null,
          disabledBorder: isHidden ? InputBorder.none : null,
          focusedBorder: isHidden ? InputBorder.none : null,
          focusedErrorBorder: isHidden ? InputBorder.none : null,
          prefix: prefix,
          suffix: suffix,
          counterText: "",
          fillColor: fillDisabledColor ? Styles.kDisabledButton : (fillColor ??  Colors.transparent),
          //filled: true,

        ),
        inputFormatters: inputFormatters,
        onChanged: onChanged,
        readOnly: readOnly,
        initialValue: initialValue,
        autofillHints: autofillHints != null ? [autofillHints!] : null,
      ),
    );
  }
}


