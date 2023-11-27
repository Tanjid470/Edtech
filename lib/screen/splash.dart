

import 'dart:async';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:edtech/constants/app_colors.dart';
import 'package:edtech/screen/Authentication/login_From.dart';
import 'package:edtech/screen/Dashboard/dashBoard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        splash:const Text(".",style: TextStyle(color: Colors.white,fontSize:100 ),),
        //  Icon(Icons.music_note,color: AppColors.bgcolor,size: 100,), 
        splashIconSize: 100,
        duration: 100,
        animationDuration: Duration(seconds: 2),
        splashTransition: SplashTransition.rotationTransition,
        backgroundColor: AppColors.purple,
        nextScreen: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const Home();
        } else {
          return const LoginForm();
        }
      },
    ), 
      )
    );
  }
}