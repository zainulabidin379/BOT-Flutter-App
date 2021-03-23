import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });
  Map data;

  // collection reference
  final CollectionReference botCollection = FirebaseFirestore.instance.collection('users_collection');

  Future<void> addUserData(String name, String email,String phone, String dpUrl, String location, String birthDate) async {
    return await botCollection.doc(uid).set({
      'name': name,
      'email': email,
      'phone': phone,
      'dpUrl': dpUrl,
      'location': location,
      'birthDate': birthDate,
    });
  }

  Future<void> updateUserData(String name, String email,String phone, String dpUrl, String location, String birthDate) async {
    return await botCollection.doc(uid).update({
      'name': name,
      'email': email,
      'phone': phone,
      'dpUrl': dpUrl,
      'location': location,
      'birthDate': birthDate,
    });
  }


}