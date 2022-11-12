import 'package:app/widgets/forms/app_input_text.dart';
import 'package:flutter/material.dart';

class ShadowInput extends StatelessWidget {
  final Widget child;
  final String name;
  final List<String? Function(String?)>? validators;

  final TextEditingController textEditingController;

  const ShadowInput(
      {Key? key,
      required this.child,
      required this.name,
      required this.textEditingController,
      this.validators})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppInputText(
          textEditingController: textEditingController,
          name: name,
          isHidden: true,
          validators: validators,
        ),
        child,
      ],
    );
  }
}
