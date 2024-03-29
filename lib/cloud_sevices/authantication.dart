import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Desktop/screens/home_page.dart';
import '../Desktop/screens/login.dart';

Future<void> signup(String email, String password) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? userId;
  try {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (userCredential.user != null) {
      // User created successfully, store user details in Firestore
      userId = userCredential.user!.uid;

      // Add user details to Firestore

      await firestore.collection('users').doc(userId).set({
        'email': email,
        // Add other user details here if needed
      });

      // Navigate to login page
      Get.off(() => const DLoginPage());
      log('Account Created');
    } else {
      log('Account Not Created');
    }
  } on FirebaseException catch (e) {
    log(e.toString());
    Get.dialog(AlertDialog(
      content: Text(e.message.toString()),
    ));
  }
}

Future<void> login(String email, String password) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  String? userId;

  try {
    UserCredential userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    if (userCredential.user != null) {
      User? user = userCredential.user;
      userId = userCredential.user!.uid;
      log('Email : ${user?.email}');
      log(userId.toString());
      log('Loged In');
      Get.offAll(() => const DHomePage());
    } else {
      log('Not Loged In');
    }
  } on FirebaseAuthException catch (e) {
    log(e.toString());
    Get.dialog(AlertDialog(
      content: Text(e.message.toString()),
    ));
  }
}

Future signOut() async {
  try {
    await FirebaseAuth.instance.signOut();
  } catch (e) {
    log(e.toString());
  }
}

Future forgotpass(String email) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  } on FirebaseAuthException catch (e) {
    Get.dialog(
      AlertDialog(
        content: Text(e.message.toString()),
      ),
    );
  }
}

void showLoadingIndicator(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevent dismiss on tap outside
    builder: (BuildContext context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );
}
