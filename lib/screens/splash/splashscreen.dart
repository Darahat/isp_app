import 'dart:async';
import 'dart:core';
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
            Image.asset('assets/images/bg.png'),
            const SizedBox(
              height: 50,
            ),
            const CircularProgressIndicator(),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'ISP APP',
            )
          ],
        ),
      ),
    );
  }
}
