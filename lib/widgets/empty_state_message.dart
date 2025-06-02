import 'package:flutter/material.dart';

class EmptyStateMessage extends StatelessWidget {
  final String imagePath;
  final String message;

  EmptyStateMessage({required this.imagePath, required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imagePath,
          width: 350,
          height: 350,
          gaplessPlayback: true,
        ),
        SizedBox(height: 10),
        Text(
          message,
          style: TextStyle(color: Colors.black54, fontSize: 16),
        ),
      ],
    );
  }
}
