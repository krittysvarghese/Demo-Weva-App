import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:app_demo_weva/screens/home_screen.dart';
import 'package:app_demo_weva/screens/profile_information.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:app_demo_weva/blocs/auth_bloc.dart';
import 'package:app_demo_weva/screens/sign_in_screen.dart';

import 'dart:async';

class SettingsScreen extends StatefulWidget {
  static String routeName = "/settings";
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
        title: Text('SETTINGS',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 15,
            color: Colors.grey,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            Container(
              child: Stack(
                children: [
                  Image.asset("assets/images/upgrade_image.jpg",
                    fit: BoxFit.fitWidth,
                  ),
                  Center(
                    child: Card(
                      child: Wrap(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text("Upgrade to a Premium plan",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  color: Color(0xFF2B4F81),
                                ),
                              ),
                              Text("Get unlimited videos without a watermark",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w300,
                                  color: Color(0xFF2B4F81),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                          RaisedButton(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            color: Color(0xFF2B4F81),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            onPressed: () {
                              //Upgrade info
                            },
                            child: Text("Upgrade",
                                style: TextStyle(
                                    fontSize: 12,
                                    letterSpacing: 2.2,
                                    color: Colors.white,
                                )
                            ),
                          ),
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 5,
                      margin: EdgeInsets.all(10),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                StreamBuilder<User>(
                  stream: authBloc.currentUser,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return CircularProgressIndicator();
                    print(snapshot.data.photoURL);
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(snapshot.data.displayName,
                                style:TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold
                                ),
                            ),
                            Text(snapshot.data.email)
                          ],
                        ),
                        SizedBox(width: 10.0,),
                        Container(
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(snapshot.data.photoURL.replaceFirst('s96','s400')),
                                radius: 30.0,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 80.0,),
                      ],
                    );
                  }
                ),
              ]
            ),
            Divider(
              height: 10,
              thickness: 2,
            ),
            buildAccountOptionRow(context, "Profile Information", ProfileInformation.routeName ),
            Divider(
              height: 10,
              thickness: 1.5,
            ),
            buildAccountOptionRow(context, "Brand Settings", HomeScreen.routeName), //Change routeName for new screen.
            Divider(
              height: 10,
              thickness: 1.5,
            ),
            SizedBox(
              height: 40,
            ),
            Text(
                  "Account",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            buildAccountOptionRow(context, "Subscription", HomeScreen.routeName), //Change routeName for new screen.
            Divider(
              height: 10,
              thickness: 1.5,
            ),
            SizedBox(
              height: 40,
            ),
            Text(
                  "About",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            buildAccountOptionRow(context, "Contact Support", HomeScreen.routeName),  //Change routeName for new screen.
            Divider(
              height: 10,
              thickness: 1.5,
            ),
            buildAccountOptionRow(context, "View FAQs", HomeScreen.routeName),  //Change routeName for new screen.
            Divider(
              height: 10,
              thickness: 1.5,
            ),
            buildAccountOptionRow(context, "Terms and Conditions", HomeScreen.routeName), //Change routeName for new screen.
            Divider(
              height: 10,
              thickness: 1.5,
            ),
            buildAccountOptionRow(context, "Privacy Policy", HomeScreen.routeName), //Change routeName for new screen.
            Divider(
              height: 10,
              thickness: 1.5,
            ),
            SizedBox(
              height: 40,
            ),
            Center(
              child: OutlineButton(
                padding: EdgeInsets.symmetric(horizontal: 40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                /*onPressed: () {
                  Navigator.pushNamed(context, HomeScreen.routeName);
                },*/
                onPressed: () => authBloc.logout(),
                child: Text("SIGN OUT",
                    style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 2.2,
                        color: Colors.black
                    )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  GestureDetector buildAccountOptionRow(BuildContext context, String title, String nextRouteName) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, nextRouteName);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
