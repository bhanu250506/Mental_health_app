
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Dummyscreen extends StatelessWidget {
  const Dummyscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          'assets/animations/welcome.json',
          width: 280,
          height: 280,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
