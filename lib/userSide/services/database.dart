import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  Map data;

  // collection reference
  final CollectionReference botCollection =
      FirebaseFirestore.instance.collection('users_collection');

  Future<void> addUserData(String name, String email, String phone,
      String dpUrl, String location, String birthDate) async {
    return await botCollection.doc(uid).set({
      'name': name,
      'email': email,
      'phone': phone,
      'dpUrl': dpUrl,
      'location': location,
      'birthDate': birthDate,
      'botPoints': 500,
    });
  }

  Future<void> updateUserData(String name, String email, String phone,
      String dpUrl, String location, String birthDate) async {
    return await botCollection.doc(uid).update({
      'name': name,
      'email': email,
      'phone': phone,
      'dpUrl': dpUrl,
      'location': location,
      'birthDate': birthDate,
    });
  }

  Future<void> addUserTripData(
      String created_at,
      String starting_latitude,
      String starting_longitude,
      String ending_latitude,
      String ending_longitude,
      String total_time,
      String ride_type) async {
    return await FirebaseFirestore.instance
        .collection('users_ride_data')
        .doc(uid)
        .set({
      'created_at': created_at,
      'starting_latitude': starting_latitude,
      'starting_longitude': starting_longitude,
      'ending_latitude': ending_latitude,
      'ending_longitude': ending_longitude,
      'total_time': total_time,
      'ride_type': ride_type,
    });
  }

  Future<void> deleteUserTripData() async {
    return await FirebaseFirestore.instance
        .collection('users_ride_data')
        .doc(uid)
        .delete();
  }

  Future<void> addUserFeedbackData(
      String feedback) async {
    return await FirebaseFirestore.instance
        .collection('users_feedback_data')
        .doc(uid)
        .set({
      'feedback': feedback,
    });
  }
}
