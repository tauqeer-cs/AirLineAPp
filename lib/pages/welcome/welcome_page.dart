import 'package:app/app/app_router.dart';
import 'package:app/widgets/app_loading_screen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  //final Duration duration = const Duration(milliseconds: 1500);
  //bool isShow = false;
  int progress = 0;
  @override
  void initState() {
    super.initState();
    navigateAfterDelay();
  }

  navigateAfterDelay() async {
    for(int i=1; i<=10; i++){
      await Future.delayed(const Duration(milliseconds: 180));
      setState(() => progress = i);
    }
    context.router.push(InAppWebViewRoute(url: "https://myairline-gcp-cert-ezycommerce.ezyflight.se/en"));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AppLoadingScreen(),
    );
  }
}
