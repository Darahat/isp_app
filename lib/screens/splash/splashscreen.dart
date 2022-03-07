import 'dart:async';
import 'dart:core';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:isp/main.dart';
import 'package:isp/screens/dashboard/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Timer(Duration(seconds: 1), () {
    //   Navigator.pushReplacement(context,
    //       MaterialPageRoute(builder: (context) => const Home(title: 'Home')));
    // });
  }

  @override
  Widget build(BuildContext context) {
    checkIfAuthenticated().then((success) {
      if (success) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Expanded(
          flex: 8, // 60% of space => (6/(6 + 4))
          child:Image.asset('assets/images/bg.png')),

            // const SizedBox(
            //   height: 50,
            // ),
            // const SizedBox(
            //   height: 20,
            // ),

  Expanded(
  flex: 3, // 60% of space => (6/(6 + 4))
  child:Center(child: SizedBox(
              width: 250.0,
              child: TextLiquidFill(
                text: 'ISP APP',
                waveColor: const Color(0xff79ADDC),
                boxBackgroundColor: Color(0xffFFEE93),
                textStyle: const TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
                boxHeight: 50.0,
              ),
            )))
          ],
        ),
      ),
    );
  }
}
