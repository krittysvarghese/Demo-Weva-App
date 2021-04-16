import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:app_demo_weva/blocs/auth_bloc.dart';
import 'package:app_demo_weva/screens/sign_in_screen.dart';
import 'package:provider/provider.dart';
import 'package:app_demo_weva/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(WevaDemo());
}

class WevaDemo extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        title: 'Demo Weva',
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: SignInScreen.routeName,
        routes: routes,
      ),
    );
  }
}


