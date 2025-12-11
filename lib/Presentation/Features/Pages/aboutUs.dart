
import 'package:biyoar/Core/Customs/customColors.dart';
import 'package:biyoar/Core/Customs/customText.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  String appVersion = "";
  void initState() {
    super.initState();
    loadAppVersion();
  }

  //function to load app version
  Future<void> loadAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appVersion = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          child: AppBar(
            title: Center(
              child: CustomText(
                text: 'About BiyoR',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: whiteColor,
              ),
            ),
            backgroundColor: biyorColor,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: whiteColor, size: 30),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      backgroundColor: whiteColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              "DandiBiyo is a digital version of the traditional Nepali game that brings the fun and excitement of this classic pastime to your mobile device. "
              "Hit the stick, follow the rules, and compete with friends to score points. "
              "Experience the excitement of Nepali culture with a fun and interactive game. "
              "Perfect for all age group.",
              style: TextStyle(fontSize: 16, color: blackColor, height: 1.4),
              textAlign: TextAlign.justify,
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: CustomText(
              text: "BiyoR Version: $appVersion",
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: biyorColor,
            ),
          ),
        ],
      ),
    );
  }
}
