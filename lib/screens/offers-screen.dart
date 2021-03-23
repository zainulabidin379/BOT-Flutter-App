import 'package:bot_app/shared/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'navigation-bloc.dart';
import 'package:get/get.dart';

class Offers extends StatelessWidget with NavigationStates  {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: GestureDetector(
            onTap: (){
              Get.defaultDialog(
                title: "",
                content: SpinKitThreeBounce(
                color: kRed,
                size: 50.0,
              ),);
            },
            child: Container(
              width: 200,
              height: 200,
              color: kRed,
              child: Text('Button'),
            ),
          ),
        ),
    );
  }
}
