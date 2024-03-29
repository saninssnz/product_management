import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test/src/data/data_source/local/preference/preference_file.dart';
import 'package:machine_test/src/data/models/user_model.dart';
import 'package:machine_test/src/presentation/blocs/user_bloc/user_bloc.dart';
import 'package:machine_test/src/presentation/pages/login_view/login_screen.dart';
import 'package:machine_test/src/presentation/pages/set_up_pin_view/pin_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {

    final userBloc = BlocProvider.of<UserBloc>(context);

    PreferenceFile().getLoginData().then((value) {
      userBloc.add(SetUseModel(value));
    });
    startTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
          fit: BoxFit.fitHeight,
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          "assets/images/product_manager.png"),
    );
  }

  startTime() async {
    var duration = const Duration(seconds: 2);
    return Timer(duration, navigationPage);
  }

  Future<void> navigationPage() async {
    final userBloc = BlocProvider.of<UserBloc>(context);

    if (userBloc.state.userModel?.userEmail != null || userBloc.state.userModel?.pin != null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => const PinScreen(false)));
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => const LoginScreen()));
    }
  }
}
