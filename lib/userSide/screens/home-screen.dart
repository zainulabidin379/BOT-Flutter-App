import 'dart:async';
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import '../dataHandler/appData.dart';
import '../models/assistantMethods.dart';
import '../models/directDetails.dart';
import '../screens/navigation-bloc.dart';
import '../screens/screens.dart';
import '../services/auth.dart';
import '../services/database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget with NavigationStates {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final AuthService _auth = AuthService();

  GoogleMapController _mapController;
  double bottomPaddingOfMap = 0;

  bool bike = false;
  bool car = false;
  bool timer = false;
  int totalTime = 0;

  DirectionDetails tripDirectionDetails;

  List<LatLng> pLineCoordinates = [];
  Set<Polyline> polylineSet = {};

  Set<Marker> markerSet = {};
  Set<Circle> circleSet = {};

  Position currentPosition;
  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latLonPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition =
        new CameraPosition(target: latLonPosition, zoom: 16);
    _mapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    await AssistantMethods.searchCoordinateAddress(
        position, _scaffoldKey.currentContext);
  }

  double searchContainerHeight = 0;
  double detailsContainerHeight = 0;
  double rideDetailsContainerHeight = 0;
  double timerContainerHeight = 0;

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit App'),
            actions: <Widget>[
              new TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No', style: TextStyle(color: kRed)),
              ),
              new TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes', style: TextStyle(color: kBlack)),
              ),
            ],
          ),
        )) ??
        false;
  }

  //TIMER FUNCTION

  final _isHours = true;

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countDown,);

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Stack(
            children: [
              GoogleMap(
                padding: EdgeInsets.only(bottom: bottomPaddingOfMap, top: 40),
                mapType: MapType.terrain,
                onMapCreated: (GoogleMapController controller) {
                  setState(() {
                    bottomPaddingOfMap = size.height * 0.2;
                    searchContainerHeight = size.height * 0.2;
                    rideDetailsContainerHeight = 0;
                    timerContainerHeight = 0;
                  });

                  showDialog(
                    context: context,
                    builder: (BuildContext context) => SpinKitFadingCircle(
                      color: kRed,
                      size: 50.0,
                    ),
                  );

                  _mapController = controller;
                  locatePosition();

                  Navigator.pop(context);
                },
                initialCameraPosition: CameraPosition(
                  target: LatLng(33.684422, 73.047882),
                  zoom: 12,
                ),
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                zoomGesturesEnabled: true,
                zoomControlsEnabled: false,
                polylines: polylineSet,
                markers: markerSet,
                circles: circleSet,
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: AnimatedSize(
                  vsync: this,
                  curve: Curves.bounceIn,
                  duration: Duration(milliseconds: 200),
                  child: Container(
                    height: searchContainerHeight,
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: kBlack.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Text(
                          'Choose Your Destination',
                          style: kBodyText.copyWith(
                              fontSize: size.width * 0.06,
                              color: kBlack,
                              fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () async {
                            var res = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchDestination()),
                            );

                            if (res == 'obtainDirection') {
                              await getPlaceDirection();

                              setState(() {
                                searchContainerHeight = 0;
                                rideDetailsContainerHeight = size.height * 0.3;
                                detailsContainerHeight = 0;
                                bottomPaddingOfMap = size.height * 0.3;
                                timerContainerHeight = 0;
                              });
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 35,
                              right: 35,
                              top: size.height * 0.02,
                            ),
                            child: TextField(
                              enabled: false,
                              cursorColor: kBlack,
                              decoration: InputDecoration(
                                hintText: 'Search Destination',
                                hintStyle: TextStyle(
                                  fontSize: 20,
                                  color: kBlack,
                                ),
                                border: OutlineInputBorder(
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
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 24),
                                suffixIcon: Padding(
                                  padding:
                                      EdgeInsets.only(right: 24.0, left: 8.0),
                                  child: Icon(
                                    Icons.search,
                                    color: kBlack,
                                    size: 26,
                                  ),
                                ),
                              ),
                              style: kBodyText.copyWith(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: AnimatedSize(
                  vsync: this,
                  curve: Curves.bounceIn,
                  duration: Duration(milliseconds: 200),
                  child: Container(
                    height: rideDetailsContainerHeight,
                    decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50)),
                        boxShadow: [
                          BoxShadow(
                            color: kBlack.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Column(children: [
                        Text('Choose Your Ride',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 30.0,
                                color: kBlack,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 25.0, right: 5.0, top: 10.0),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    car = true;
                                    searchContainerHeight = 0;
                                    rideDetailsContainerHeight = 0;
                                    detailsContainerHeight = size.height * 0.25;
                                    bottomPaddingOfMap = size.height * 0.25;
                                    timerContainerHeight = 0;
                                  });
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                        color: kRed,
                                        borderRadius:
                                            BorderRadius.circular(26.0)),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.car,
                                          color: kWhite,
                                          size: 22,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          'Car',
                                          style: kBodyText.copyWith(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )),
                              ),
                            )),
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 5.0, right: 25.0, top: 10.0),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    bike = true;
                                    searchContainerHeight = 0;
                                    rideDetailsContainerHeight = 0;
                                    detailsContainerHeight = size.height * 0.25;
                                    bottomPaddingOfMap = size.height * 0.25;
                                    timerContainerHeight = 0;
                                  });
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                        color: kRed,
                                        borderRadius:
                                            BorderRadius.circular(26.0)),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.motorcycle,
                                          color: kWhite,
                                          size: 22,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          "Bike",
                                          style: kBodyText.copyWith(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )),
                              ),
                            ))
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 10.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                car = false;
                                bike = false;
                                searchContainerHeight = size.height * 0.2;
                                rideDetailsContainerHeight = 0;
                                detailsContainerHeight = 0;
                                bottomPaddingOfMap = size.height * 0.2;
                                timerContainerHeight = 0;

                                polylineSet.clear();
                                markerSet.clear();
                                circleSet.clear();
                                pLineCoordinates.clear();
                              });
                              locatePosition();
                            },
                            child: Container(
                                alignment: Alignment.center,
                                height: 50.0,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(26.0)),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Cancel',
                                      style: kBodyText.copyWith(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: AnimatedSize(
                  vsync: this,
                  curve: Curves.bounceIn,
                  duration: Duration(milliseconds: 200),
                  child: Container(
                    height: detailsContainerHeight,
                    decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50)),
                        boxShadow: [
                          BoxShadow(
                            color: kBlack.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 20),
                      child: Column(children: [
                        Flexible(
                          child: AutoSizeText(
                              'You have to reach at your destination in ',
                              maxLines: 3,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 22.0,
                                  color: kBlack,
                                  fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Text(
                            (tripDirectionDetails != null
                                    ? '${AssistantMethods.calculateTotalTime(tripDirectionDetails, car, bike)}'
                                    : '') +
                                ' minutes',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 30.0,
                                color: kRed,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, right: 5.0),
                              child: InkWell(
                                onTap: () async {
                                  setState(() {
                                    searchContainerHeight = 0;
                                    rideDetailsContainerHeight =
                                        size.height * 0.3;
                                    detailsContainerHeight = 0;
                                    timerContainerHeight = 0;
                                    bottomPaddingOfMap = size.height * 0.2;
                                    bike = false;
                                    car = false;
                                  });
                                  await DatabaseService(
                                          uid: _auth.getCurrentUser())
                                      .deleteUserTripData();
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    height: 50.0,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius:
                                            BorderRadius.circular(26.0)),
                                    child: Text(
                                      'Back',
                                      style: kBodyText.copyWith(
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                            ),
                            Expanded(
                                child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 5.0, right: 10.0),
                              child: InkWell(
                                onTap: () async {
                                  _stopWatchTimer.onExecute.add(StopWatchExecute.reset);

                                  setState(() {
                                    timerContainerHeight = size.height * 0.3;
                                    searchContainerHeight = 0;
                                    rideDetailsContainerHeight = 0;
                                    detailsContainerHeight = 0;
                                    bottomPaddingOfMap = size.height * 0.3;
                                    timer = true;
                                    totalTime =
                                        AssistantMethods.calculateTotalTime(
                                            tripDirectionDetails, car, bike);
                                  });
                                  _stopWatchTimer.setPresetMinuteTime(totalTime);
                                  Get.snackbar(
                                    'Message',
                                    'Your Ride is Started, Please Drive Safely!',
                                    duration: Duration(seconds: 5),
                                    backgroundColor: kBlack,
                                    colorText: kWhite,
                                    snackPosition: SnackPosition.TOP,
                                    borderRadius: 0,
                                    margin: EdgeInsets.all(0),
                                  );

                                  var startingPoint = Provider.of<AppData>(
                                          context,
                                          listen: false)
                                      .startingPoint;
                                  var endingPoint = Provider.of<AppData>(
                                          context,
                                          listen: false)
                                      .endingPoint;
                                  await DatabaseService(
                                          uid: _auth.getCurrentUser())
                                      .addUserTripData(
                                    DateTime.now().toString(),
                                    startingPoint.latitude.toString(),
                                    startingPoint.longitude.toString(),
                                    endingPoint.latitude.toString(),
                                    endingPoint.longitude.toString(),
                                    AssistantMethods.calculateTotalTime(
                                            tripDirectionDetails, car, bike)
                                        .toString(),
                                    (car == true) ? "Car" : "Bike",
                                  );
                                  _stopWatchTimer.onExecute.add(StopWatchExecute.start);
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                        color: kRed,
                                        borderRadius:
                                            BorderRadius.circular(26.0)),
                                    child: Text(
                                      "Start Journey",
                                      style: kBodyText.copyWith(
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                            ))
                          ],
                        ),
                      ]),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: AnimatedSize(
                  vsync: this,
                  curve: Curves.bounceIn,
                  duration: Duration(milliseconds: 200),
                  child: Container(
                    height: timerContainerHeight,
                    decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50)),
                        boxShadow: [
                          BoxShadow(
                            color: kBlack.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(children: [
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Text('Your Remaining Time',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: size.width * 0.08,
                                color: kBlack,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 0),
                          child: StreamBuilder<int>(
                            stream: _stopWatchTimer.rawTime,
                            initialData:
                                _stopWatchTimer.rawTime.valueWrapper?.value,
                            builder: (context, snap) {
                              final value = snap.data;
                              final displayTime = StopWatchTimer.getDisplayTime(
                                  value,
                                  hours: _isHours);
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 15),
                                child: Text(
                                  displayTime,
                                  style: GoogleFonts.oldStandardTt(color: kRed, fontSize: 40, fontWeight: FontWeight.bold),
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 10),
                          child: InkWell(
                            onTap: () async {
                              _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
                              setState(() {
                                car = false;
                                bike = false;
                                searchContainerHeight = size.height * 0.2;
                                rideDetailsContainerHeight = 0;
                                detailsContainerHeight = 0;
                                bottomPaddingOfMap = size.height * 0.2;
                                timerContainerHeight = 0;

                                polylineSet.clear();
                                markerSet.clear();
                                circleSet.clear();
                                pLineCoordinates.clear();
                              });
                              locatePosition();
                            },
                            child: Container(
                                alignment: Alignment.center,
                                height: 50.0,
                                decoration: BoxDecoration(
                                    color: kBlack,
                                    borderRadius: BorderRadius.circular(26.0)),
                                child: Text(
                                  "Cancel Trip",
                                  style: kBodyText.copyWith(
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getPlaceDirection() async {
    var initialPos = Provider.of<AppData>(context, listen: false).startingPoint;
    var finalPos = Provider.of<AppData>(context, listen: false).endingPoint;

    var startingLatLng = LatLng(initialPos.latitude, initialPos.longitude);
    var endingLatLng = LatLng(finalPos.latitude, finalPos.longitude);

    showDialog(
      context: context,
      builder: (BuildContext context) => SpinKitFadingCircle(
        color: kRed,
        size: 50.0,
      ),
    );

    var details = await AssistantMethods.obtainPlaceDirectionDetails(
        startingLatLng, endingLatLng);

    setState(() {
      tripDirectionDetails = details;
    });

    Navigator.pop(context);

    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodePolylinePointsResult =
        polylinePoints.decodePolyline(details.encodedPoints);

    pLineCoordinates.clear();

    if (decodePolylinePointsResult.isNotEmpty) {
      decodePolylinePointsResult.forEach((PointLatLng pointLatLng) {
        pLineCoordinates
            .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      });
    }

    polylineSet.clear();

    setState(() {
      Polyline polyline = Polyline(
        color: kRed,
        polylineId: PolylineId('PolylineID'),
        jointType: JointType.round,
        points: pLineCoordinates,
        width: 5,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        geodesic: true,
      );

      polylineSet.add(polyline);
    });

    LatLngBounds latLngBounds;
    if (startingLatLng.latitude > endingLatLng.latitude &&
        startingLatLng.longitude > endingLatLng.longitude) {
      latLngBounds =
          LatLngBounds(southwest: endingLatLng, northeast: startingLatLng);
    } else if (startingLatLng.longitude > endingLatLng.longitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(startingLatLng.latitude, endingLatLng.longitude),
          northeast: LatLng(endingLatLng.latitude, startingLatLng.longitude));
    } else if (startingLatLng.latitude > endingLatLng.latitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(endingLatLng.latitude, startingLatLng.longitude),
          northeast: LatLng(startingLatLng.latitude, endingLatLng.longitude));
    } else {
      latLngBounds =
          LatLngBounds(southwest: startingLatLng, northeast: endingLatLng);
    }

    _mapController
        .animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));

    Marker startingLocMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      infoWindow: InfoWindow(
          title: initialPos.placeName, snippet: "My Current Location"),
      position: startingLatLng,
      markerId: MarkerId("startingID"),
    );

    Marker endingLocMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow:
          InfoWindow(title: finalPos.placeName, snippet: "My Destination"),
      position: endingLatLng,
      markerId: MarkerId("endingID"),
    );

    setState(() {
      markerSet.add(startingLocMarker);
      markerSet.add(endingLocMarker);
    });

    Circle startingLocCircle = Circle(
        fillColor: kBlack,
        center: startingLatLng,
        radius: 15,
        strokeWidth: 4,
        strokeColor: kWhite,
        circleId: CircleId("startingId"));

    Circle endingLocCircle = Circle(
        fillColor: Colors.red,
        center: endingLatLng,
        radius: 15,
        strokeWidth: 4,
        strokeColor: Colors.redAccent,
        circleId: CircleId("endingId"));

    setState(() {
      circleSet.add(startingLocCircle);
      circleSet.add(endingLocCircle);
    });
  }
}
