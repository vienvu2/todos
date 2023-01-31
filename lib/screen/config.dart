import 'package:flutter/material.dart';

class Config extends StatelessWidget {
  const Config({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          alignment: Alignment.center,
          child: const Text(
            'Config',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        // Expanded(),
      ],
    );
  }
}
