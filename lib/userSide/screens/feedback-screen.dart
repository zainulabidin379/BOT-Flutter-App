import '../services/auth.dart';
import '../services/database.dart';
import '../shared/pallete.dart';
import '../widgets/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: kBlack),
        ),
        centerTitle: true,
      ),
      backgroundColor: kWhite,
      body: SingleChildScrollView(
        child: FadeAnimation(
            0.8,
            Column(
              children: [
                Container(
                  height: size.height * 0.45,
                  width: size.width,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 70,
                            width: 70,
                            child: Image.asset(
                              'assets/icons/heart.png',
                              color: kRed,
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Thank you for using',
                              style: kBodyText.copyWith(
                                color: kBlack,
                                fontSize: 22,
                              ),
                              maxLines: 2,
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              'BOT',
                              style: kBodyText.copyWith(
                                  color: kRed,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ]),
                ),
                FadeAnimation(
                  1.3,
                  Container(
                    height: size.height * 0.45,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: kBlack.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Text(
                              'How was your experience with BOT',
                              style: kBodyText.copyWith(
                                  color: kBlack,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await DatabaseService(
                                          uid: _auth.getCurrentUser())
                                      .addUserFeedbackData('Bad');
                                  Navigator.pop(context);
                                  Get.snackbar(
                                    'Thank You for your kind feedback',
                                    'We will keep improving your experience at BOT',
                                    duration: Duration(seconds: 5),
                                    backgroundColor: kBlack,
                                    colorText: kWhite,
                                    snackPosition: SnackPosition.TOP,
                                    borderRadius: 0,
                                    margin: EdgeInsets.all(0),
                                  );
                                },
                                child: Column(
                                  children: [
                                    Container(
                                        height: 60,
                                        width: 60,
                                        child: Image.asset(
                                          'assets/icons/bad.png',
                                          color: kRed,
                                        )),
                                    SizedBox(height: 10),
                                    Text(
                                      'Bad',
                                      style: kBodyText.copyWith(
                                          color: kBlack, fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 30),
                              GestureDetector(
                                onTap: () async {
                                  Navigator.pop(context);
                                  
                                  Get.snackbar(
                                    'Thank You for your kind feedback',
                                    'We will keep improving your experience at BOT',
                                    duration: Duration(seconds: 5),
                                    backgroundColor: kBlack,
                                    colorText: kWhite,
                                    snackPosition: SnackPosition.TOP,
                                    borderRadius: 0,
                                    margin: EdgeInsets.all(0),
                                  );
                                  await DatabaseService(
                                          uid: _auth.getCurrentUser())
                                      .addUserFeedbackData('Average');
                                },
                                child: Column(
                                  children: [
                                    Container(
                                        height: 60,
                                        width: 60,
                                        child: Image.asset(
                                          'assets/icons/average.png',
                                          color: kRed,
                                        )),
                                    SizedBox(height: 10),
                                    Text(
                                      'Average',
                                      style: kBodyText.copyWith(
                                          color: kBlack, fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 30),
                              GestureDetector(
                                onTap: () async {
                                  await DatabaseService(
                                          uid: _auth.getCurrentUser())
                                      .addUserFeedbackData('Good');
                                  Navigator.pop(context);
                                  Get.snackbar(
                                    'Thank You for your kind feedback',
                                    'We will keep improving your experience at BOT',
                                    duration: Duration(seconds: 5),
                                    backgroundColor: kBlack,
                                    colorText: kWhite,
                                    snackPosition: SnackPosition.TOP,
                                    borderRadius: 0,
                                    margin: EdgeInsets.all(0),
                                  );
                                },
                                child: Column(
                                  children: [
                                    Container(
                                        height: 60,
                                        width: 60,
                                        child: Image.asset(
                                          'assets/icons/good.png',
                                          color: kRed,
                                        )),
                                    SizedBox(height: 10),
                                    Text(
                                      'Good',
                                      style: kBodyText.copyWith(
                                          color: kBlack, fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await DatabaseService(
                                          uid: _auth.getCurrentUser())
                                      .addUserFeedbackData('Very Good');
                                  Navigator.pop(context);
                                  Get.snackbar(
                                    'Thank You for your kind feedback',
                                    'We will keep improving your experience at BOT',
                                    duration: Duration(seconds: 5),
                                    backgroundColor: kBlack,
                                    colorText: kWhite,
                                    snackPosition: SnackPosition.TOP,
                                    borderRadius: 0,
                                    margin: EdgeInsets.all(0),
                                  );
                                },
                                child: Column(
                                  children: [
                                    Container(
                                        height: 60,
                                        width: 60,
                                        child: Image.asset(
                                          'assets/icons/veryGood.png',
                                          color: kRed,
                                        )),
                                    SizedBox(height: 10),
                                    Text(
                                      'Very Good',
                                      style: kBodyText.copyWith(
                                          color: kBlack, fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 30),
                              GestureDetector(
                                onTap: () async {
                                  await DatabaseService(
                                          uid: _auth.getCurrentUser())
                                      .addUserFeedbackData('Awesome');
                                      
                                  Navigator.pop(context);
                                  Get.snackbar(
                                    'Thank You for your kind feedback',
                                    'We will keep improving your experience at BOT',
                                    duration: Duration(seconds: 5),
                                    backgroundColor: kBlack,
                                    colorText: kWhite,
                                    snackPosition: SnackPosition.TOP,
                                    borderRadius: 0,
                                    margin: EdgeInsets.all(0),
                                  );
                                },
                                child: Column(
                                  children: [
                                    Container(
                                        height: 60,
                                        width: 60,
                                        child: Image.asset(
                                          'assets/icons/awesome.png',
                                          color: kRed,
                                        )),
                                    SizedBox(height: 10),
                                    Text(
                                      'Awesome',
                                      style: kBodyText.copyWith(
                                          color: kBlack, fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ]),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
