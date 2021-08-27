import 'package:auto_size_text/auto_size_text.dart';
import 'package:bot_app/adminSide/updateOffer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'addOffers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'pallete.dart';

class Offers extends StatefulWidget {
  @override
  _OffersState createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  Future getOffers() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection('offers').get();

    return qn.docs;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      //Appbar
      appBar: AppBar(
        elevation: 0,
        title: Text('Offers'),
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
          children: [
            SizedBox(height: 8),
            FutureBuilder(
                future: getOffers(),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: SpinKitFadingCircle(color: kRed),
                    );
                  } else {
                    return Column(
                      children: [
                        addOfferButton(size, 'Add New Offer'),
                        for (var i = 0; i < snapshot.data.length; i++)
                          offersCard(
                            size,
                            snapshot.data[i]['uid'],
                            snapshot.data[i]['companyName'],
                            snapshot.data[i]['offerDescription'],
                            snapshot.data[i]['offer'],
                            snapshot.data[i]['logo'],
                          ),
                      ],
                    );
                  }
                }),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  //Add New Offer Button
  Widget addOfferButton(Size size, String name) {
    return GestureDetector(
      onTap: () {
        Get.to(() => AddOffer());
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 8),
        child: Center(
          child: Container(
            height: 60,
            width: size.width * 0.95,
            decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: kRed, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: kBlack.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 5), // changes position of shadow
                  ),
                ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Center(
                  child: Text(
                name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              )),
            ),
          ),
        ),
      ),
    );
  }

  Widget offersCard(Size size, String uid, String companyName,
      String offerDiscription, String offer, String companyLogo) {
    return Container(
      margin: const EdgeInsets.only(
        top: 15,
        bottom: 15,
      ),
      child: Column(
        children: [
          Container(
                margin: EdgeInsets.only(left: 64.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(() => UpdateOffer(id: uid));
                  },
                  child: Container(
                    height: 40,
                    width: size.width * 0.385,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.zero,
                        bottomLeft: Radius.zero,
                        bottomRight: Radius.zero,
                      ),
                    ),
                    child:
                        Center(child: Icon(FontAwesomeIcons.pen, color: kWhite)),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => new AlertDialog(
                        title: new Text('Are you sure?'),
                        content: new Text('Do you want to delete this offer?'),
                        actions: <Widget>[
                          new TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child:
                                new Text('No', style: TextStyle(color: kBlack)),
                          ),
                          new TextButton(
                            onPressed: () async {
                              FirebaseFirestore.instance
                                  .collection('offers')
                                  .doc(uid)
                                  .delete()
                                  .catchError((e) {
                                print(e);
                              });
                              Navigator.of(context).pop();
                              setState(() {});
                              Get.snackbar(
                                'Message',
                                'Offer is deleted from database',
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
                    );
                  },
                  child: Container(
                    height: 40,
                    width: size.width * 0.385,
                    decoration: BoxDecoration(
                      color: kRed,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.zero,
                        topRight: Radius.circular(8),
                        bottomLeft: Radius.zero,
                        bottomRight: Radius.zero,
                      ),
                    ),
                    child: Center(
                        child: Icon(FontAwesomeIcons.trash, color: kWhite)),
                  ),
                ),
              ],
            ),
          ),
          Stack(
            children: <Widget>[
              Container(
                height: 140.0,
                width: size.width*0.77,
                margin: EdgeInsets.only(left: 33.0),
                decoration: BoxDecoration(
                  color: kBlack,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.zero,
                    topRight: Radius.zero,
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
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
                margin: EdgeInsets.only(left: 115.0, right: 15.0),
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
                    SizedBox(height: 2.0),
                    AutoSizeText(offerDiscription,
                        maxLines: 2, style: kBodyText.copyWith(fontSize: 12)),
                    SizedBox(height: 6.0),
                    Text(offer,
                        style: kBodyText.copyWith(
                            fontSize: 18,
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
        ],
      ),
    );
  }
}
