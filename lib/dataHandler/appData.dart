import 'package:bot_app/models/address.dart';
import 'package:flutter/cupertino.dart';

class AppData extends ChangeNotifier{
  Address startingPoint, endingPoint;

  void updateStartingPoint(Address startingAddress){
    startingPoint = startingAddress;
    notifyListeners();
  }

  void updateEndPoint(Address endAddress){
    endingPoint = endAddress;
    notifyListeners();
  }
}