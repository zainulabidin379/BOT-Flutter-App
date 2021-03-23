import 'package:bot_app/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FetchData {
  final AuthService _auth = AuthService();

  dpUrl() async{
    var currentUser = _auth.getCurrentUser();
    DocumentSnapshot variable = await FirebaseFirestore.instance.collection('users_collection').doc(currentUser).get();
    return variable['dpUrl'];
  }

  name() async{
    var currentUser = _auth.getCurrentUser();
    DocumentSnapshot variable = await FirebaseFirestore.instance.collection('users_collection').doc(currentUser).get();
    return variable['name'];
  }

  email() async{
    var currentUser = _auth.getCurrentUser();
    DocumentSnapshot variable = await FirebaseFirestore.instance.collection('users_collection').doc(currentUser).get();
    return variable['email'];
  }

}
