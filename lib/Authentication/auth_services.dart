import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      print("Registration Successfull");
    } on FirebaseAuthException catch (error) {
      if (error.code == "weak-password") {
        print("Password provided is too weak");
      } else if (error.code == "email-already-in-use") {
        print("Email provided is already exist");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static signinUser(String email, String password) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
          return userCredential;
    } on FirebaseAuthException catch (error) {
      if (error.code == "user-not-found") {
        print("No user found with this email.");
      } else if (error.code == "wrong-password") {
        print("Password didn't match");
      }
    } catch (e) {
      print(e.toString());
      return null;
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
