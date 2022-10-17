import 'package:app/pages/home/ui/home_view.dart';
import 'package:app/utils/fcm_notifications.dart';
import 'package:app/widgets/app_app_bar.dart';
import 'package:app/widgets/app_logo_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    FCMNotification.of(context).initialize();

  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: HomeView(),
    );
  }
}
