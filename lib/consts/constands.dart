import 'dart:ui';
import 'package:flutter/material.dart';

//-->creating sizedBox hight
Widget verticalspace(double height) {
  return SizedBox(height: height);
}

//--> creating sizedbox width
Widget horizontalspace(double width) {
  return SizedBox(width: width);
}

Widget textforemoji(String emojiName) {
  return Text(
    emojiName,
    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  );
}

Widget textforemojiDetails(String emojiDescription) {
  return Text(emojiDescription,
      style: const TextStyle(
          fontStyle: FontStyle.italic, fontWeight: FontWeight.w300));
}
