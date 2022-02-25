import 'package:flutter/material.dart';
import 'package:isp/config/routes/router.dart';
import 'package:isp/screens/dashboard/home.dart';
import 'package:isp/screens/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:isp/screens/splash/splashscreen.dart';

checkIfAuthenticated() async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setBool('isLoggedin', false);
  final bool? isLoggedin = prefs.getBool('isLoggedin');
  await Future.delayed(const Duration(seconds: 2));
  if (isLoggedin == true) {
    print(isLoggedin);
    return true;
  } else {
    print(isLoggedin);
    return false;
  } // could be a long running task, like a fetch from keychain
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: RouterGenerator.generateRoute,
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => const LoginPage(title: 'Login'),
        '/home': (context) => const Home(title: 'Dashboard'),
      },
    );
  }
}
