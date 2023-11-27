import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  static const buttonColor = Color.fromARGB(255, 34, 150, 38);
  static const bgcolor = Color.fromARGB(255, 3, 53, 94);
  static const purple = Color.fromARGB(255, 74, 39, 155);
  static const blue = Color.fromARGB(255, 40, 64, 143);
  static Gradient bgGradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
          Color.fromARGB(255, 40, 64, 143),
          Color.fromARGB(255, 74, 39, 155) 
    ],
  );
}
