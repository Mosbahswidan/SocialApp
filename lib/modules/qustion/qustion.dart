import 'package:flutter/material.dart';

class Qustion extends StatelessWidget {
   String? qustionText;
   Qustion(this.qustionText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Text(qustionText!,
        style: TextStyle(
          fontSize: 24,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
