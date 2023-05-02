import 'package:app/pages/bookings/ui/bookings_view.dart';
import 'package:flutter/material.dart';

import '../../widgets/wave_background.dart';

class BookingsPage extends StatelessWidget {
  const BookingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WaveBackground(
      color: Colors.white,
      child:  Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(child: BookingsView()),
      ),
    );
  }
}
