import 'package:app/theme/theme.dart';
import 'package:flutter/material.dart';

class DropdownTransformerWidget<T> extends StatelessWidget {
  final T? value;
  final String? label, valueCustom, hintText;
  final Widget? prefix;
  final Widget? suffix;

  const DropdownTransformerWidget({
    Key? key,
    this.value,
    this.label,
    this.prefix,
    this.suffix,
    this.valueCustom,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        prefix != null
            ? Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: prefix,
              )
            : const SizedBox.shrink(),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: label != null,
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: value != null ? 5 : 5,
                      top: value != null ? 0 : 0),
                  child: Text(
                    label ?? "",
                    style: kSmallMedium,
                  ),
                ),
              ),
              Visibility(
                visible: value != null,
                replacement: Text(
                  hintText ?? "Please Select",
                  style: kSmallSemiBold,
                ),
                child: Text(
                  valueCustom != null
                      ? valueCustom!
                      : (value?.toString() ?? ""),
                  style: kSmallSemiBold,
                ),
              ),
            ],
          ),
        ),
        suffix ?? const SizedBox.shrink(),
      ],
    );
  }
}
