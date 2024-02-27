import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_asif_taj_tutorials/ui/auth/login_screen.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    });
  }
}
