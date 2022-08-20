import 'package:flutter/material.dart';

class ButtonCustomStyles {

  final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
      minimumSize: const Size(50, 50),
      maximumSize: const Size(300, 60),
      padding: const EdgeInsets.symmetric(horizontal: 32),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      textStyle: const TextStyle(
          fontSize: 15
      )
  );

  ButtonStyle outlinedButtonStyle(Color color) => OutlinedButton.styleFrom(
      minimumSize: const Size(50, 50),
      maximumSize: const Size(300, 60),
      padding: const EdgeInsets.symmetric(horizontal: 32),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      textStyle: const TextStyle(
          fontSize: 15
      )
  ).copyWith(
    side: MaterialStateProperty.resolveWith<BorderSide>((Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)) {
        return BorderSide(
          color: color,
          width: 1
        );
      }
      return BorderSide(
          color: color,
          width: 1
      );
    })
  );

}