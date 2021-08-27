import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../shared/pallete.dart';
import '../widgets/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'navigation-bloc.dart';

class Offers extends StatefulWidget with NavigationStates {
  @override
  _OffersState createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  Future<bool> _onWillPop() async {
    BlocProvider.of<NavigationBloc>(context)
        .add(NavigationEvents.HomePageClickedEvent);
    return false;
  }

  Future getOffers() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection('offers').get();

    return qn.docs;
  }

  double botPOints = 0;
  Future getBotPoints() async {
    String uid = FirebaseAuth.instance.currentUser.uid;
    var firestore = FirebaseFirestore.instance;
    await firestore.collection('users_collection').doc(uid).get().then((value) {
      setState(() {
        botPOints = value['botPoints'].toDouble();
      });
    });
  }

  @override
  void initState() {
    getBotPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: FadeAnimation(
          0.8,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Center(
                child: Text(
                  'Available Offers',
                  style: kBodyText.copyWith(
                      color: kBlack,
                      fontSize: size.width * 0.1,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'Your BOT Points:  ',
                  style: kBodyText.copyWith(
                      color: kBlack, fontSize: size.width * 0.05),
                ),
                Text(
                  '$botPOints',
                  style: kBodyText.copyWith(
                      color: kRed,
                      fontSize: size.width * 0.07,
                      fontWeight: FontWeight.bold),
                ),
              ]),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 8),
                      FutureBuilder(
                          future: getOffers(),
                          builder: (_, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: SpinKitFadingCircle(color: kRed),
                              );
                            } else {
                              return Column(
                                children: [
                                  for (var i = 0; i < snapshot.data.length; i++)
                                    offersCard(
                                      snapshot.data[i]['companyName'],
                                      snapshot.data[i]['offerDescription'],
                                      snapshot.data[i]['offer'],
                                      snapshot.data[i]['logo'],
                                      snapshot.data[i]['botPoints'],
                                    ),
                                ],
                              );
                            }
                          }),
                      SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget offersCard(String companyName, String offerDiscription, String offer,
      String companyLogo, String offerBotPoints) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Get this offer for $offerBotPoints BOT Points?'),
            content: new Text(
                'If Yes, then handover your phone to reception to avail offer.'),
            actions: <Widget>[
              new TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: new Text('No', style: TextStyle(color: kRed)),
              ),
              new TextButton(
                onPressed: () async {
                  if (botPOints >= double.parse(offerBotPoints)) {
                    Navigator.pop(context);
                    botPOints = botPOints - double.parse(offerBotPoints);
                    Get.snackbar(
                      'Offer Availed',
                      "You successfully availed $offer at $companyName",
                      duration: Duration(seconds: 5),
                      backgroundColor: Colors.green,
                      colorText: kWhite,
                      snackPosition: SnackPosition.TOP,
                      borderRadius: 0,
                      margin: EdgeInsets.all(0),
                    );
                    String uid = FirebaseAuth.instance.currentUser.uid;
                    FirebaseFirestore.instance
                        .collection('users_collection')
                        .doc(uid)
                        .update({
                      "botPoints": botPOints,
                    });
                    getBotPoints();
                  } else {
                    Navigator.pop(context);
                    Get.snackbar(
                      'Not enough BOT Points',
                      "You don't have enough BOT points, earn more to avail this offer.",
                      duration: Duration(seconds: 5),
                      backgroundColor: kRed,
                      colorText: kWhite,
                      snackPosition: SnackPosition.TOP,
                      borderRadius: 0,
                      margin: EdgeInsets.all(0),
                    );
                  }
                },
                child:
                    new Text('Proceed', style: TextStyle(color: Colors.green)),
              ),
            ],
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 24.0,
        ),
        child: Stack(
          children: <Widget>[
            Container(
              height: 124.0,
              margin: EdgeInsets.only(left: 46.0),
              decoration: BoxDecoration(
                color: kBlack,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 10.0),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 115.0, right: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 15.0),
                  Text(
                    companyName,
                    style: kBodyText.copyWith(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5.0),
                  AutoSizeText(offerDiscription,
                      maxLines: 2, style: kBodyText.copyWith(fontSize: 12)),
                  SizedBox(height: 6.0),
                  AutoSizeText(offer,
                      style: kBodyText.copyWith(
                          fontSize: 20,
                          color: kRed,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 16.0),
              alignment: FractionalOffset.centerLeft,
              height: 92,
              width: 92,
              decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: kRed, width: 2),
                  image: DecorationImage(
                    image: NetworkImage(companyLogo),
                    fit: BoxFit.cover,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
