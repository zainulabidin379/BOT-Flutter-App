import 'package:bot_app/userSide/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:the_validator/the_validator.dart';
import '../screens/screens.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final AuthService _auth = AuthService();

  final emailController = TextEditingController();

  String errorMessage;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Forgot Password',
          style: kBodyText,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.15,
            ),
            Container(
              width: size.width * 0.9,
              child: Text(
                'Enter your registered Email',
                style: kBodyText,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 45),
                child: TextFormField(
                  controller: emailController,
                  style: kBodyText.copyWith(color: kBlack),
                  cursorColor: kBlack,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      fillColor: kWhite,
                      filled: true,
                      contentPadding: EdgeInsets.zero,
                      hintText: 'Email',
                      hintStyle:
                          kBodyText.copyWith(fontSize: 20, color: kBlack),
                      prefixIcon: Icon(
                        FontAwesomeIcons.solidEnvelope,
                        color: kBlack,
                        size: 20,
                      ),
                      errorStyle: TextStyle(
                        fontSize: 16.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(26.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(26.0),
                        borderSide: BorderSide(
                          color: kWhite,
                        ),
                      )),
                  validator: FieldValidator.email(),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 45),
              child: InkWell(
                onTap: () async {
                  if (_formKey.currentState.validate()) {
                    try {
                      await _auth.sendPasswordResetEmail(emailController.text);
                      Navigator.pop(context);
                      Get.snackbar(
                        'Email Sent',
                        'Email with password reset instructions is sent',
                        duration: Duration(seconds: 3),
                        backgroundColor: kWhite,
                        colorText: kBlack,
                        borderRadius: 10,
                      );
                    } on FirebaseAuthException catch (error) {
                      switch (error.code) {
                        case "ERROR_EMAIL_ALREADY_IN_USE":
                        case "account-exists-with-different-credential":
                        case "email-already-in-use":
                          setState(() {
                            errorMessage =
                                "Email already used. Go to login page.";
                          });
                          break;
                        case "ERROR_WRONG_PASSWORD":
                        case "wrong-password":
                          setState(() {
                            errorMessage = "Wrong email/password combination.";
                          });
                          break;
                        case "ERROR_USER_NOT_FOUND":
                        case "user-not-found":
                          setState(() {
                            errorMessage = "No user found with this email.";
                          });
                          break;
                        case "ERROR_USER_DISABLED":
                        case "user-disabled":
                          setState(() {
                            errorMessage = "User disabled.";
                          });

                          break;

                        case "ERROR_OPERATION_NOT_ALLOWED":
                        case "operation-not-allowed":
                          setState(() {
                            errorMessage =
                                "Server error, please try again later.";
                          });
                          break;
                        case "ERROR_INVALID_EMAIL":
                        case "invalid-email":
                          setState(() {
                            errorMessage = "Email address is invalid.";
                          });
                          break;
                        default:
                          setState(() {
                            errorMessage = "Login failed. Please try again.";
                          });
                          break;
                      }
                      Get.snackbar(
                        'Error',
                        errorMessage,
                        duration: Duration(seconds: 3),
                        backgroundColor: Colors.red,
                        colorText: kWhite,
                        borderRadius: 10,
                      );
                    }
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                  height: 50,
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                    color: kRed,
                  ),
                  child: Center(
                    child: Text(
                      'Send',
                      style: kBodyText.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
