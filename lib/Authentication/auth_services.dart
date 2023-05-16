import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_auth/components/Style/toast_message.dart';

class AuthServices {
  static signupUser(
      String name, String phone, String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
      await FirebaseAuth.instance.currentUser!.updateEmail(email);
      await FirestoreServices.saveUserdata(
          name, email, userCredential.user!.uid);
      successToast("Registration Successfull");
    } on FirebaseAuthException catch (error) {
      if (error.code == "weak-password") {
        errorToast("Password provided is too weak");
      } else if (error.code == "email-already-in-use") {
        errorToast("Email provided is already exist");
      }
    } catch (e) {
      errorToast(e.toString());
    }
  }

  static signinUser(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      successToast("You are successfully loged in");
    } on FirebaseAuthException catch (error) {
      if (error.code == "user-not-found") {
        errorToast("No user found with this email.");
      } else if (error.code == "wrong-password") {
        errorToast("Password didn't match");
      }
    } catch (e) {
      errorToast(e.toString());
    }
  }
}

class FirestoreServices {
  static saveUserdata(String name, email, uid) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .set({"email": email, "name": name});
  }
}
