import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/pallete.dart';
import 'package:flutter/material.dart';
import 'navigation-bloc.dart';
import '../widgets/FadeAnimation.dart';

class AboutBOT extends StatefulWidget with NavigationStates {
  @override
  _AboutBOTState createState() => _AboutBOTState();
}

class _AboutBOTState extends State<AboutBOT> {
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
          child: FadeAnimation(0.8, Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              Center(
                child: Text(
                  'About BOT',
                  style: kBodyText.copyWith(
                      color: kBlack, fontSize: 35, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Center(
                  child: Text(
                    'We are pretty much sure that soon we all will digitalized ourselves. In this making, we have to introduce a fresh gaming experience to change the concept of virtual gaming into real time. And in this way you will achieve something real in your hand.',
                    style: kBodyText.copyWith(color: kBlack),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: FadeAnimation(1.3, Column(
                  children: [
                    Center(
                      child: Text(
                        'The system will include these following modules:',
                        style: kBodyText.copyWith(color: kBlack),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: kBlack,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: kRed,width: 3, style: BorderStyle.solid)
                      ),
                      child: FadeAnimation(1.7, Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text(
                              'Login Information',
                              style: kBodyText.copyWith(color: kRed, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'You can login with your name (username), email, cell number and password. You can also login with your Facebook account.',
                              style: kBodyText.copyWith(color: kWhite),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: kBlack,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: kRed,width: 3, style: BorderStyle.solid)
                      ),
                      child: FadeAnimation(1.7, Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text(
                              'Access',
                              style: kBodyText.copyWith(color: kRed, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'The system will fetch the information about location and notification access.',
                              style: kBodyText.copyWith(color: kWhite),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: kBlack,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: kRed,width: 3, style: BorderStyle.solid)
                      ),
                      child: FadeAnimation(1.7, Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text(
                              'Destination',
                              style: kBodyText.copyWith(color: kRed, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'You will receive auto-generated time by entering your destination.',
                              style: kBodyText.copyWith(color: kWhite),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: kBlack,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: kRed,width: 3, style: BorderStyle.solid)
                      ),
                      child: FadeAnimation(1.7, Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text(
                              'Arrival',
                              style: kBodyText.copyWith(color: kRed, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'After successful arrival on your destinations, you will receive some BOT points.',
                              style: kBodyText.copyWith(color: kWhite),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: kBlack,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: kRed,width: 3, style: BorderStyle.solid)
                      ),
                      child: FadeAnimation(1.7, Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text(
                              'BOT Points',
                              style: kBodyText.copyWith(color: kRed, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'These points can be redeemed on different platforms provided by BOT collaborated companies.',
                              style: kBodyText.copyWith(color: kWhite),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: kBlack,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: kRed,width: 3, style: BorderStyle.solid)
                      ),
                      child: FadeAnimation(1.7, Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text(
                              'Unsuccessful Arrival',
                              style: kBodyText.copyWith(color: kRed, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'If you arrived before or after the time provided by BOT, you will receive the notification of try again.',
                              style: kBodyText.copyWith(color: kWhite),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                )),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          )),
        ),
      ),
    );
  }
}