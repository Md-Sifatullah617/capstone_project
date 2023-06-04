import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthServices {
  signupUser(String name, String phone, String email, String password, context,
      String userTypes) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
      await FirebaseAuth.instance.currentUser!.updateEmail(email);
      await FirestoreServices.saveUserdata(
          name, email, userCredential.user!.uid, phone, userTypes);
      print("Registration Successfull");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Registration Successfull"),
      ));
    } on FirebaseAuthException catch (error) {
      if (error.code == "weak-password") {
        print("Password provided is too weak");
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Password provided is too weak"),
        ));
      } else if (error.code == "email-already-in-use") {
        print("Email provided is already exist");
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Email provided is already exist"),
        ));
      }
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }

  signinUser(String email, String password, context) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (error) {
      if (error.code == "user-not-found") {
        print("No user found with this email.");
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("No user found with this email."),
        ));
      } else if (error.code == "wrong-password") {
        print("Password didn't match");
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Password didn't match"),
        ));
      }
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
      return null;
    }
  }
}

class FirestoreServices {
  static saveUserdata(
      String name, String email, uid, String phone, String userTypes) async {
    await FirebaseFirestore.instance.collection("users").doc(uid).set(
        {"email": email, "name": name, "phone": phone, "userTypes": userTypes});
  }
  
  static Future<DocumentSnapshot<Map<String, dynamic>>> getUserData(String uid) async {
    return FirebaseFirestore.instance.collection("users").doc(uid).get();
  }
}
