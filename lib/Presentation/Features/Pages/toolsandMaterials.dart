import 'package:biyoar/Core/Customs/customColors.dart';
import 'package:biyoar/Core/Customs/customText.dart';
import 'package:flutter/material.dart';

class ToolsMaterialsPage extends StatefulWidget {
  const ToolsMaterialsPage({super.key});

  @override
  State<ToolsMaterialsPage> createState() => _ToolsMaterialsPageState();
}

class _ToolsMaterialsPageState extends State<ToolsMaterialsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          child: AppBar(
            centerTitle: true,
            title: const CustomText(
              text: 'Tools & Materials',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: whiteColor,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/biyorbgi.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: whiteColor, size: 30),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
      backgroundColor: whiteColor,
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(height: 10),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
              right: 20,
              left: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Heading
                buildHeading("Dandi (Large Stick)"),
                buildBullet("Length: 1–2 feet (30–60 cm)"),
                buildBullet("Material: Wood, sturdy enough to strike the Biyo"),
                buildBullet(
                    "Purpose: Used to hit the small stick and send it flying"),

                const SizedBox(height: 20),

                buildHeading("Biyo (Small Stick)"),
                buildBullet("Length: 3–4 inches (7–10 cm)"),
                buildBullet("Material: Wood, lightweight"),
                buildBullet(
                    "Purpose: The target stick that players strike and try to hit far"),

                const SizedBox(height: 20),

                buildHeading("Playing Area"),
                buildBullet("Flat and open space (ground or grass)"),
                buildBullet("Enough area to allow the Biyo to travel safely"),

                const SizedBox(height: 20),

                buildHeading("Markers"),
                buildBullet("Starting point for placing the Biyo"),
                buildBullet("Distance measuring points"),
                buildBullet("Boundaries or scoring zones"),

                const SizedBox(height: 20),

                buildHeading("Measuring Tool"),
                buildBullet("Ruler, tape, or using steps / Dandi lengths"),
                buildBullet(
                    "(Our app can measure Biyo distance automatically—no ruler needed!)"),

                const SizedBox(height: 20),

                buildHeading("Players"),
                buildBullet("Minimum 2 players or 2 teams"),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  /// **************CUSTOM HEADING WIDGET *******************
  Widget buildHeading(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  /// **************CUSTOM HEADING WIDGET *******************

  /// **************CUSTOM BULLET POINT WIDGET ********************************
  Widget buildBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("•  ", style: TextStyle(fontSize: 16)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          )
        ],
      ),
    );
  }

  /// **************CUSTOM BULLET POINT WIDGET ********************************
}
