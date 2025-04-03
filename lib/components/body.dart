import 'dart:async';
import 'package:flutter/material.dart';
import '../size_config.dart';
import 'land.dart';
import 'rounded_text_field.dart';
import 'sun.dart';
import 'tabs.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isFullSun = false;
  bool isDayMood = true;
  Duration _duration = Duration(seconds: 1);

  @override
  void initState() {
    super.initState();
    // Menunda perubahan status matahari dengan delay 1 detik
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        isFullSun = true;
      });
    });
  }

  // Mengubah mood berdasarkan tab yang aktif
  void changeMood(int activeTabNum) {
    if (activeTabNum == 0) {
      // Siang mood
      setState(() {
        isDayMood = true;
      });
      Future.delayed(Duration(milliseconds: 300), () {
        setState(() {
          isFullSun = true;
        });
      });
    } else {
      // Malam mood
      setState(() {
        isFullSun = false;
      });
      Future.delayed(Duration(milliseconds: 300), () {
        setState(() {
          isDayMood = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Color> lightBgColors = [
      Color(0xFF8C2480),
      Color(0xFFCE587D),
      Color(0xFFFF9485),
      if (isFullSun) Color(0xFFFF9D80),
    ];

    var darkBgColors = [
      Color(0xFF0D1441),
      Color(0xFF283584),
      Color(0xFF376AB2),
    ];

    return AnimatedContainer(
      duration: _duration,
      curve: Curves.easeInOut,
      width: double.infinity,
      height: SizeConfig.screenHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDayMood ? lightBgColors : darkBgColors,
        ),
      ),
      child: Stack(
        children: [
          // Menampilkan matahari
          Sun(duration: _duration, isFullSun: isFullSun),
          // Menampilkan tanah
          Land(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Jarak atas
                  VerticalSpacing(of: 50),
                  // Widget Tabs untuk memilih mood
                  Tabs(
                    key: Key('tabs-widget'), // Key untuk memastikan parameter tidak null
                    press: (value) {
                      changeMood(value);
                    },
                  ),
                  VerticalSpacing(),
                  // Teks "Good Morning"
                  Text(
                    "Good Morning",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  VerticalSpacing(of: 10),
                  // Teks "Enter your Informations below"
                  Text(
                    "Enter your Informations below",
                    style: TextStyle(color: Colors.white),
                  ),
                  VerticalSpacing(of: 50),
                  // Field untuk email
                  RoundedTextField(
                    initialValue: "dudecoderr@gmail.com",
                    hintText: "Email",
                  ),
                  VerticalSpacing(),
                  // Field untuk password
                  RoundedTextField(
                    initialValue: "XXXXXXX",
                    hintText: "Password",
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
