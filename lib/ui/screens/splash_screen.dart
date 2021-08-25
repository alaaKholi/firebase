import '/services/shared_prefs.dart';
import '/ui/screens/get_started.dart';
import '/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2)).then((value) async {
      if (MySharedPreference.mySharedPreference.isFirstTime()) {
        print('from first time');
        Navigator.pushReplacementNamed(context, GetStartedScreen.routeName);
      } else {
        print('from not first time');
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      }
    });
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/icon.png',
          height: 150,
          width: 150,
        ),
      ),
    );
  }
}
