import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  const MyButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final isMobile = width < 600;

    // Responsive font sizes with caps
    double buttonFontSize = isMobile ? 14 : width * 0.013;
    double buttonWidth = isMobile ? width * 0.5 : width * 0.15;
    double buttonHeight = isMobile ? height * 0.06 : height * 0.065;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF002147),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          fixedSize: Size(buttonWidth, buttonHeight),
        ),
        child: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFF00FFFF), Color(0xFFFF00FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: buttonFontSize,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              height: 1.4,
              fontFamily: 'Xavier2',
            ),
          ),
        ),
      ),
    );
  }
}


void navigateToPage({
  required BuildContext context,
  required Widget page,
  required String routeName,
  bool replace = true,
  Duration duration = const Duration(milliseconds: 300),
}) {
  final route = PageRouteBuilder(
    settings: RouteSettings(name: routeName),
    pageBuilder: (_, __, ___) => page,
    transitionsBuilder: (_, animation, __, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
    transitionDuration: duration,
  );

  if (replace) {
    Navigator.pushReplacement(context, route);
  } else {
    Navigator.push(context, route);
  }
}
class BulletPoint extends StatelessWidget {
  final String text;
  final Color color;
  const BulletPoint({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.circle, size: 10, color: color),
        const SizedBox(width: 6),
        Text(text, style: TextStyle(fontSize:isMobile?15:20,color: Colors.white70)),
      ],
    );
  }
}

