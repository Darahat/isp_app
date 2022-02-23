import 'package:flutter/material.dart';
import 'package:isp/config/routes/router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      initialRoute: '/login',
      onGenerateRoute: RouterGenerator.generateRoute,
    );
  }
}
