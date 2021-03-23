import 'package:bot_app/dataHandler/appData.dart';
import 'package:bot_app/models/address.dart';
import 'package:bot_app/models/directDetails.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'mapConfig.dart';

class CoordinateSearch{
  static Future<String> searchCoordinateAddress(Position position, context) async{
    
    String placeAddress = "";

    String baseUrl = 'https://maps.googleapis.com/maps/api/geocode/json';
    String request = "$baseUrl?latlng=${position.latitude},${position.longitude}&key=$mapKey";

    Response response = await Dio().get(request);
    final res = response.data;

    placeAddress = res['results'][0]['formatted_address'];

    Address userStartingPoint = Address();
    userStartingPoint.latitude = position.latitude;
    userStartingPoint.longitude = position.longitude;
    userStartingPoint.placeName = placeAddress;

    Provider.of<AppData>(context, listen: false).updateStartingPoint(userStartingPoint);

    return placeAddress;
  }

  static Future<DirectionDetails>  obtainPlaceDirectionDetails(LatLng initialPosition, LatLng finalPosition) async{
    String baseUrl = 'https://maps.googleapis.com/maps/api/directions/json';
    String request = "$baseUrl?origin=${initialPosition.latitude},${initialPosition.longitude}&destination=${finalPosition.latitude},${finalPosition.longitude}&key=$mapKey";

    Response response = await Dio().get(request);
    final result = response.data;

    DirectionDetails directionDetails = DirectionDetails();

    directionDetails.encodedPoints = result["routes"][0]["overview_polyline"]["points"];

    directionDetails.distanceText = result["routes"][0]["legs"][0]["distance"]["text"];
    directionDetails.distanceValue = result["routes"][0]["legs"][0]["distance"]["value"];

    directionDetails.durationValue = result["routes"][0]["legs"][0]["duration"]["value"];
    directionDetails.durationText = result["routes"][0]["legs"][0]["duration"]["text"];

    print('The encoded points are given Below     ::::  ');
    print(directionDetails.encodedPoints);

    return directionDetails;
  }
}