import '../screens/screens.dart';
import '../widgets/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'navigation-bloc.dart';
import '../shared/pallete.dart';

class SupportScreen extends StatefulWidget with NavigationStates {
  @override
  _SupportScreenState createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
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
                      'Support',
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FeedbackScreen()),
                          );
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
                              'Leave Feedback',
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
                        onTap: () async{
                         var res = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ContactScreen()),
                          );
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
                              'Contact Us',
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
