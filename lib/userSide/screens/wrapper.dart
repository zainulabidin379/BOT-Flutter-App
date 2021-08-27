import 'package:bot_app/adminSide/adminHomeScreen.dart';

import '../models/user.dart';
import '../screens/login-screen.dart';
import '../screens/screens.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final user = Provider.of<TheUser>(context);

    return StreamBuilder(
        stream: Connectivity().onConnectivityChanged,
        builder:
            (BuildContext context, AsyncSnapshot<ConnectivityResult> snapshot) {
          if (snapshot != null &&
              snapshot.hasData &&
              snapshot.data != ConnectivityResult.none) {
            if (user == null) {
              return LoginScreen();
            } else {
              if(user.uid == 'QcIwlUYy7JZigOYecROLtsj33Dg1'){
                return AdminHomeScreen();
              } else {
                return LocationStatusCheck();
              }
            }
          } else if (snapshot == null &&
              !snapshot.hasData) {
            if (user == null) {
              return LoginScreen();
            } else {
              if(user.uid == 'QcIwlUYy7JZigOYecROLtsj33Dg1'){
                return AdminHomeScreen();
              } else {
                return LocationStatusCheck();
              }
            }
          } else if (snapshot.data == ConnectivityResult.none) {
            return Scaffold(
              backgroundColor: kBlack,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                        width: size.width * 0.3,
                        child: Image.asset(
                          'assets/images/internet.png',
                          color: kWhite,
                        )),
                  ),
                  SizedBox(height: size.height * 0.05),
                  Center(
                      child: Text(
                    'No Network Connection!',
                    style: TextStyle(
                      fontSize: size.width * 0.06,
                      fontWeight: FontWeight.bold,
                      color: kWhite,
                    ),
                  )),
                  SizedBox(height: size.height * 0.01),
                  Center(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      "No internet Connection. Connect to the internet and try again.",
                      style:
                          TextStyle(fontSize: size.width * 0.04, color: kWhite),
                      textAlign: TextAlign.center,
                    ),
                  )),
                ],
              ),
            );
          } else if (user == null){
            return LoginScreen();
          } else {
            return Center(
              child: SpinKitFadingCircle(
                color: kRed,
                size: 50.0,
              ),
            );
          }
        });
  }
}
