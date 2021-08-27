import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:the_validator/the_validator.dart';
import 'package:uuid/uuid.dart';
import 'pallete.dart';

class AddOffer extends StatefulWidget {
  AddOffer({Key key}) : super(key: key);

  @override
  _AddOfferState createState() => _AddOfferState();
}

class _AddOfferState extends State<AddOffer> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //final AuthService _auth = AuthService();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final offerController = TextEditingController();
  final botPointsController = TextEditingController();

  File _image;
  final picker = ImagePicker();
  bool fileSelected = false;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        setState(() {
          fileSelected = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Offer'),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: kRed,
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
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 35.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Name
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 20),
                          child: TextFormField(
                            controller: nameController,
                            style: kBodyText.copyWith(color: kBlack),
                            cursorColor: kBlack,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 14),
                              hintText: 'Name of Company',
                              hintStyle: kBodyText.copyWith(
                                  fontSize: 20, color: Colors.grey),
                              errorStyle: TextStyle(
                                fontSize: 14,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    BorderSide(color: kBlack, width: 1.5),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: kBlack,
                                  width: 1.5,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: kBlack,
                                  width: 1.5,
                                ),
                              ),
                            ),
                            validator: FieldValidator.multiple([
                              FieldValidator.required(),
                              FieldValidator.minLength(1,
                                  message: 'Please enter a valid company name'),
                            ]),
                          ),
                        ),

                        //description
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 20),
                          child: TextFormField(
                            controller: descriptionController,
                            style: kBodyText.copyWith(color: kBlack),
                            cursorColor: kBlack,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 14),
                              hintText: 'Offer Description',
                              hintStyle: kBodyText.copyWith(
                                  fontSize: 20, color: Colors.grey),
                              errorStyle: TextStyle(
                                fontSize: 14,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    BorderSide(color: kBlack, width: 1.5),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: kBlack,
                                  width: 1.5,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: kBlack,
                                  width: 1.5,
                                ),
                              ),
                            ),
                            validator: FieldValidator.multiple([
                              FieldValidator.required(),
                              FieldValidator.minLength(3,
                                  message: 'Please enter a valid description'),
                            ]),
                          ),
                        ),

                        //offer
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 20),
                          child: TextFormField(
                            controller: offerController,
                            style: kBodyText.copyWith(color: kBlack),
                            cursorColor: kBlack,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 14),
                              hintText: 'Offer',
                              hintStyle: kBodyText.copyWith(
                                  fontSize: 20, color: Colors.grey),
                              errorStyle: TextStyle(
                                fontSize: 14,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    BorderSide(color: kBlack, width: 1.5),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: kBlack,
                                  width: 1.5,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: kBlack,
                                  width: 1.5,
                                ),
                              ),
                            ),
                            validator: FieldValidator.multiple([
                              FieldValidator.required(),
                              FieldValidator.minLength(1,
                                  message: 'Please enter a valid offer'),
                              FieldValidator.maxLength(50,
                                  message: 'Please enter a short description'),
                            ]),
                          ),
                        ),

                        //BOTPoints
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 20),
                          child: TextFormField(
                            controller: botPointsController,
                            style: kBodyText.copyWith(color: kBlack),
                            cursorColor: kBlack,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 14),
                              hintText: 'Required BOT Points',
                              hintStyle: kBodyText.copyWith(
                                  fontSize: 20, color: Colors.grey),
                              errorStyle: TextStyle(
                                fontSize: 14,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    BorderSide(color: kBlack, width: 1.5),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: kBlack,
                                  width: 1.5,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: kBlack,
                                  width: 1.5,
                                ),
                              ),
                            ),
                            validator: FieldValidator.multiple([
                              FieldValidator.required(),
                            ]),
                          ),
                        ),

                        //Choose Logo
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 20),
                          child: Center(
                            child: InkWell(
                              onTap: () async {
                                getImage();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20),
                                height: 50,
                                width: size.width * 0.9,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: kBlack,
                                ),
                                child: Center(
                                  child: Text(
                                    fileSelected
                                        ? 'Logo File Selected'
                                        : 'Choose Logo',
                                    style: kBodyText.copyWith(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 25,
                        ),
                        Center(
                          child: InkWell(
                            onTap: () async {
                              if (fileSelected) {
                                if (_formKey.currentState.validate()) {
                                  String uid = Uuid().v4();
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        SpinKitFadingCircle(
                                      color: kRed,
                                      size: 50.0,
                                    ),
                                  );

                                  Reference firebaseStorageRef = FirebaseStorage
                                      .instance
                                      .ref()
                                      .child('offers/$uid');
                                  UploadTask uploadTask =
                                      firebaseStorageRef.putFile(_image);
                                  uploadTask.whenComplete(() async {
                                    String url = await firebaseStorageRef
                                        .getDownloadURL();
                                    FirebaseFirestore.instance
                                        .collection("offers")
                                        .doc(uid)
                                        .set({
                                      "companyName": nameController.text,
                                      "offerDescription":
                                          descriptionController.text,
                                      "offer": offerController.text,
                                      "logo": url,
                                      "uid": uid,
                                      "botPoints": botPointsController.text,
                                    }).then((_) {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      setState(() {});
                                      Get.snackbar(
                                        'Successfully Added',
                                        'New offer successfully added.',
                                        duration: Duration(seconds: 4),
                                        backgroundColor: kBlack,
                                        colorText: kWhite,
                                        borderRadius: 10,
                                      );
                                    });
                                  }).catchError((onError) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(onError)));
                                  });
                                }
                              } else {
                                Get.snackbar(
                                  'Logo Not Selected',
                                  'Please select logo and try again.',
                                  duration: Duration(seconds: 4),
                                  backgroundColor: kBlack,
                                  colorText: kWhite,
                                  borderRadius: 10,
                                );
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20),
                              height: 50,
                              width: size.width * 0.9,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: kRed,
                              ),
                              child: Center(
                                child: Text(
                                  'Add Offer',
                                  style: kBodyText.copyWith(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
