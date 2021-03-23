import 'package:bot_app/models/directDetails.dart';
import 'package:bot_app/models/mapConfig.dart';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<DirectionDetails> obtainPlaceDirectionDetails(LatLng initialPosition, LatLng finalPosition) async{
  
  String baseURL = 'https://maps.googleapis.com/maps/api/directions/json';

      String request = '$baseURL?origin=${initialPosition.latitude},${initialPosition.longitude}&destination=${finalPosition.latitude},${finalPosition.longitude}&key=$mapKey';
      Response response = await Dio().get(request);

      final res = response.data['routes'];

      DirectionDetails directionDetails = DirectionDetails();

      directionDetails.encodedPoints = res[0]['overview_polyline'][0]['points'];
      directionDetails.distanceText = res[0]['legs'][0]['distance']['text'];
      directionDetails.distanceValue = res[0]['legs'][0]['distance']['value'];
      
      directionDetails.durationText = res[0]['legs'][0]['duration']['text'];
      directionDetails.durationValue = res[0]['legs'][0]['duration']['value'];
    
    return directionDetails;
}