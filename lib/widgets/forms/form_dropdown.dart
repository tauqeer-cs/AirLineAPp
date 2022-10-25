import 'package:flutter/material.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';

class FormDropDown<T> extends StatelessWidget {
  final String name;
  final T? initialValue;
  final List<T>? items;
  final String? hintText;
  final List<String? Function(T?)>? validators;

  const FormDropDown({
    Key? key,
    required this.name,
    this.initialValue,
    this.hintText,
    this.validators, this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderSearchableDropdown<T>(
      popupProps: const PopupProps.menu(showSearchBox: true),

      name: name,
      items: items ?? [],
    );
  }
}
