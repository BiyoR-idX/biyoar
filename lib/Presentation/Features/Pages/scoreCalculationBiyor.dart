import 'package:biyoar/Core/Customs/customColors.dart';
import 'package:biyoar/Core/Customs/customTextForm.dart';
import 'package:flutter/material.dart';

class BiyoRScoreCalculationLLM extends StatefulWidget {
  const BiyoRScoreCalculationLLM({super.key});

  @override
  State<BiyoRScoreCalculationLLM> createState() =>
      _BiyoRScoreCalculationLLMState();
}

class _BiyoRScoreCalculationLLMState extends State<BiyoRScoreCalculationLLM> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 🔹 BACKGROUND IMAGE
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/biyorbgi.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          /// 🔹 MAIN CONTENT
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                /// 🔙 BACK BUTTON
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                    iconSize: 30,
                  ),
                ),

                const SizedBox(height: 10),

                /// 🔹 SCROLLABLE CHAT CONTENT
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        /// USER MESSAGE (READ ONLY)
                        TextFormField(
                          readOnly: true,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText:
                                "Biyo is in 6th zone of the layout, so calculate the score..",
                            hintStyle: TextStyle(color: whiteColor),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 24, horizontal: 16),
                            enabledBorder: _border(),
                            focusedBorder: _border(),
                          ),
                        ),

                        const SizedBox(height: 20),

                        /// LLM RESPONSE BOX
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 50,
                          ),
                          child: TextFormField(
                            readOnly: true,
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: "LLM is calculating score..",
                              hintStyle: TextStyle(color: whiteColor),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 24, horizontal: 16),
                              enabledBorder: _border(),
                              focusedBorder: _border(),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10), // space above input
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Type a message to calculate score",
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: borderColor, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: borderColor, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: borderColor, width: 2),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.send,
                      color: borderColor,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  OutlineInputBorder _border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: borderColor, width: 2),
    );
  }
}
