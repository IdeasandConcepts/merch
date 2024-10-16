// import 'dart:io';

//import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:google_sign_in/google_sign_in.dart';
class AuthHelper {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static signWithemail(String email, String password) async {
    final res = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    final User user = res.user!;
    return user;
  }

  // static signWithgogole() async {
  //   GoogleSignIn googleSignIn = GoogleSignIn();
  //   final acc = await googleSignIn.signIn();
  //   final auth = await acc!.authentication;
  //   final credential = GoogleAuthProvider.credential(
  //       accessToken: auth.accessToken, idToken: auth.idToken);
  // }

  static logOut() {
    //GoogleSignIn().signOut();
    return _auth.signOut();
  }
}
//
// class DatabaseManager {
//   final CollectionReference userlist =
//       FirebaseFirestore.instance.collection('products');
//
//   Future getuserList() async {
//     List itemList = [];
//
//     try {
//       await userlist.get().then((querysnapshot) {
//         querysnapshot.docs.forEach((element) {
//           itemList.add(element.data);
//         });
//       });
//     } catch (e) {
//       return e;
//     }
//   }
// }
