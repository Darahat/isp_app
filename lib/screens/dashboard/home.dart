import 'package:flutter/material.dart';
import 'package:isp/widgets/navigation_drawer_widget.dart';
import 'package:isp/models/user_model.dart';
import 'package:isp/fetchData/Services.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<Customer> futureCustomer;

  @override
  void initState() {
    super.initState();
    futureCustomer = Services.fetchCustomer();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      drawer: const NavigationDrawerWidget(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottomOpacity: 0.0,
        title: Center(
            child: Text(widget.title,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black87))),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: FutureBuilder<Customer>(
        future: futureCustomer,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            DateTime myvalue = snapshot.data!.expiration;
            // ignore: avoid_print
            String formattedDate = DateFormat('dd-MM-yyyy').format(myvalue);

            return Container(
                padding: EdgeInsets.all(30),
                child: ListView(
                  children: <Widget>[
                    Card(
                        elevation: 10,
                        color: Colors.orangeAccent,
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      const Text('Package name',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Roboto',
                                              fontSize: 15,
                                              color: Colors.white)),
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Text(snapshot.data!.srvname,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontFamily: 'Roboto',
                                                fontSize: 30,
                                                color: Colors.white)),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Text('Exp: $formattedDate',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Roboto',
                                                  fontSize: 12,
                                                  color: Colors.white))),
                                      Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                                foregroundColor:
                                                    MaterialStateColor
                                                        .resolveWith((states) =>
                                                            Colors.white),
                                                backgroundColor:
                                                    MaterialStateColor
                                                        .resolveWith((states) =>
                                                            Colors.grey)),
                                            onPressed: () => {},
                                            child: const Text('Upgrade'),
                                          )),
                                    ],
                                  )
                                ],
                              ),
                              const Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: const [
                                      Text(
                                        'Price',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.grey),
                                      ),
                                      Text(
                                        'Mac:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.price_change,
                                            color: Colors.grey,
                                            size: 24.0,
                                            semanticLabel:
                                                'Text to announce in accessibility modes',
                                          ),
                                          Text(
                                            '  ${snapshot.data!.unitprice.substring(0, snapshot.data!.unitprice.indexOf('.'))} TK',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        snapshot.data!.mac,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        )),
                    Card(
                        child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Table(
                            children: [
                              TableRow(children: [
                                TableCell(
                                    child: Text(
                                        'Package : ${snapshot.data!.srvname}')),
                                TableCell(
                                  child: Text(
                                      'Price : ${snapshot.data!.unitprice}'),
                                ),
                              ]),
                              TableRow(
                                children: [
                                  TableCell(
                                    child:
                                        Text('Bill Due Date:: $formattedDate'),
                                  ),
                                  TableCell(
                                    child: Text(''),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
                  ],
                ));

            //  Card(
            //   child: Column(
            //     mainAxisSize: MainAxisSize.min,
            //     children: <Widget>[
            //       const ListTile(
            //         leading: Icon(Icons.album, size: 45),
            //         title: Text('Sonu Nigam'),
            //         subtitle: Text('Best of Sonu Nigam Song'),
            //       ),
            //     ],
            //   ),
            // );
            //
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
