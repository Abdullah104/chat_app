import 'dart:io';

import 'package:chat_app/routes/chat_route.dart';
import 'package:chat_app/widgets/authentication/authentication_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AuthenticationRoute extends StatelessWidget {
  static const routeName = '/authentication';
  const AuthenticationRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthenticationForm(
        submitHandler: _submitAuthenticationForm,
      ),
    );
  }

  Future<void> _submitAuthenticationForm({
    required String email,
    required String password,
    required BuildContext context,
    File? image,
    String? username,
    bool isLogin = true,
  }) async {
    try {
      if (isLogin) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        final result =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        final reference = FirebaseStorage.instance
            .ref()
            .child('users_images')
            .child('${result.user!.uid}.jpg');

        final imageUploadResult =
            await reference.putFile(image!).whenComplete(() async {});

        final url = await imageUploadResult.ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(result.user!.uid)
            .set({
          'username': username,
          'email': email,
          'image_url': url,
        });

        FirebaseAuth.instance.currentUser!.updateDisplayName(username);
      }

      Navigator.pushNamedAndRemoveUntil(
        context,
        ChatRoute.routeName,
        (route) => false,
      );
    } on FirebaseAuthException catch (exception) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).errorColor,
          content: Text(
            exception.message ?? 'An error occured, check your credentials',
          ),
        ),
      );
    }
  }
}
