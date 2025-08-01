import 'package:flutter/material.dart';
import 'package:mhack/components/style_constants.dart';

import 'package:mhack/leaderboard.dart';

class Navbar extends StatelessWidget {
  final bool isMobile;

  const Navbar({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double paddingH = constraints.maxWidth < 768 ? 16 : 32;
        final double fontSize = constraints.maxWidth < 768 ? 16 : 20;

        return Container(
          padding: EdgeInsets.only(top: 32, left: paddingH, right: paddingH),
          color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo and title
              Row(
                children: [
                  const Icon(Icons.code, color: Colors.cyanAccent),
                  const SizedBox(width: 6),
                  ShaderMask(
                    shaderCallback: (bounds) =>
                        const LinearGradient(
                          colors: [Colors.cyanAccent, Colors.purpleAccent],
                        ).createShader(bounds),
                    child: Text(
                      'Manipal Hackathon 2025',
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // fallback color for web
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}