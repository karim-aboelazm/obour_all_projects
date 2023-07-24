import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:carezone/ui/disease_diagnosis_screen/disease_diagnosis_screen.dart';

class Ai extends StatefulWidget {
  const Ai({super.key});

  @override
  State<Ai> createState() => Aistate();
}

class Aistate extends State<Ai> {
  // ignore: prefer_typing_uninitialized_variables
  var _time;
  start() {
    _time = Timer(const Duration(seconds: 2), call);
  }

  void call() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const DiseaseDiagosis(),
      ),
    );
  }

  @override
  void initState() {
    start();
    super.initState();
  }

  @override
  void dispose() {
    _time.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff55598d),
      body: Center(child: Lottie.asset('images/121988-ai-animation.json')),
    );
  }
}
