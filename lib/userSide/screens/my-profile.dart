import '../screens/navigation-bloc.dart';
import '../services/auth.dart';
import '../services/database.dart';
import '../shared/pallete.dart';
import '../widgets/FadeAnimation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class MyProfile extends StatefulWidget with NavigationStates {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final AuthService _auth = AuthService();
  bool isEditing = false;

  String name;
  String email;
  String phone;
  String password;
  String dpUrl;
  String location;
  String birthDate;
  DateTime _birthDate;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final locationController = TextEditingController();
  final birthDateController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    locationController.dispose();
    birthDateController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Future<bool> _onWillPop() async {
    BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.HomePageClickedEvent);
    return  false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
          child: Scaffold(
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
                      'My Profile',
                      style: kBodyText.copyWith(
                          color: kBlack,
                          fontSize: 35,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 15),
                          FadeAnimation(
                            1,
                            SizedBox(
                              height: 115,
                              width: 115,
                              child: Stack(
                                clipBehavior: Clip.none, fit: StackFit.expand ,
                                children: [
                                  CircleAvatar(
                                    radius: 45,
                                    backgroundColor: kRed,
                                    child: CircleAvatar(
                                      radius: 53,
                                      backgroundImage:
                                          AssetImage('assets/images/team1.jpg'),
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: GestureDetector(
                                        onTap: () {
                                          //pickImage();
                                        },
                                        child: Container(
                                          height: 36,
                                          width: 36,
                                          decoration: BoxDecoration(
                                            color: kBlack,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                            child: Icon(
                                              FontAwesomeIcons.camera,
                                              color: kWhite,
                                              size: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          FadeAnimation(
                            1.3,
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 45, vertical: 10),
                              child: TextField(
                                controller: nameController,
                                enabled: isEditing,
                                cursorColor: kBlack,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: kBlack,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 26),
                                  labelText: 'Name',
                                  labelStyle:
                                      TextStyle(color: kRed, fontSize: 18),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: name,
                                  hintStyle: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(26.0),
                                    borderSide: BorderSide(
                                      color: kBlack,
                                      width: 1.5,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(26.0),
                                    borderSide: BorderSide(
                                      color: kBlack,
                                      width: 1.5,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(26.0),
                                    borderSide: BorderSide(
                                      color: kBlack,
                                      width: 1.5,
                                    ),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(26.0),
                                    borderSide: BorderSide(
                                      color: kBlack,
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          FadeAnimation(
                            1.3,
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 45, vertical: 10),
                              child: TextField(
                                controller: emailController,
                                enabled: isEditing,
                                cursorColor: kBlack,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 26),
                                  labelText: 'Email',
                                  labelStyle:
                                      TextStyle(color: kRed, fontSize: 18),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: email,
                                  hintStyle: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(26.0),
                                    borderSide: BorderSide(
                                      color: kBlack,
                                      width: 1.5,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(26.0),
                                    borderSide: BorderSide(
                                      color: kBlack,
                                      width: 1.5,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(26.0),
                                    borderSide: BorderSide(
                                      color: kBlack,
                                      width: 1.5,
                                    ),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(26.0),
                                    borderSide: BorderSide(
                                      color: kBlack,
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          FadeAnimation(
                            1.3,
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 45, vertical: 10),
                              child: TextField(
                                controller: phoneController,
                                enabled: isEditing,
                                cursorColor: kBlack,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 26),
                                  labelText: 'Phone Number',
                                  labelStyle:
                                      TextStyle(color: kRed, fontSize: 18),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: phone,
                                  hintStyle: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(26.0),
                                    borderSide: BorderSide(
                                      color: kBlack,
                                      width: 1.5,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(26.0),
                                    borderSide: BorderSide(
                                      color: kBlack,
                                      width: 1.5,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(26.0),
                                    borderSide: BorderSide(
                                      color: kBlack,
                                      width: 1.5,
                                    ),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(26.0),
                                    borderSide: BorderSide(
                                      color: kBlack,
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          FadeAnimation(
                            1.3,
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 45, vertical: 10),
                              child: TextField(
                                controller: locationController,
                                enabled: isEditing,
                                cursorColor: kBlack,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 26),
                                  labelText: 'Location',
                                  labelStyle:
                                      TextStyle(color: kRed, fontSize: 18),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: location,
                                  hintStyle: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(26.0),
                                    borderSide: BorderSide(
                                      color: kBlack,
                                      width: 1.5,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(26.0),
                                    borderSide: BorderSide(
                                      color: kBlack,
                                      width: 1.5,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(26.0),
                                    borderSide: BorderSide(
                                      color: kBlack,
                                      width: 1.5,
                                    ),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(26.0),
                                    borderSide: BorderSide(
                                      color: kBlack,
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          FadeAnimation(
                            1.3,
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 45, top: 10, right: 45),
                                  child: TextField(
                                    enabled: false,
                                    obscureText: true,
                                    cursorColor: kBlack,
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 26),
                                      labelText: 'Birth Date',
                                      labelStyle:
                                          TextStyle(color: kRed, fontSize: 18),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      hintText: birthDate,
                                      hintStyle: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(26.0),
                                        borderSide: BorderSide(
                                          color: kBlack,
                                          width: 1.5,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(26.0),
                                        borderSide: BorderSide(
                                          color: kBlack,
                                          width: 1.5,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(26.0),
                                        borderSide: BorderSide(
                                          color: kBlack,
                                          width: 1.5,
                                        ),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(26.0),
                                        borderSide: BorderSide(
                                          color: kBlack,
                                          width: 1.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                isEditing ? Padding(
                                  padding: const EdgeInsets.only(right: 65.0, top: 20),
                                  child: InkWell(
                                    onTap: () {
                                      _selectDate(context);
                                    },
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Icon(FontAwesomeIcons.calendarAlt,
                                      color: kRed),
                                    ),
                                  ),
                                ) : SizedBox()

                              ],
                            ),
                          ),
                          isEditing ? editingButtons() : updateButton(),
                        ],
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }

  FadeAnimation updateButton() {
    return FadeAnimation(
      1.5,
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 45, vertical: 15),
        child: InkWell(
          onTap: () async {
            setState(() {
              isEditing = true;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26),
              color: kRed,
            ),
            child: Center(
              child: Text(
                'Update Profile',
                style: kBodyText,
              ),
            ),
          ),
        ),
      ),
    );
  }

  FadeAnimation editingButtons() {
    return FadeAnimation(
      1.5,
      Row(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 45.0, right: 10.0, top: 15.0),
            child: InkWell(
              onTap: () async {
                setState(() {
                  isEditing = false;
                });
              },
              child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(26.0)),
                  child: Text(
                    'Cancel',
                    style: kBodyText,
                  )),
            ),
          )),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 45.0, top: 15),
            child: InkWell(
              onTap: () async{
                setState(() {
                  isEditing = false;

                  if(nameController.text == ''){
                    nameController.text = name;
                  }if(emailController.text == ''){
                    emailController.text = email;
                  }if(phoneController.text == ''){
                    phoneController.text = phone;
                  }if(locationController.text == ''){
                    locationController.text = location;
                  }

                });
                await DatabaseService(uid: _auth.getCurrentUser()).updateUserData(
                  nameController.text,
                  emailController.text,
                  phoneController.text,
                  'null',
                  locationController.text,
                  birthDate,
                );
                Get.snackbar(
                  'Message',
                  'Profile updated',
                  duration: Duration(seconds: 3),
                  backgroundColor: kBlack,
                  colorText: kWhite,
                  snackPosition: SnackPosition.BOTTOM,
                  borderRadius: 0,
                  margin: EdgeInsets.all(0),
                );
              },
              child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  decoration: BoxDecoration(
                      color: kRed, borderRadius: BorderRadius.circular(26.0)),
                  child: Text(
                    'Save',
                    style: kBodyText,
                  )),
            ),
          ))
        ],
      ),
    );
  }

  Future<Null> _selectDate(BuildContext context) async{
    final DateTime _setDate = await showDatePicker(
        context: context,
        initialDate: _birthDate == null ? DateTime.now() : _birthDate,
        firstDate: DateTime(1970),
        lastDate: DateTime.now(),
        builder: (context,child) {
          return SingleChildScrollView(child: child,);
        }
    );
    if(_setDate!=null) {
      setState(() {
        _birthDate = _setDate;
        birthDate = "${_birthDate.month}-${_birthDate.day}-${_birthDate.year}";
        print(birthDate);
      });
    }
  }

  fetchData() async {
    var currentUser = _auth.getCurrentUser();
    DocumentSnapshot variable = await FirebaseFirestore.instance
        .collection('users_collection')
        .doc(currentUser)
        .get();
    setState(() {
      name = variable['name'];
      email = variable['email'];
      phone = variable['phone'];
      dpUrl = variable['dpUrl'];
      location = variable['location'];
      birthDate = variable['birthDate'];
    });
  }

}
