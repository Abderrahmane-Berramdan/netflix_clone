import 'package:flutter/material.dart';
import 'package:netflix_clone/consts/color.dart';

class CustomButton1 extends StatelessWidget {
  final String text;
  const CustomButton1({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: black,
        borderRadius: BorderRadius.circular(35),
        border: Border.all(color: white),
      ),
      child: Text(text, style: TextStyle(fontSize: 15, color: white)),
    );
  }
}
