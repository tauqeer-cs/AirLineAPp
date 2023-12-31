import 'package:app/custom_packages/dropdown_search/dropdown_search.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_sheet_handler.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/airports.dart';

class AppDropDown<T> extends StatelessWidget {
  final T? defaultValue;
  final List<T> items;
  final Function(T?)? onChanged;
  final Widget Function(T?)? valueTransformer;
  final Widget Function(T?, bool isSelected)? valueTransformerItem;
  final String? sheetTitle;
  final Widget? prefix;
  final bool isEnabled, isMinimalism;
  final DropDownDecoratorProps? dropdownDecoration;

  const AppDropDown({
    Key? key,
    this.defaultValue,
    required this.items,
    this.onChanged,
    this.valueTransformer,
    this.valueTransformerItem,
    this.sheetTitle,
    this.isEnabled = true,
    this.isMinimalism = false,
    this.prefix,
    this.dropdownDecoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<T>(
      enabled: isEnabled,
      items: items,
      onChanged: onChanged,
      selectedItem: defaultValue,
      dropdownDecoratorProps: dropdownDecoration ??
          DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Styles.kBorderColor),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Styles.kBorderColor),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Styles.kBorderColor),
              ),
              errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              disabledBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Styles.kBorderColor.withOpacity(0.3)),
              ),
              hintStyle: kTinySemiBold.copyWith(
                color: const Color.fromRGBO(43, 45, 66, 1),
              ),
              hintText: sheetTitle,
              contentPadding: isMinimalism
                  ? EdgeInsets.zero
                  : const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
            ),
          ),
      dropdownBuilder: (context, val) {
        if (val == null) {
          return Row(
            children: [
              prefix != null ? prefix! : const SizedBox.shrink(),
              Text(
                sheetTitle ?? "",
                style: kSmallSemiBold.copyWith(color: Styles.kTextColor),
              ),
            ],
          );
        }
        return valueTransformer != null
            ? valueTransformer!(val)
            : Align(
                alignment:
                    isMinimalism ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: Text(
                    val.toString(),
                    style: kSmallSemiBold,
                    textAlign:
                        isMinimalism ? TextAlign.center : TextAlign.start,
                    maxLines: 2,
                  ),
                ),
              );
      },
      compareFn: (val1, val2) {
        return val1 == val2;
      },
      popupProps: PopupProps.modalBottomSheet(
        title: AppSheetHandler(title: sheetTitle),
        showSelectedItems: true,
        scrollbarProps: ScrollbarProps(
          thumbColor: Styles.kBorderActionColor,
          trackVisibility: true,
          thumbVisibility: true,
          thickness: 3,
          crossAxisMargin: 3,
          minThumbLength: 10,
          trackColor: Colors.transparent,
          trackRadius: Radius.zero,
          trackBorderColor: Colors.transparent,
        ),
        emptyBuilder: (_, __) =>
            Center(child: Text("noItemsCanBeSelected".tr())),
        itemBuilder: (context, value, selected) {
          return ListTile(
            dense: true,
            title: valueTransformerItem != null
                ? valueTransformerItem!(value, selected)
                : Text(
                    value.toString(),
                    style: selected
                        ? kMediumSemiBold.copyWith(color: Styles.kActiveColor)
                        : kMediumMedium,
                  ),
            trailing: Visibility(
              visible: selected,
              child: Icon(
                Icons.check,
                color: Styles.kActiveColor,
              ),
            ),
          );
        },
        listViewProps: const ListViewProps(
          padding: EdgeInsets.zero,
        ),
        modalBottomSheetProps: ModalBottomSheetProps(
          backgroundColor: const Color.fromRGBO(235, 235, 235, 0.85),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16),
            ),
          ),
          clipBehavior: Clip.hardEdge,
          elevation: 5,
          enableDrag: true,
          constraints: BoxConstraints(maxHeight: 300, maxWidth: 0.9.sw),
        ),
      ),
      dropdownButtonProps: DropdownButtonProps(
        color: Colors.black,
        icon: const Icon(Icons.keyboard_arrow_down),
        isVisible: !isMinimalism,
        constraints: isMinimalism
            ? const BoxConstraints(minWidth: 0, maxWidth: 0)
            : null,
      ),
    );
  }
}

class AppDropDownWithSearch<T> extends StatelessWidget {
  final T? defaultValue;
  final List<T> items;
  final bool Function(dynamic a,dynamic b)onSearch;

  final Function(T?)? onChanged;
  final Widget Function(T?)? valueTransformer;
  final Widget Function(T?, bool isSelected)? valueTransformerItem;
  final String? sheetTitle;
  final Widget? prefix;
  final bool isEnabled, isMinimalism;
  final DropDownDecoratorProps? dropdownDecoration;

  final bool numKey;
  const AppDropDownWithSearch({
    Key? key,
    this.defaultValue,
    required this.items,
    this.onChanged,
    this.valueTransformer,
    this.valueTransformerItem,
    this.sheetTitle,
    this.isEnabled = true,
    this.isMinimalism = false,
    this.prefix,
    this.numKey = false,
    this.dropdownDecoration, required this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<T>(
      enabled: isEnabled,
      items: items,
      onChanged: onChanged,
      filterFn : onSearch,
      selectedItem: defaultValue,
      dropdownDecoratorProps: dropdownDecoration ??
          DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Styles.kBorderColor),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Styles.kBorderColor),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Styles.kBorderColor),
              ),
              errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              disabledBorder: UnderlineInputBorder(
                borderSide:
                BorderSide(color: Styles.kBorderColor.withOpacity(0.3)),
              ),
              hintStyle: kTinySemiBold.copyWith(
                color: const Color.fromRGBO(43, 45, 66, 1),
              ),
              hintText: sheetTitle,
              contentPadding: isMinimalism
                  ? EdgeInsets.zero
                  : const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
            ),
          ),
      dropdownBuilder: (context, val) {
        if (val == null) {
          return Row(
            children: [
              prefix != null ? prefix! : const SizedBox.shrink(),
              Text(
                sheetTitle ?? "",
                style: kSmallSemiBold.copyWith(color: Styles.kTextColor),
              ),
            ],
          );
        }
        return valueTransformer != null
            ? valueTransformer!(val)
            : Align(
          alignment:
          isMinimalism ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.only(left: 0.0),
            child: Text(
              val.toString(),
              style: kSmallSemiBold,
              textAlign:
              isMinimalism ? TextAlign.center : TextAlign.start,
              maxLines: 2,
            ),
          ),
        );
      },
      compareFn: (val1, val2) {
        return val1 == val2;
      },

      popupProps: PopupProps.dialog(
          title: AppSheetHandler(title: sheetTitle),
          showSelectedItems: true,
          showSearchBox: true,
          scrollbarProps: ScrollbarProps(
            thumbColor: Styles.kBorderActionColor,
            trackVisibility: true,
            thumbVisibility: true,
            thickness: 3,
            crossAxisMargin: 3,
            minThumbLength: 10,
            trackColor: Colors.transparent,
            trackRadius: Radius.zero,
            trackBorderColor: Colors.transparent,
          ),
          emptyBuilder: (_, __) => Center(
            child: Text(
              'noItemsCanBeSelected'.tr(),
            ),
          ),
          itemBuilder: (context, value, selected) {
            return ListTile(
              dense: true,
              title: valueTransformerItem != null
                  ? valueTransformerItem!(value, selected)
                  : Text(
                value.toString(),
                style: selected
                    ? kMediumSemiBold.copyWith(color: Styles.kActiveColor)
                    : kMediumMedium,
              ),
              trailing: Visibility(
                visible: selected,
                child: Icon(
                  Icons.check,
                  color: Styles.kActiveColor,
                ),
              ),
            );
          },
          listViewProps: const ListViewProps(
            padding: EdgeInsets.zero,
          ),
          searchFieldProps:   TextFieldProps(
            keyboardType: numKey ? TextInputType.number : TextInputType.text,
          ),
          dialogProps: const DialogProps(
            backgroundColor: Color.fromRGBO(235, 235, 235, 0.85),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),

            insetPadding: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 0.0,
            ),
            clipBehavior: Clip.hardEdge,
            elevation: 5,
            // enableDrag: true,
            //  constraints: BoxConstraints(maxHeight: 300, maxWidth: 0.9.sw),
          )

      ),
      dropdownButtonProps: DropdownButtonProps(
        color: Colors.black,
        icon: const Icon(Icons.keyboard_arrow_down),
        isVisible: !isMinimalism,
        constraints: isMinimalism
            ? const BoxConstraints(minWidth: 0, maxWidth: 0)
            : null,
      ),
    );
  }
}

class AppDropDownAirPort<T> extends StatelessWidget {
  final T? defaultValue;
  final List<T> items;
  final List<Airports> itemsAll;

  final Function(T?)? onChanged;
  final Widget Function(T?)? valueTransformer;
  final Widget Function(T?, bool isSelected)? valueTransformerItem;
  final String? sheetTitle;
  final Widget? prefix;
  final bool isEnabled, isMinimalism;
  final DropDownDecoratorProps? dropdownDecoration;

  const AppDropDownAirPort({
    Key? key,
    this.defaultValue,
    required this.items,
    this.onChanged,
    required this.itemsAll,
    this.valueTransformer,
    this.valueTransformerItem,
    this.sheetTitle,
    this.isEnabled = true,
    this.isMinimalism = false,
    this.prefix,
    this.dropdownDecoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<T>(
      enabled: isEnabled,
      items: items,
      onChanged: onChanged,
      selectedItem: defaultValue,
      dropdownDecoratorProps: dropdownDecoration ??
          DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Styles.kBorderColor),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Styles.kBorderColor),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Styles.kBorderColor),
              ),
              errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              disabledBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Styles.kBorderColor.withOpacity(0.3)),
              ),
              hintStyle: kTinySemiBold.copyWith(
                color: const Color.fromRGBO(43, 45, 66, 1),
              ),
              hintText: sheetTitle,
              contentPadding: isMinimalism
                  ? EdgeInsets.zero
                  : const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
            ),
          ),
      filterFn: name,
      dropdownBuilder: (context, val) {
        if (val == null) {
          return Row(
            children: [
              prefix != null ? prefix! : const SizedBox.shrink(),
              Text(
                sheetTitle ?? "",
                style: kSmallSemiBold.copyWith(color: Styles.kTextColor),
              ),
            ],
          );
        }
        return valueTransformer != null
            ? valueTransformer!(val)
            : Align(
                alignment:
                    isMinimalism ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: Text(
                    val.toString(),
                    style: kSmallSemiBold,
                    textAlign:
                        isMinimalism ? TextAlign.center : TextAlign.start,
                    maxLines: 2,
                  ),
                ),
              );
      },
      compareFn: (val1, val2) {
        return val1 == val2;
      },
      popupProps: PopupProps.dialog(
          title: AppSheetHandler(title: sheetTitle),
          showSelectedItems: true,

          showSearchBox: true,
          scrollbarProps: ScrollbarProps(
            thumbColor: Styles.kBorderActionColor,
            trackVisibility: true,
            thumbVisibility: true,
            thickness: 3,
            crossAxisMargin: 3,
            minThumbLength: 10,
            trackColor: Colors.transparent,
            trackRadius: Radius.zero,
            trackBorderColor: Colors.transparent,
          ),
          emptyBuilder: (_, __) => Center(
                child: Text(
                  'noItemsCanBeSelected'.tr(),
                ),
              ),
          itemBuilder: (context, value, selected) {
            return ListTile(
              dense: true,
              title: valueTransformerItem != null
                  ? valueTransformerItem!(value, selected)
                  : Text(
                      value.toString(),
                      style: selected
                          ? kMediumSemiBold.copyWith(color: Styles.kActiveColor)
                          : kMediumMedium,
                    ),
              trailing: Visibility(
                visible: selected,
                child: Icon(
                  Icons.check,
                  color: Styles.kActiveColor,
                ),
              ),
            );
          },
          listViewProps: const ListViewProps(
            padding: EdgeInsets.zero,
          ),
          dialogProps: const DialogProps(
            backgroundColor: Color.fromRGBO(235, 235, 235, 0.85),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),

            insetPadding: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 0.0,
            ),
            clipBehavior: Clip.hardEdge,
            elevation: 5,
            // enableDrag: true,
            //  constraints: BoxConstraints(maxHeight: 300, maxWidth: 0.9.sw),
          )

          ),
      dropdownButtonProps: DropdownButtonProps(
        color: Colors.black,
        icon: const Icon(Icons.keyboard_arrow_down),
        isVisible: !isMinimalism,
        constraints: isMinimalism
            ? const BoxConstraints(minWidth: 0, maxWidth: 0)
            : null,
      ),
    );
  }

  bool name(a, b) {
      if (b == '') {
        return true;
      }

      Airports tmp = a as Airports;

      var result = itemsAll.where((e) => e.name == tmp.name).toList();

      if (result.isNotEmpty) {
        if (result.first.name!.toLowerCase().contains(b.toLowerCase())) {
          return true;
        }

        if (result.first.code!.toLowerCase().contains(b.toLowerCase())) {
          return true;
        }
        return false;
      }
      return false;
    }
}
