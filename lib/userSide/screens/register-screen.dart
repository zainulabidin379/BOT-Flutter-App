import '../services/auth.dart';
import 'package:the_validator/the_validator.dart';
import 'screens.dart';
import '../shared/pallete.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CreateNewAccount extends StatefulWidget {
  @override
  _CreateNewAccountState createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends State<CreateNewAccount> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool _obscurePassword;
  bool _obscureConfirmPassword;

  bool loading = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _obscurePassword = true;
    _obscureConfirmPassword = true;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.width * 0.2,
              ),
              Center(
                child: CircleAvatar(
                  radius: size.width * 0.14,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/icons/avatar.png'),
                ),
              ),
              SizedBox(
                height: size.width * 0.1,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          //Name
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20),
                            child: TextFormField(
                              controller: nameController,
                              style: kBodyText.copyWith(color: kBlack),
                              cursorColor: kBlack,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  fillColor: kWhite,
                                  filled: true,
                                  contentPadding: EdgeInsets.zero,
                                  hintText: 'Name',
                                  hintStyle: kBodyText.copyWith(
                                      fontSize: 20, color: kBlack),
                                  prefixIcon: Icon(
                                    FontAwesomeIcons.userAlt,
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
                              validator: FieldValidator.minLength(3,
                                  message: 'Enter a valid name'),
                            ),
                          ),

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

                          //Phone
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20),
                            child: TextFormField(
                              controller: phoneController,
                              style: kBodyText.copyWith(color: kBlack),
                              cursorColor: kBlack,
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  fillColor: kWhite,
                                  filled: true,
                                  contentPadding: EdgeInsets.zero,
                                  hintText: 'Phone Number',
                                  hintStyle: kBodyText.copyWith(
                                      fontSize: 20, color: kBlack),
                                  prefixIcon: Icon(
                                    FontAwesomeIcons.phoneAlt,
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
                              validator: FieldValidator.multiple([
                                FieldValidator.number(
                                    message: 'Correct format 03001234567'),
                                FieldValidator.minLength(11,
                                    message: 'Correct format 03001234567'),
                                FieldValidator.maxLength(11,
                                    message: 'Correct format 03001234567'),
                              ]),
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
                              textInputAction: TextInputAction.next,
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
                                  errorMessage: 'Password is too short',
                                  minLength: 6),
                            ),
                          ),

                          //Confirm Password
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20),
                            child: TextFormField(
                                controller: confirmPasswordController,
                                style: kBodyText.copyWith(color: kBlack),
                                obscureText: _obscureConfirmPassword,
                                cursorColor: kBlack,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: kWhite,
                                  contentPadding: EdgeInsets.zero,
                                  hintText: 'Confirm Password',
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
                                      _obscureConfirmPassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: kBlack,
                                    ),
                                    onPressed: () {
                                      // Update the state i.e. toggle the state of passwordVisible variable
                                      setState(() {
                                        _obscureConfirmPassword =
                                            !_obscureConfirmPassword;
                                      });
                                    },
                                  ),
                                ),
                                validator: (val) {
                                  if (val.isEmpty)
                                    return 'Password must be same';
                                  if (val != passwordController.text)
                                    return 'Password must be same';
                                  return null;
                                }),
                          ),

                          SizedBox(
                            height: 25,
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: InkWell(
                              onTap: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  dynamic result =
                                      await _auth.registerWithEmailAndPassword(
                                          nameController.text,
                                          emailController.text,
                                          phoneController.text,
                                          passwordController.text);
                                  if (result != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SidebarLayout()),
                                    );
                                  } else {
                                    setState(() {
                                      loading = false;
                                    });
                                    Get.snackbar(
                                      'Error',
                                      'Something went wrong, please try again',
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
                                    'Register',
                                    style: kBodyText.copyWith(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(bottom: 20, top: 20),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Already have an account?",
                                    style: kBodyText,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "Login",
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
            ],
          ),
        ),
      ),
    );
  }
}
