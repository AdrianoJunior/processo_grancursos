import 'package:flutter/material.dart';

class TextStyles {

  TextStyle titleStyle() {
    return const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w400,
      fontSize: 18,
    );
  }

  TextStyle descStyle() {
    return const TextStyle(
      color: Color(0xff707070),
      fontWeight: FontWeight.w300,
      fontSize: 14,
    );
  }

  TextStyle dateStyle() {
    return const TextStyle(
      color: Color(0xff707070),
      fontWeight: FontWeight.w400,
      fontSize: 16,
    );
  }
}