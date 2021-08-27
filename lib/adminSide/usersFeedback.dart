import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'pallete.dart';

class UsersFeedback extends StatefulWidget {
  UsersFeedback({Key key}) : super(key: key);

  @override
  _UsersFeedbackState createState() => _UsersFeedbackState();
}

class _UsersFeedbackState extends State<UsersFeedback> {
  Future getUsersFeedback() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection('users_feedback_data').get();
    return qn.docs;
  }

  int bad = 0;
  int average = 0;
  int good = 0;
  int vGood = 0;
  int awesome = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    calculateFeedback();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      //Appbar
      appBar: AppBar(
        elevation: 0,
        title: Text('User FeedBacks'),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: kRed,
        //Back Button
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Icon(Icons.arrow_back_ios),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                feedbackCard(size, bad.toString(), 'Bad'),
                feedbackCard(size, average.toString(), 'Average'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                feedbackCard(size, good.toString(), 'Good'),
                feedbackCard(size, vGood.toString(), 'Very Good'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                feedbackCard(size, awesome.toString(), 'Awesome'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  calculateFeedback() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection('users_feedback_data').get();
    for (var i = 0; i < qn.docs.length; i++)
      if (qn.docs[i]['feedback'] == 'Bad') {
        setState(() {
          bad++;
        });
      } else if (qn.docs[i]['feedback'] == 'Average') {
        setState(() {
          average++;
        });
      } else if (qn.docs[i]['feedback'] == 'Good') {
        setState(() {
          good++;
        });
      } else if (qn.docs[i]['feedback'] == 'Very Good') {
        setState(() {
          vGood++;
        });
      } else if (qn.docs[i]['feedback'] == 'Awesome') {
        setState(() {
          awesome++;
        });
      }
  }

  Widget feedbackCard(Size size, String data, String feedback) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(data,
                    style: kBodyText.copyWith(
                        color: kRed, fontSize: size.width * 0.1)),
                Text(feedback,
                    style: kBodyText.copyWith(
                        color: kBlack, fontSize: size.width * 0.06)),
              ],
            )),
      ),
    );
  }
}
