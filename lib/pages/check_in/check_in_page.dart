import 'package:app/pages/check_in/bloc/check_in_cubit.dart';
import 'package:app/pages/check_in/ui/check_in_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/wave_background.dart';

class CheckInPage extends StatelessWidget {
  const CheckInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BlocProvider(
        create: (context) => CheckInCubit(),
        child: const WaveBackground(
          color: Colors.white,
          child: Scaffold(
            backgroundColor: Colors.transparent,

            body: SafeArea(child: CheckInView()),
          ),
        ),
      ),
    );
  }
}
