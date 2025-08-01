// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class AuthMethod {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   // SignUp User

//   Future<String> signupUser({
//     required String email,
//     required String password,
//     required String name,
//     required String empId,
//   }) async {
//     String res = "Some Error Occurred";
//     try {
//       if (email.isNotEmpty || password.isNotEmpty || name.isNotEmpty) {
//         // register user in auth with email and password
//         UserCredential cred = await _auth.createUserWithEmailAndPassword(
//           email: email,
//           password: password,
//         );
//         // add user to your  firestore database
//         print(cred.user!.uid);
//         await _firestore.collection("users").doc(cred.user!.uid).set({
//           'name': name,
//           'uid': cred.user!.uid,
//           'email': email,
//         });

//         res = "success";
//       }
//     } catch (err) {
//       return err.toString();
//     }
//     return res;
//   }

//   // logIn user
//   Future<String> loginUser({
//     required String email,
//     required String password,
//   }) async {
//     String res = "Some error Occurred";
//     try {
//       if (email.isNotEmpty || password.isNotEmpty) {
//         // logging in user with email and password
//         await _auth.signInWithEmailAndPassword(
//           email: email,
//           password: password,
//         );
//         res = "success";
//       } else {
//         res = "Please enter all the fields";
//       }
//     } catch (err) {
//       return err.toString();
//     }
//     return res;
//   }

//   // for sighout
//   signOut() async {
//     // await _auth.signOut();
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethod {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // SignUp User
  Future<String> signupUser({
    required String email,
    required String password,
    required String name,
    required String empId, // ✅ added empId
  }) async {
    String res = "Some Error Occurred";
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          name.isNotEmpty &&
          empId.isNotEmpty) {
        // Register user in Firebase Auth
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Add user data to Firestore
        await _firestore.collection("users").doc(cred.user!.uid).set({
          'uid': cred.user!.uid,
          'name': name,
          'email': email,
          'empId': empId, // ✅ save empId
          'timestamp': FieldValue.serverTimestamp(),
        });

        res = "success";
      } else {
        res = "Please fill in all fields";
      }
    } on FirebaseAuthException catch (e) {
      res = e.message ?? "Authentication error";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Login User
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        // Login using Firebase Auth
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } on FirebaseAuthException catch (e) {
      res = e.message ?? "Authentication error";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Sign Out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}

