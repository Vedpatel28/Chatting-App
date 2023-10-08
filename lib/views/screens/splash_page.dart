import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Timer.periodic(
      const Duration(seconds: 2),
      (timer) {
        Get.offNamed("/LoginPage");
        timer.cancel();
      },
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 230,
              backgroundColor: Colors.white,
              foregroundImage: AssetImage(
                "assets/Images/chat.gif",
              ),
            ),
            const Gap(20),
            const AnimatedOpacity(
              opacity: 0.1,
              duration: Duration(seconds: 1),
            ),
            Text(
              "Chill With Friends",
              style: GoogleFonts.bubblegumSans(
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  shadows: [
                    BoxShadow(
                      offset: Offset(1.4, 0.9),
                      color: Colors.black26,
                    ),
                  ],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
