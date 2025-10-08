import 'package:flutter/material.dart';
import 'package:netflix_clone/consts/color.dart';

class CustomButton3 extends StatelessWidget {
  final IconData icon;
  final String text;
  const CustomButton3({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: white, size: 40),
        Text(text, style: TextStyle(color: Colors.grey, fontSize: 15)),
      ],
    );
  }
}
