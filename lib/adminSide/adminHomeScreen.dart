import 'package:bot_app/adminSide/users.dart';
import 'package:bot_app/adminSide/usersFeedback.dart';
import 'package:bot_app/userSide/screens/login-screen.dart';
import 'package:bot_app/userSide/services/auth.dart';
import 'offers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'pallete.dart';

class AdminHomeScreen extends StatefulWidget {
  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final AuthService _auth = AuthService();

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit App'),
            actions: <Widget>[
              new TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No', style: TextStyle(color: kBlack)),
              ),
              new TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes', style: TextStyle(color: kBlack)),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('Admin Panel'),
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: kRed,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(height: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //1ST ROW
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    menuCard(
                        size,
                        () => {
                              Get.to(() => Offers()),
                            },
                        'Offers'),
                    menuCard(
                        size,
                        () => {
                              Get.to(() => UsersScreen()),
                            },
                        'Users'),
                  ],
                ),
                //2nd ROW
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    menuCard(
                        size,
                        () => {
                              Get.to(() => UsersFeedback()),
                            },
                        'User Feedbacks'),
                    menuCard(
                        size,
                        () => {
                              showDialog(
                                context: context,
                                builder: (context) => new AlertDialog(
                                  title: new Text('Are you sure?'),
                                  content: new Text('Do you want to log out?'),
                                  actions: <Widget>[
                                    new TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: new Text('No',
                                          style: TextStyle(color: kRed)),
                                    ),
                                    new TextButton(
                                      onPressed: () async {
                                        await _auth.signOut();
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen()),
                                        );
                                        Get.snackbar(
                                          'Message',
                                          'Admin logged out successfully',
                                          duration: Duration(seconds: 3),
                                          backgroundColor: kBlack,
                                          colorText: kWhite,
                                          borderRadius: 10,
                                        );
                                      },
                                      child: new Text('Yes',
                                          style: TextStyle(color: Colors.red)),
                                    ),
                                  ],
                                ),
                              ),
                            },
                        'Admin Log Out'),
                  ],
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  Widget menuCard(Size size, Function onTap, String name) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: size.width * 0.45,
          width: size.width * 0.45,
          decoration: BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: kBlack.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 1), // changes position of shadow
                ),
              ]),
          child: Align(
              alignment: Alignment.center,
              child: Text(name,
                  style: kBodyText.copyWith(
                      color: kBlack, fontSize: size.width * 0.05))),
        ),
      ),
    );
  }
}
