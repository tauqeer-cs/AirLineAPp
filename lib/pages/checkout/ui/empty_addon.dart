import 'package:app/theme/theme.dart';
import 'package:flutter/cupertino.dart';

class EmptyAddon extends StatelessWidget {
  const EmptyAddon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 100),
        child: Text(
          "This add-on is currently not available",
          style: kLargeHeavy,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
