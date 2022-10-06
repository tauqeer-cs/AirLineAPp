import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_sheet_handler.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class AppDropDown<T> extends StatelessWidget {
  final T? defaultValue;
  final List<T> items;
  final Function(T?)? onChanged;
  final Widget Function(T?)? valueTransformer;
  final Widget Function(T?, bool isSelected)? valueTransformerItem;
  final String? sheetTitle;
  final bool isEnabled;

  const AppDropDown({
    Key? key,
    this.defaultValue,
    required this.items,
    this.onChanged,
    this.valueTransformer,
    this.valueTransformerItem,
    this.sheetTitle,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<T>(
      enabled: isEnabled,
      items: items,
      onChanged: onChanged,
      selectedItem: defaultValue,
      // dropdownDecoratorProps: DropDownDecoratorProps(
      //   dropdownSearchDecoration: InputDecoration(
      //     border: OutlineInputBorder(
      //       borderSide: BorderSide(color: Styles.kDarkContainerColor),
      //       borderRadius: BorderRadius.circular(5),
      //     ),
      //     enabledBorder: OutlineInputBorder(
      //       borderSide: BorderSide(color: Styles.kDarkContainerColor),
      //       borderRadius: BorderRadius.circular(5),
      //     ),
      //     focusedBorder: OutlineInputBorder(
      //       borderSide: BorderSide(color: Styles.kDarkContainerColor),
      //       borderRadius: BorderRadius.circular(5),
      //     ),
      //     errorBorder: OutlineInputBorder(
      //       borderSide: const BorderSide(color: Colors.red),
      //       borderRadius: BorderRadius.circular(5),
      //     ),
      //     focusedErrorBorder: OutlineInputBorder(
      //       borderSide: const BorderSide(color: Colors.red),
      //       borderRadius: BorderRadius.circular(5),
      //     ),
      //     disabledBorder: OutlineInputBorder(
      //       borderSide:
      //           BorderSide(color: Styles.kDarkContainerColor.withOpacity(0.3)),
      //       borderRadius: BorderRadius.circular(5),
      //     ),
      //   ),
      // ),
      dropdownBuilder: (context, val) {
        return valueTransformer != null
            ? valueTransformer!(val)
            : Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: Text(
                    val.toString(),
                    style: kSmallMedium,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                  ),
                ),
              );
      },
      compareFn: (val1, val2) {
        return val1 == val2;
      },
      popupProps: PopupProps.modalBottomSheet(
        title: Transform.translate(
          offset: const Offset(0, -10),
          child: AppSheetHandler(title: sheetTitle),
        ),
        showSelectedItems: true,
        scrollbarProps: ScrollbarProps(
          thumbColor: Styles.kActiveColor,
          trackVisibility: true,
          thumbVisibility: true,
        ),
        emptyBuilder: (_, __) =>
            Center(child: Text("No items can be selected")),
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
        /*dialogProps: DialogProps(
          barrierDismissible: true,
          contentPadding: EdgeInsets.zero,
          actionsPadding: EdgeInsets.zero,
        ),*/
        modalBottomSheetProps: ModalBottomSheetProps(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16),
            ),
          ),
          clipBehavior: Clip.hardEdge,
          elevation: 5,
          enableDrag: true,
          constraints: BoxConstraints(
            maxHeight: (items.length * 70 == 0 ? 70 : items.length * 70) + 80,
          ),
        ),
      ),
      dropdownButtonProps: DropdownButtonProps(
        color: Colors.black,
        icon: Icon(Icons.keyboard_arrow_down),
      ),
    );
  }
}
