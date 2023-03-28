import 'package:app/pages/search_result/ui/choose_flight_segment.dart';
import 'package:app/theme/styles.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class SortSheet extends StatefulWidget {
  final Function(SortFlight) onChanged;
  final SortFlight defaultValue;

  const SortSheet(
      {Key? key, required this.onChanged, required this.defaultValue})
      : super(key: key);

  @override
  State<SortSheet> createState() => _SortSheetState();
}

class _SortSheetState extends State<SortSheet> {
  late SortFlight selectedSort;

  @override
  void initState() {
    super.initState();
    selectedSort = widget.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Wrap(
        children: SortFlight.values
            .map(
              (e) => ListTile(
                dense: true,
                title: Text(e.toString()),
                trailing: Visibility(
                  visible: e == selectedSort,
                  child: Icon(
                    Icons.check,
                    color: Styles.kPrimaryColor,
                  ),
                ),
                onTap: (){
                  setState(() {
                    selectedSort = e;
                    widget.onChanged(e);
                  });
                  context.router.pop();
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
