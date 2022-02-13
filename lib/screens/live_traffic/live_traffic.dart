import 'package:flutter/material.dart';
import 'package:isp/fetchData/Services.dart';
import 'package:isp/widgets/navigation_drawer_widget.dart';

class LiveTraffic extends StatefulWidget {
  const LiveTraffic({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<LiveTraffic> createState() => _LiveTrafficState();
}

class _LiveTrafficState extends State<LiveTraffic> {
  Services services = Services();
  List usersFiltered = [];

  @override
  void initState() {
    super.initState();
    Services.fetchTrafficLiveReport().then((trafficReportFromServer) {
      setState(() {
        usersFiltered = trafficReportFromServer;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          backgroundColor: Colors.green,

          // Here we take th
          //e value from the Home object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: FutureBuilder(
            future: Services.fetchTrafficLiveReport(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                List trafficReport = snapshot.data;

                return Text('${trafficReport.length}');
                // This trailing comma makes auto-formatting nicer for build methods.
              } else {
                return const Text('asdf');
              }
            }));
  }
}
