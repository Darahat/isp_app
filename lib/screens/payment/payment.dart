import 'dart:async';

import 'package:flutter/material.dart';
import 'package:isp/widgets/navigation_drawer_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  String username2 = '';
  String url = '';

  getId() async {
    final prefs = await SharedPreferences.getInstance();
    final String? username = prefs.getString('username');
    return username.toString();
  }

  @override
  void initState() {
    try {
      getId().then((username) {
        setState(() {
          username2 = username;
          url = 'https://panel.aniknetwork.net/bkash/index.php?username=asdfa';
        });
      });
    } catch (e) {
      throw Exception("Failed to load user information");
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,");
    // print(username2);
    try {
      getId().then((username) {
        username2 = username;
        url = 'https://panel.aniknetwork.net/bkash/index.php?username=asdfsaf';
      });
    } catch (e) {
      throw Exception("Failed to load user information");
    }
    print(",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,");
    print("url");
    // username2 = getId().then((username) => print(username));
    //    final prefs = await SharedPreferences.getInstance();
    // final String? username = prefs.getString('username');
    if (username2.isEmpty) {
      return SafeArea(
          child: Scaffold(
              drawer: const NavigationDrawerWidget(),
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                bottomOpacity: 0.0,
                title: Text(widget.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xff2BC992),
                    )),
                iconTheme: const IconThemeData(
                  color: Color(0xff2BC992),
                ),
              ),
              body: CircularProgressIndicator()));
    } else {
      return SafeArea(
          child: Scaffold(
              drawer: const NavigationDrawerWidget(),
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                bottomOpacity: 0.0,
                title: Text(widget.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xff2BC992),
                    )),
                iconTheme: const IconThemeData(
                  color: Color(0xff2BC992),
                ),
              ),
              body: WebView(
                  initialUrl:
                      'https://panel.aniknetwork.net/bkash/index.php?username=$username2',
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {})));
    }
  }
}
