import 'file:///C:/Users/Zain%20Ul%20Abidin/Documents/AndroidStudioProjects/bot_app/lib/shared/pallete.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'navigation-bloc.dart';
import 'package:bot_app/widgets/FadeAnimation.dart';

class OurTeam extends StatefulWidget with NavigationStates  {
  @override
  _OurTeamState createState() => _OurTeamState();
}

class _OurTeamState extends State<OurTeam> {
  final List<List<String>> products = [
    [
      'assets/images/team1.jpg',
      'Muhammad Junaid Hassan Kharal',
      'Cheif Executive Officer'
    ],
    [
      'assets/images/team2.jpg',
      'Shams Ur Rehman',
      'Cofounder'
    ],
    [
      'assets/images/team3.jpeg',
      'Wajiha Ajmal',
      'Managing Director'
    ]
  ];

  int currentIndex = 0;

  void _next() {
    setState(() {
      if (currentIndex < products.length -1) {
        currentIndex++;
      } else {
        currentIndex = currentIndex;
      }
    });
  }

  void _preve() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
      } else {
        currentIndex = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            GestureDetector(
              onHorizontalDragEnd: (DragEndDetails details) {
                if (details.velocity.pixelsPerSecond.dx > 0) {
                  _preve();
                } else if (details.velocity.pixelsPerSecond.dx < 0) {
                  _next();
                }
              },
              child: FadeAnimation(.8, Container(
                width: double.infinity,
                height: 550,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(products[currentIndex][0]),
                        fit: BoxFit.cover
                    )
                ),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          colors: [
                            Colors.grey[700].withOpacity(.9),
                            Colors.grey.withOpacity(.0),
                          ]
                      )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FadeAnimation(1, Container(
                        width: 90,
                        margin: EdgeInsets.only(bottom: 60),
                        child: Row(
                          children: _buildIndicator(),
                        ),
                      ))
                    ],
                  ),
                ),
              )),
            ),
            Expanded(
              child: Transform.translate(
                offset: Offset(0, -20),
                child: FadeAnimation(1, Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(child: FadeAnimation(1.3, Text(products[currentIndex][1], style: TextStyle(color: Colors.grey[800], fontSize: 27, fontWeight: FontWeight.bold),textAlign: TextAlign.center,))),
                      SizedBox(height: 2,),
                      Center(child: Text(products[currentIndex][2], style: kBodyText.copyWith(color: kBlack))),
                      SizedBox(height: 25,),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: FadeAnimation(1.7, Container(
                            height: 45,
                            decoration: BoxDecoration(
                                color: kRed,
                                borderRadius: BorderRadius.circular(26)
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(FontAwesomeIcons.instagram, color: kWhite,),
                                  SizedBox(width: 10,),
                                  Text("Follow", style: TextStyle(fontSize: 19,color: kWhite,fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ),
                          )),
                        ),
                      )
                    ],
                  ),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return Expanded(
      child: Container(
        height: 4,
        margin: EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: isActive ? Colors.grey[800] : Colors.white
        ),
      ),
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for(int i = 0; i < products.length; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }

    return indicators;
  }
}