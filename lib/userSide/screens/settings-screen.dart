import 'package:bot_app/adminSide/adminHomeScreen.dart';
import 'package:get/get.dart';

import '../screens/screens.dart';
import '../widgets/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'navigation-bloc.dart';
import '../shared/pallete.dart';

class SettingsScreen extends StatefulWidget with NavigationStates {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Future<bool> _onWillPop() async {
    BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.HomePageClickedEvent);
    return  false;
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
          child: Scaffold(
        backgroundColor: kWhite,
        body: SingleChildScrollView(
          child: FadeAnimation(
              0.8,
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: Text(
                      'Settings',
                      style: kBodyText.copyWith(
                          color: kBlack,
                          fontSize: 35,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  
                  FadeAnimation(
                    1,
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: InkWell(
                        onTap: () {
                        },
                        child: Container(
                            alignment: Alignment.center,
                            height: 60.0,
                            decoration: BoxDecoration(color: kWhite, boxShadow: [
                              BoxShadow(
                                color: kBlack.withOpacity(0.3),
                                spreadRadius: 0.5,
                                blurRadius: 6,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ]),
                            child: Text(
                              'Setting 1',
                              style: kBodyText.copyWith(
                                  fontWeight: FontWeight.bold, color: kBlack),
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                    1,
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: InkWell(
                        onTap: () async{},
                        child: Container(
                            alignment: Alignment.center,
                            height: 60.0,
                            decoration: BoxDecoration(color: kWhite, boxShadow: [
                              BoxShadow(
                                color: kBlack.withOpacity(0.3),
                                spreadRadius: 0.5,
                                blurRadius: 6,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ]),
                            child: Text(
                              'Setting 2',
                              style: kBodyText.copyWith(
                                  fontWeight: FontWeight.bold, color: kBlack),
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                    1,
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: InkWell(
                        onTap: () async{},
                        child: Container(
                            alignment: Alignment.center,
                            height: 60.0,
                            decoration: BoxDecoration(color: kWhite, boxShadow: [
                              BoxShadow(
                                color: kBlack.withOpacity(0.3),
                                spreadRadius: 0.5,
                                blurRadius: 6,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ]),
                            child: Text(
                              'Setting 3',
                              style: kBodyText.copyWith(
                                  fontWeight: FontWeight.bold, color: kBlack),
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                    1,
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: InkWell(
                        onTap: () async{},
                        child: Container(
                            alignment: Alignment.center,
                            height: 60.0,
                            decoration: BoxDecoration(color: kWhite, boxShadow: [
                              BoxShadow(
                                color: kBlack.withOpacity(0.3),
                                spreadRadius: 0.5,
                                blurRadius: 6,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ]),
                            child: Text(
                              'Setting 4',
                              style: kBodyText.copyWith(
                                  fontWeight: FontWeight.bold, color: kBlack),
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                    1,
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: InkWell(
                        onTap: () async{},
                        child: Container(
                            alignment: Alignment.center,
                            height: 60.0,
                            decoration: BoxDecoration(color: kWhite, boxShadow: [
                              BoxShadow(
                                color: kBlack.withOpacity(0.3),
                                spreadRadius: 0.5,
                                blurRadius: 6,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ]),
                            child: Text(
                              'Setting 5',
                              style: kBodyText.copyWith(
                                  fontWeight: FontWeight.bold, color: kBlack),
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                    1,
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: InkWell(
                        onTap: () async{},
                        child: Container(
                            alignment: Alignment.center,
                            height: 60.0,
                            decoration: BoxDecoration(color: kWhite, boxShadow: [
                              BoxShadow(
                                color: kBlack.withOpacity(0.3),
                                spreadRadius: 0.5,
                                blurRadius: 6,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ]),
                            child: Text(
                              'Setting 6',
                              style: kBodyText.copyWith(
                                  fontWeight: FontWeight.bold, color: kBlack),
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                    1,
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: InkWell(
                        onTap: () async{},
                        child: Container(
                            alignment: Alignment.center,
                            height: 60.0,
                            decoration: BoxDecoration(color: kWhite, boxShadow: [
                              BoxShadow(
                                color: kBlack.withOpacity(0.3),
                                spreadRadius: 0.5,
                                blurRadius: 6,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ]),
                            child: Text(
                              'Setting 7',
                              style: kBodyText.copyWith(
                                  fontWeight: FontWeight.bold, color: kBlack),
                            )),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
