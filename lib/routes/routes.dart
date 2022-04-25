import 'package:flutter/material.dart';
import '../ui/screens/add_zeker_screen.dart';
import '../ui/screens/details_screen.dart';
import '../ui/screens/electronic_zeker_screen.dart';
import '../ui/screens/get_started.dart';
import '../ui/screens/home_screen.dart';
import '../ui/screens/splash_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => SplashScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  GetStartedScreen.routeName: (context) => GetStartedScreen(),
  AddZekerScreen.routeName: (context) => AddZekerScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  ElectronicZeker.routeName: (context) => ElectronicZeker(),
};
