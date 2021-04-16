import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_demo_weva/blocs/auth_bloc.dart';
import 'package:app_demo_weva/screens/sign_in_screen.dart';

import 'package:provider/provider.dart';

class ProfileInformation extends StatefulWidget {
  static String routeName = "/profile";
  @override
  _ProfileInformationState createState() => _ProfileInformationState();
}

class _ProfileInformationState extends State<ProfileInformation> {
  StreamSubscription<User> loginStateSubscription;

  @override
  void initState() {
    var authBloc = Provider.of<AuthBloc>(context, listen: false);
    loginStateSubscription = authBloc.currentUser.listen((fbUser) {
      if (fbUser == null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => SignInScreen(),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    loginStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = Provider.of<AuthBloc>(context);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('PROFILE',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 17,
              color: Colors.grey,
              letterSpacing: 1.2,
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: StreamBuilder<User>(
              stream: authBloc.currentUser,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                print(snapshot.data.photoURL);
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(snapshot.data.displayName,
                        style:TextStyle(
                            fontSize: 30.0
                        )
                    ),
                    SizedBox(height: 20.0,),
                    Text(snapshot.data.email,
                        style:TextStyle(
                            fontSize: 15.0
                        )
                    ),
                    SizedBox(height: 20.0,),
                    CircleAvatar(
                      backgroundImage: NetworkImage(snapshot.data.photoURL.replaceFirst('s96','s400')),
                      radius: 60.0,
                    ),
                  ],
                );
              }
          ),
        ));
  }
}
