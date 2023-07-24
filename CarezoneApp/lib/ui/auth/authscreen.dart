import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../main/main._view.dart';
import '../resourses/styles_manager.dart';
import '../resourses/values_manager.dart';
import 'authform.dart';

class Authscreen extends StatefulWidget {
  const Authscreen({super.key});
  @override
  State<Authscreen> createState() => _AuthscreenState();
}

class _AuthscreenState extends State<Authscreen> {
  final _auth = FirebaseAuth.instance;
  bool _isloading = false;

  _submitAuthform(String email, String password, String username, bool islogin,
      BuildContext ctx) async {
    try {
      setState(() {
        _isloading = true;
      });
      if (islogin) {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: ((ctx) => const Mainpage()))));
      } else {
        await _auth
            .createUserWithEmailAndPassword(
          email: email,
          password: password,
        )
            .then((value) async {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(value.user!.uid)
              .set({'text': username, 'password': password});
          // ignore: use_build_context_synchronously
          return Navigator.pushReplacement(
              context, MaterialPageRoute(builder: ((ctx) => const Mainpage())));
        });
      }
    } on FirebaseAuthException catch (e) {
      String message = 'error occured';
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password.';
      } else if (e.code == 'weak-password') {
        message = 'The password is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = ' email already exists.';
      }
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(
          message,
          style: getRegularStyle(color: Colors.black, fontSize: AppSize.s16),
        ),
        backgroundColor: Colors.teal,
      ));
      setState(() {
        _isloading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: 400,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/background.png'),
                        fit: BoxFit.fill))),
            AuthForm(_submitAuthform, _isloading),
          ],
        ),
      ),
    );
  }
}
