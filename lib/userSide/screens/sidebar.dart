import 'dart:async';
import '../models/account-detail.dart';
import '../screens/navigation-bloc.dart';
import '../screens/wrapper.dart';
import '../services/auth.dart';
import '../shared/pallete.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens.dart';
import '../shared/menu-item.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class Sidebar extends StatefulWidget with NavigationStates {
  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar>
    with SingleTickerProviderStateMixin<Sidebar> {
  AnimationController _animationController;
  StreamController<bool> isSidebarOpenedStreamController;
  Stream<bool> issidebarOpenedStream;
  StreamSink<bool> isSidebarOpenedSink;
  final _animationDuration = const Duration(milliseconds: 400);
  final AuthService _auth = AuthService();

  String name;
  String email;
  String dpUrl;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    issidebarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamController.sink;
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSidebarOpenedSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isSidebarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      isSidebarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return StreamBuilder(
      initialData: false,
      stream: issidebarOpenedStream,
      builder: (context, isSidebarOpenedAsync) {
        return AnimatedPositioned(
          duration: Duration(milliseconds: 300),
          top: 0,
          bottom: 0,
          left: isSidebarOpenedAsync.data ? 0 : 0 - screenWidth,
          right: isSidebarOpenedAsync.data ? 0 : screenWidth - 35,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  color: kBlack,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 70,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            CircleAvatar(
                              radius: 45,
                              backgroundColor: kRed,
                              child: CircleAvatar(
                                radius: 42,
                                backgroundImage:
                                    AssetImage('assets/icons/avatar.png'),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FutureBuilder(
                                    future: FetchData().name(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data,
                                          style: kBodyText.copyWith(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        );
                                      } else {
                                        return Text(
                                          'Name',
                                          style: kBodyText.copyWith(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        );
                                      }
                                    }),
                                FutureBuilder(
                                    future: FetchData().email(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data,
                                          style: TextStyle(
                                            color: Colors.grey[500],
                                            fontSize: 14,
                                          ),
                                          textAlign: TextAlign.left,
                                        );
                                      } else {
                                        return Text(
                                          'Your Email',
                                          style: TextStyle(
                                            color: Colors.grey[500],
                                            fontSize: 14,
                                          ),
                                          textAlign: TextAlign.left,
                                        );
                                      }
                                    }),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              Divider(
                                height: 64,
                                thickness: 0.5,
                                color: kWhite.withOpacity(0.3),
                                indent: 42,
                                endIndent: 42,
                              ),
                              MenuItem(
                                icon: Icons.home_outlined,
                                title: 'Home',
                                onTap: () {
                                  onIconPressed();
                                  BlocProvider.of<NavigationBloc>(context).add(
                                      NavigationEvents.HomePageClickedEvent);
                                },
                              ),
                              MenuItem(
                                icon: Icons.perm_identity,
                                title: 'My Profile',
                                onTap: () {
                                  onIconPressed();
                                  BlocProvider.of<NavigationBloc>(context).add(
                                      NavigationEvents.MyProfileClickedEvent);
                                },
                              ),
                              MenuItem(
                                icon: Icons.local_offer_outlined,
                                title: 'Offers',
                                onTap: () {
                                  onIconPressed();
                                  BlocProvider.of<NavigationBloc>(context)
                                      .add(NavigationEvents.OffersClickedEvent);
                                },
                              ),
                              MenuItem(
                                icon: Icons.info_outline,
                                title: 'About BOT',
                                onTap: () {
                                  onIconPressed();
                                  BlocProvider.of<NavigationBloc>(context)
                                      .add(NavigationEvents.AboutClickedEvent);
                                },
                              ),
                              MenuItem(
                                icon: Icons.supervised_user_circle_outlined,
                                title: 'Our team',
                                onTap: () {
                                  onIconPressed();
                                  BlocProvider.of<NavigationBloc>(context).add(
                                      NavigationEvents.OurTeamClickedEvent);
                                },
                              ),
                              MenuItem(
                                icon: Icons.support_agent_outlined,
                                title: 'Support',
                                onTap: () {
                                  onIconPressed();
                                  BlocProvider.of<NavigationBloc>(context).add(
                                      NavigationEvents.SupportClickedEvent);
                                },
                              ),
                              Divider(
                                height: 64,
                                thickness: 0.5,
                                color: kWhite.withOpacity(0.3),
                                indent: 42,
                                endIndent: 42,
                              ),
                              MenuItem(
                                icon: Icons.settings,
                                title: 'Settings',
                                onTap: () {
                                  onIconPressed();
                                  BlocProvider.of<NavigationBloc>(context).add(
                                      NavigationEvents.SettingsClickedEvent);
                                },
                              ),
                              MenuItem(
                                icon: Icons.exit_to_app,
                                title: 'Logout',
                                onTap: () async {
                                  await _auth.signOut();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Wrapper()),
                                  );
                                  Get.snackbar(
                                    'Message',
                                    'Logged Out Successfully',
                                    duration: Duration(seconds: 3),
                                    backgroundColor: kRed,
                                    colorText: kWhite,
                                    snackPosition: SnackPosition.BOTTOM,
                                    borderRadius: 0,
                                    margin: EdgeInsets.all(0),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, -0.93),
                child: GestureDetector(
                  onTap: () {
                    onIconPressed();
                    FocusScope.of(context).unfocus();
                  },
                  child: ClipPath(
                    clipper: CustomMenuClipper(),
                    child: Container(
                      width: 35,
                      height: 110,
                      color: kBlack,
                      alignment: Alignment.centerLeft,
                      child: AnimatedIcon(
                        progress: _animationController.view,
                        icon: AnimatedIcons.menu_close,
                        color: kWhite,
                        size: 27,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
