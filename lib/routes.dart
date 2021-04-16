import 'package:flutter/widgets.dart';

import 'package:app_demo_weva/screens/sign_in_screen.dart';
import 'package:app_demo_weva/screens/home_screen.dart';
import 'package:app_demo_weva/screens/profile_information.dart';
import 'package:app_demo_weva/bottom_navigation_bar.dart';
import 'package:app_demo_weva/screens/templates_screen.dart';
import 'package:app_demo_weva/screens/settings_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SignInScreen.routeName: (context) => SignInScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  Nav.routeName: (context) => Nav(),
  TemplatesScreen.routeName: (context) => TemplatesScreen(),
  SettingsScreen.routeName: (context) => SettingsScreen(),
  ProfileInformation.routeName: (context) => ProfileInformation(),
};
