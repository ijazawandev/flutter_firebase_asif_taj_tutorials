import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_asif_taj_tutorials/post/post_screen.dart';
import 'package:flutter_firebase_asif_taj_tutorials/ui/auth/login_screen.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final auth =FirebaseAuth.instance;
    final user=auth.currentUser;
    if(user !=null){

      Timer.periodic(const Duration(seconds: 3), (timer) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PostScreen(),
          ),
        );
      });

    }else{

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
}
