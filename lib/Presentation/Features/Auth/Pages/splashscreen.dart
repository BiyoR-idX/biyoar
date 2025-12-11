
import 'package:biyoar/Core/Customs/customColors.dart';
import 'package:biyoar/Presentation/Features/Dashboard/userDashboard.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final String appName = "BiyoR";

  @override
  void initState() {
    super.initState();

    // Wave animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    // Navigate to MainDash after 4 seconds
    Future.delayed(const Duration(seconds: 3), () {
  Navigator.of(context).pushReplacement(
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const UserDashboardScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 500),
    ),
  );
});

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      
      backgroundColor: biyorColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset("assets/images/game.png", width: 200, height: 200),

            const SizedBox(height: 10),

            // Waving text
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(appName.length, (index) {
                    double offsetY =
                        sin((_controller.value * 2 * pi) + (index * 0.5)) * 10;
                    return Transform.translate(
                      offset: Offset(0, -offsetY),
                      child: Text(
                        appName[index],
                        style: GoogleFonts.irishGrover(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }),
                );
              },
            ),

            
          ],
        ),
      ),
    );
  }
}
