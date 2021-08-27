import '../screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:location/location.dart';

class LocationStatusCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder(
      future: Location().serviceEnabled(),
      builder: (context, snapshot) {
        if (snapshot.data == true) {
          return SidebarLayout();
        } else if (snapshot.data == false) {
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
                        'assets/images/location.png',
                        color: kWhite,
                      )),
                ),
                SizedBox(height: size.height * 0.05),
                Center(
                    child: Text(
                  'Location Service is not Enabled!',
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
                    "Please enable location services for a better experience.",
                    style:
                        TextStyle(fontSize: size.width * 0.04, color: kWhite),
                    textAlign: TextAlign.center,
                  ),
                )),
                SizedBox(height: size.height * 0.03),
                TextButton(
                    onPressed: () async {
                      await Location().requestService();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => this));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(26)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 6),
                        child: Text('Enable Location',
                            style: kBodyText.copyWith(color: kBlack)),
                      ),
                    )),
              ],
            ),
          );
        } else {
          return Center(
            child: SpinKitFadingCircle(
              color: kRed,
              size: 50.0,
            ),
          );
        }
      },
    );
  }
}
