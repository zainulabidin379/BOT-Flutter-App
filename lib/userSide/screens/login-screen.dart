import 'package:bot_app/adminSide/adminHomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../screens/screens.dart';
import 'package:the_validator/the_validator.dart';
import '../services/auth.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  bool _obscurePassword;

  bool loading = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void initState() {
    _obscurePassword = true;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.black,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: size.width * 0.25,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 70.0, right: 70.0, bottom: 70.0),
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        //Email
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20),
                          child: TextFormField(
                            controller: emailController,
                            style: kBodyText.copyWith(color: kBlack),
                            cursorColor: kBlack,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                fillColor: kWhite,
                                filled: true,
                                contentPadding: EdgeInsets.zero,
                                hintText: 'Email',
                                hintStyle: kBodyText.copyWith(
                                    fontSize: 20, color: kBlack),
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

                        //Password
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20),
                          child: TextFormField(
                            controller: passwordController,
                            style: kBodyText.copyWith(color: kBlack),
                            obscureText: _obscurePassword,
                            cursorColor: kBlack,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: kWhite,
                              contentPadding: EdgeInsets.zero,
                              hintText: 'Password',
                              hintStyle: kBodyText.copyWith(
                                  fontSize: 20, color: kBlack),
                              prefixIcon: Icon(
                                FontAwesomeIcons.lock,
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
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _obscurePassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: kBlack,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toggle the state of passwordVisible variable
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                            ),
                            validator: FieldValidator.password(
                                errorMessage:
                                    'Password must be 6 characters long',
                                minLength: 6),
                          ),
                        ),

                        //Button
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPassword()),
                              );
                            },
                            child: Text(
                              'Forgot Password?',
                              style: kBodyText,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                          child: InkWell(
                            onTap: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                dynamic result =
                                    await _auth.signInWithEmailAndPassword(
                                        emailController.text,
                                        passwordController.text);
                                if (result == null) {
                                  if (_auth.getCurrentUser() ==
                                      'QcIwlUYy7JZigOYecROLtsj33Dg1') {
                                    Get.offAll(() => AdminHomeScreen());
                                  } else {
                                    Get.offAll(() => SidebarLayout());
                                  }
                                } else {
                                  setState(() {
                                    loading = false;
                                  });
                                  Get.snackbar(
                                    'Error',
                                    'Something is not right. try again',
                                    duration: Duration(seconds: 3),
                                    backgroundColor: kRed,
                                    colorText: kWhite,
                                    snackPosition: SnackPosition.BOTTOM,
                                    borderRadius: 0,
                                    margin: EdgeInsets.all(0),
                                  );
                                }
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20),
                              height: 50,
                              width: size.width * 0.9,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(26),
                                color: kRed,
                              ),
                              child: Center(
                                child: Text(
                                  'Login',
                                  style: kBodyText.copyWith(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                          child: InkWell(
                        onTap: () async {
                          await _auth.signInWithGoogle();
                        },
                        child: Container(
                            alignment: Alignment.center,
                            height: 50.0,
                            width: size.width * 0.9,
                            decoration: BoxDecoration(
                                color: Color(0xFFDB4437),
                                borderRadius:
                                    BorderRadius.circular(26.0)),
                            child: Icon(
                              FontAwesomeIcons.google,
                              color: kWhite,
                              size: 28,
                            )),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20, top: 20),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateNewAccount()),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account?",
                                  style: kBodyText,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "Sign up",
                                  style: kBodyText.copyWith(color: kRed),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
