import '../shared/pallete.dart';
import '../widgets/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:the_validator/the_validator.dart';
import 'screens.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: kBlack),
        ),
        centerTitle: true,
      ),
      backgroundColor: kWhite,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: FadeAnimation(
              0.8,
              Column(
                children: [
                  Center(
                    child: Text(
                      'Contact Us',
                      style: kBodyText.copyWith(
                          color: kBlack,
                          fontSize: 35,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Text(
                      'For all enquiries, please contact us using the form below. We will get back to you as soon as possible.',
                      style: kBodyText.copyWith(color: kBlack),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  FadeAnimation(
                    1.3,
                    Form(
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
                                      color: kBlack,
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
                                      color: kBlack,
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
                              controller: messageController,
                              style: kBodyText.copyWith(color: kBlack),
                              cursorColor: kBlack,
                              keyboardType: TextInputType.multiline,
                              minLines: 4,
                              maxLines: 6,
                              decoration: InputDecoration(
                                  fillColor: kWhite,
                                  filled: true,
                                  contentPadding: EdgeInsets.zero,
                                  hintText: 'Your Message',
                                  hintStyle: kBodyText.copyWith(
                                      fontSize: 20, color: kBlack),
                                  prefixIcon: Icon(
                                    FontAwesomeIcons.solidComments,
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
                                      color: kBlack,
                                    ),
                                  )),
                              validator: FieldValidator.minLength(1,
                                  message: 'Please enter your message'),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: InkWell(
                              onTap: () async {
                                if (_formKey.currentState.validate()) {
                                  sendMail(context);
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
                                    'Send',
                                    style: kBodyText.copyWith(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  sendMail(context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => SpinKitFadingCircle(
        color: kRed,
        size: 50.0,
      ),
    );

    String username = 'lyricshunt47@gmail.com';
    String password = 'zaini123';

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'Be On Time')
      ..recipients.add(emailController.text)
      //..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
      //..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = 'Mail From BOT Team'
      //..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html =
          "<h3>Thank You ${nameController.text} for contacting BOT Team</h3>\n<p>We recieved your message and will respond to your query as soon as possible.</p>\n\n<p>-BOT Team</p>";

    // final message = Message()
    //   ..from = Address(username, 'Be On Time')
    //   ..recipients.add(emailController.text)
    //   //..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
    //   //..bccRecipients.add(Address('bccAddress@example.com'))
    //   ..subject = 'Mail From BOT app user ${nameController.text}'
    //   //..text = 'This is the plain text.\nThis is line 2 of the text part.'
    //   ..html =
    //       "<h1>Mail Contents</h1>\n<p>Name: ${nameController.text}</p>\n<p>Email: ${emailController.text}</p>\n<p>Message: ${messageController.text}</p>";

    try {
      final sendReport = await send(message, smtpServer);
      Navigator.pop(context);
      print('Message sent: ' + sendReport.toString());
      Navigator.pop(context);
      Get.snackbar(
        'Thank You ${nameController.text} for contacting us',
        'We will respond to your message ASAP',
        duration: Duration(seconds: 5),
        backgroundColor: kBlack,
        colorText: kWhite,
        snackPosition: SnackPosition.TOP,
        borderRadius: 0,
        margin: EdgeInsets.all(0),
      );
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
}
