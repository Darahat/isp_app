import 'package:flutter/material.dart';
import 'package:isp/widgets/navigation_drawer_widget.dart';

class TrafficReport extends StatefulWidget {
  const TrafficReport({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<TrafficReport> createState() => _TrafficReportState();
}

class _TrafficReportState extends State<TrafficReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        backgroundColor: Colors.green,

        // Here we take the value from the Home object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Traffic Report',
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
