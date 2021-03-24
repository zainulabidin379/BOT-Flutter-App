import 'package:bot_app/dataHandler/appData.dart';
import 'package:bot_app/models/address.dart';
import 'package:bot_app/models/mapConfig.dart';
import 'package:bot_app/models/place.dart';
import 'package:bot_app/shared/pallete.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class SearchDestination extends StatefulWidget {
  @override
  _SearchDestinationState createState() => _SearchDestinationState();
}

class _SearchDestinationState extends State<SearchDestination> {
  TextEditingController startingPointController = TextEditingController();
  TextEditingController destinationController = TextEditingController();

  var uuid = new Uuid();
  String _sessionToken;
  bool loading = false;

  List<Place> _placesList = [];

  @override
  void initState() {
    super.initState();
    startingPointController.text = 'Current Location';
  }

  @override
  void dispose() {
    destinationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: kBlack,
          ),
        ),
        title: Text(
          "Choose Destination",
          style: TextStyle(
            fontSize: size.width * 0.06,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 160,
            decoration: BoxDecoration(
              color: kWhite,
              boxShadow: [
                BoxShadow(
                  color: kBlack.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Column(
                children: [
                  TextField(
                    enabled: false,
                    controller: startingPointController,
                    cursorColor: kBlack,
                    decoration: InputDecoration(
                      hintText: 'Starting Point',
                      hintStyle: TextStyle(
                        fontSize: 20,
                        color: kBlack,
                        fontWeight: FontWeight.normal,
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
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(26.0),
                        borderSide: BorderSide(
                          color: kBlack,
                          width: 1.5,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 24.0, left: 8.0),
                        child: Icon(
                          Icons.my_location,
                          color: kBlack,
                          size: 32,
                        ),
                      ),
                    ),
                    style: kBodyText.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    onChanged: (val) {
                      if (_sessionToken == null) {
                        setState(() {
                          _sessionToken = uuid.v4();
                        });
                      }
                      findPlace(val);
                    },
                    controller: destinationController,
                    cursorColor: kBlack,
                    decoration: InputDecoration(
                      hintText: 'Choose Destination',
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
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 20.0, left: 8.0),
                        child: Icon(
                          Icons.place,
                          color: kBlack,
                          size: 32,
                        ),
                      ),
                    ),
                    style: kBodyText.copyWith(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: _placesList.length,
              itemBuilder: (BuildContext context, int index) =>
                  buildPlaceCard(context, index),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPlaceCard(BuildContext context, int index) {
    return Hero(
      tag: "SelectedTrip-${_placesList[index].placeID}",
      transitionOnUserGestures: true,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
                side: BorderSide(color: kBlack, width: 1)),
            elevation: 2,
            child: InkWell(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Flexible(
                                child: AutoSizeText(
                                  _placesList[index].mainText,
                                    maxLines: 3,
                                    style: TextStyle(fontSize: 18.0)),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Flexible(
                                child: AutoSizeText(                                                                               
                                    _placesList[index].secondaryText,
                                    maxLines: 3,
                                    style: TextStyle(
                                        fontSize: 15.0, color: Colors.grey)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.add_location_alt_sharp,
                          size: 32,
                        )
                      ],
                    ),
                  )
                ],
              ),
              onTap: () {
                setState(() {
                  loading = true;
                });
                getPlaceAddressDetails(_placesList[index].placeID, context);
              },
            ),
          ),
        ),
      ),
    );
  }

  void findPlace(String placeName) async {
    if (placeName.length > 1) {
      String baseURL =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json';

      String request =
          '$baseURL?input=$placeName&location=40.7128,74.1059&radius=10000000&key=$mapKey&components=country:pk';
      Response response = await Dio().get(request);

      final predictions = response.data['predictions'];

      List<Place> _displayResults = [];

      for (var i = 0; i < predictions.length; i++) {
        String mainText = predictions[i]['structured_formatting']['main_text'];
        String secondaryText =
            predictions[i]['structured_formatting']['secondary_text'];
        String placeID = predictions[i]['place_id'];
        _displayResults.add(Place(mainText, secondaryText, placeID));
      }
      setState(() {
        _placesList = _displayResults;
      });
    }
  }

  void getPlaceAddressDetails(String placeId, context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => SpinKitRotatingCircle(
        color: kBlack,
        size: 50.0,
      ),
    );

    String baseURL = 'https://maps.googleapis.com/maps/api/place/details/json';
    String request = "$baseURL?place_id=$placeId&key=$mapKey";

    Response response = await Dio().get(request);

    Navigator.pop(context);

    final result = response.data;

    if(result['status'] == 'OK'){
      Address address = Address();
      address.placeName = result['result']['name'];
      address.placeId = placeId;
      address.latitude = result['result']['geometry']['location']['lat'];
      address.longitude = result['result']['geometry']['location']['lng'];

      Provider.of<AppData>(context, listen: false).updateEndPoint(address);
      Navigator.pop(context, 'obtainDirection');
    }
  }
}
