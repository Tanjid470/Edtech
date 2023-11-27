import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';


Container animationText() {
  return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: AnimatedTextKit(repeatForever: true, animatedTexts: [
        ColorizeAnimatedText('EDTECH',
            textStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 38,
                fontWeight: FontWeight.bold),
            colors:const [
              Color.fromARGB(255, 40, 64, 143),
              Colors.grey,
              Color.fromARGB(255, 74, 39, 155)
            ],
            speed: const Duration(seconds: 3))
      ]));
}
