

import 'package:app/theme/theme.dart';
import 'package:flutter/material.dart';

class DropdownTransformerWidget<T> extends StatelessWidget {
  final T? value;
  final String? label;
  final Widget? prefix;
  final Widget? suffix;

  const DropdownTransformerWidget({
    Key? key,
    required this.value,
    this.label,
    this.prefix,
    this.suffix,
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
          child: Padding(
            padding: const EdgeInsets.all(5.0),
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
                    value!=null ? value.toString() : "",
                    style: kMediumMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
        suffix ?? SizedBox.shrink(),
      ],
    );
  }
}