import 'package:biyoar/Core/Customs/customColors.dart';
import 'package:biyoar/Core/Customs/customElevatedButton.dart';
import 'package:biyoar/Core/Customs/customText.dart';
import 'package:biyoar/Presentation/Features/Pages/aboutUs.dart';

import 'package:biyoar/Presentation/Features/Pages/toolsandMaterials.dart';
import 'package:biyoar/test/ChickenObject.dart';

import 'package:flutter/material.dart';

class UserDashboardScreen2 extends StatefulWidget {
  const UserDashboardScreen2({super.key});

  @override
  _UserDashboardScreen2State createState() => _UserDashboardScreen2State();
}

class _UserDashboardScreen2State extends State<UserDashboardScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ✅ Background: gradient + image
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  biyorColor,
                  Colors.black,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // optional AR-themed overlay image
          // Positioned.fill(
          //   child: Opacity(
          //     opacity: 0.3,
          //     child: Image.asset(
          //       "assets/images/triangle.png",
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),

          // Main content
          Column(
            children: [
              const SizedBox(height: 70),
              // Center(
              //   child: CustomText(
              //     text: "Scan your ground to begin",
              //     fontSize: 20,
              //     fontWeight: FontWeight.bold,
              //     color: Colors.white,
              //   ),
              // ),

              const SizedBox(height: 60),

              // AR DandiBiyo icon/image
              Image.asset(
                "assets/images/game.png",
                height: 200,
                width: 200,
              ),
              const SizedBox(height: 10),

             const Center(
                child: CustomText(
                  text: "AR DandiBiyo",
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            const  Center(
                child: CustomText(
                  text: "Reviving Tradition Through",
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              const Center(
                child: CustomText(
                  text: "Augmented Reality",
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ],
          ),

          // Bottom buttons
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Start AR button
                    SizedBox(
                      height: 70,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: CustomButton(
                        color: biyorColor.withOpacity(0.3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 40,
                            ),
                            SizedBox(width: 10),
                            CustomText(
                              text: "Start BiyoR",
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => 
                              ChickenObjectWidget(),
                        
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 30),

                    // About Game and Tools/Materials
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ToolsMaterialsPage(),
                                  ),
                                );
                              },
                              child: const Icon(
                                Icons.settings,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                            const CustomText(
                              text: "Tools/Materials",
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),

                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AboutUsPage(),
                                  ),
                                );
                              },
                              child: const Icon(
                                Icons.info,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                            const CustomText(
                              text: "About Game",
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
