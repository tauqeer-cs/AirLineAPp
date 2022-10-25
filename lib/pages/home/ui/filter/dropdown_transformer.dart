

import 'package:app/theme/theme.dart';
import 'package:flutter/material.dart';

class DropdownTransformerWidget<T> extends StatelessWidget {
  final T? value;
  final String? label, valueCustom;
  final Widget? prefix;
  final Widget? suffix;

  const DropdownTransformerWidget({
    Key? key,
    this.value,
    this.label,
    this.prefix,
    this.suffix,
    this.valueCustom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        prefix!=null ? Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: prefix,
        ): SizedBox.shrink(),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: label != null,
                child: Padding(
                  padding:  EdgeInsets.only(bottom: value!=null ? 5 : 10, top: value!=null ? 0 : 10),
                  child: Text(
                    label ?? "",
                    style: kSmallMedium.copyWith(color: Colors.grey),
                  ),
                ),
              ),
              Visibility(
                visible: value!=null,
                child: Text(
                  valueCustom!=null ? valueCustom! : (value?.toString() ?? ""),
                  style: kMediumMedium,
                ),
              ),
            ],
          ),
        ),
        suffix ?? SizedBox.shrink(),
      ],
    );
  }
}