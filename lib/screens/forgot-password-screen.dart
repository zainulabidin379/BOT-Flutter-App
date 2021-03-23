import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bot_app/screens/screens.dart';

class ForgotPassword extends StatelessWidget {
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
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 45),
              child: TextField(
                //controller: emailController,
                style: kBodyText.copyWith(color: kBlack),
                cursorColor: kBlack,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    fillColor: kWhite,
                    filled: true,
                    contentPadding: EdgeInsets.zero,
                    hintText: 'Email',
                    hintStyle: kBodyText.copyWith(fontSize: 20, color: kBlack),
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
                //validator: FieldValidator.email(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 45),
              child: InkWell(
                onTap: () async {
                  // if(_formKey.currentState.validate()){
                  // setState(() {
                  // loading = true;
                  // });
                  // dynamic result = await _auth.signInWithEmailAndPassword(emailController.text, passwordController.text);
                  // if(result != null) {
                  // Navigator.push(
                  // context,
                  // MaterialPageRoute(
                  // builder: (context) => Home()),
                  // );
                  // }else{
                  // setState(() {
                  // loading = false;
                  // });
                  // }
                  // }
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
