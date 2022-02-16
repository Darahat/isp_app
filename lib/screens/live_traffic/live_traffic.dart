import 'dart:async';

import 'package:flutter/material.dart';
import 'package:isp/fetchData/Services.dart';
import 'package:isp/widgets/navigation_drawer_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LiveTraffic extends StatefulWidget {
  const LiveTraffic({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<LiveTraffic> createState() => _LiveTrafficState();
}

class _LiveTrafficState extends State<LiveTraffic> {
  Services services = Services();
  List chartData = [];

  @override
  void initState() {
    Services.fetchTrafficLiveReport().then((trafficReportFromServer) {
      setState(() {
        chartData = trafficReportFromServer;
      });
    });
    // Timer.periodic(const Duration(seconds:1),updateDataSource)
    super.initState();
  }

// void updateDataSource(Timer timer){
//   chartData.add()
// }
  String individual = "bps";
  Text convertion(value) {
    if (value <= 999) {
      individual = "bps";
      value = value;
    } else if (value >= 1000 && value <= 999999) {
      individual = "kbps";
      value = value / 1000;
    } else if (value >= 1000000 && value <= 999999999) {
      individual = "mbps";
      value = value / 1000000;
    } else if (value >= 1000000000 && value <= 999999999999) {
      individual = "GBPS";
      value = value / 1000000000;
    }
    return Text('$value $individual',
        textAlign: TextAlign.left,
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            drawer: const NavigationDrawerWidget(),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              bottomOpacity: 0.0,
              title: Text(widget.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black87)),
              iconTheme: IconThemeData(color: Colors.black),
            ),
            body: Center(
                child: StreamBuilder(
              stream: Stream.periodic(const Duration(seconds: 1)).asyncMap(
                  (i) => Services
                      .fetchTrafficLiveReport()), // i is null here (check periodic docs)
              // builder: (context, snapshot) => Text(
              //     '${snapshot.toString()}'
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        var post = snapshot.data[index];
                        int download =
                            int.parse(snapshot.data[index].rxBitsPerSecond);
                        int upload =
                            int.parse(snapshot.data[index].txBitsPerSecond);

                        return Card(
                            elevation: 10,
                            color: Colors.blue,
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: const [
                                          Text('Download',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Roboto',
                                                  fontSize: 20,
                                                  color: Colors.white))
                                        ],
                                      ),
                                      Column(
                                        children: const [
                                          Text('Upload',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Roboto',
                                                  fontSize: 20,
                                                  color: Colors.white)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [convertion(download)],
                                      ),
                                      Column(
                                        children: [convertion(upload)],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ));
                      });
                  // return Card(
                  //   title: convertion(download),
                  //   subtitle: convertion(upload),
                  // );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
              // FutureBuilder(
              //     future: Services.fetchTrafficLiveReport(),
              //     builder: (BuildContext context, AsyncSnapshot snapshot) {
              //       if (snapshot.hasData) {
              //         String trafficReport = snapshot.data;

              //         return Text('${trafficReport.length}');
              //         // This trailing comma makes auto-formatting nicer for build methods.
              //       } else {
              //         return const Text('asdf');
              //       }
              //     })

//  FutureBuilder(
//                     future: Services.fetchTrafficLiveReport(),
//                     builder: (BuildContext context, AsyncSnapshot snapshot) {
//                       if (snapshot.hasData) {
//                         List<String> trafficReport = snapshot.data;

//                         return Text('$chartData');
//                         // This trailing comma makes auto-formatting nicer for build methods.
//                       } else {
//                         return const Text('asdf');
//                       }
//                     })
            ))));
  }
}
