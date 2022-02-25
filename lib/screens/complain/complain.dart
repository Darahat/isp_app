import 'package:flutter/material.dart';
import 'package:isp/widgets/navigation_drawer_widget.dart';

class Complain extends StatefulWidget {
  const Complain({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<Complain> createState() => _ComplainState();
}

class _ComplainState extends State<Complain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
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
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(''),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
