import 'package:app/pages/home/ui/home_view.dart';
import 'package:app/widgets/app_app_bar.dart';
import 'package:app/widgets/app_logo_widget.dart';
import 'package:app/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: HomeView(),
    );
  }
}
