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
        title: Text(widget.title,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black87)),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: FutureBuilder<Customer>(
        future: futureCustomer,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            DateTime expiration = snapshot.data!.expiration;
            DateTime createdon = snapshot.data!.createdon;

            // ignore: avoid_print
            String expirationdate = DateFormat('dd-MM-yyyy').format(expiration);
            String createdondate = DateFormat('dd-MM-yyyy').format(createdon);
            const double gap = 10;
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
                                          child: Text('Exp: $expirationdate',
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
                                        'Mac Address:',
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Card(
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                const Text(
                                  'Mac Address:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.green),
                                ),
                                const SizedBox(height: 10.0),
                                Text(
                                  snapshot.data!.mac,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ),
                        Card(
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                const Text(
                                  'Account Created:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.green),
                                ),
                                const SizedBox(height: 10.0),
                                Text(createdondate,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.grey))
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: const [
                            Text(
                              'Personal Details',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: Container(
                          alignment: Alignment.centerLeft,
                          color: Colors.blueGrey,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Name:',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            color: Colors.white)),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                        '${snapshot.data!.firstname} ${snapshot.data!.lastname}',
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.white)),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text('Username:',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            color: Colors.white)),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(snapshot.data!.username,
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.white)),
                                    const Text('Contact:',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            color: Colors.white)),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(snapshot.data!.mobile,
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.white)),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text('Email:',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            color: Colors.white)),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(snapshot.data!.email,
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.white)),
                                  ],
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [],
                                )
//  Text('Mobile:${snapshot.data!.mobile}',
//                                     style: const TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 15,
//                                         color: Colors.grey)),
//                                 Text('Address:${snapshot.data!.address}',
//                                     style: const TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 15,
//                                         color: Colors.grey)),
                                // Text('City:${snapshot.data!.city}',
                                //     style: const TextStyle(
                                //         fontWeight: FontWeight.bold,
                                //         fontSize: 15,
                                //         color: Colors.grey)),
                                // Text('ZIP Code:${snapshot.data!.zip}',
                                //     style: const TextStyle(
                                //         fontWeight: FontWeight.bold,
                                //         fontSize: 15,
                                //         color: Colors.grey)),
                                // Text('Country:${snapshot.data!.country}',
                                //     style: const TextStyle(
                                //         fontWeight: FontWeight.bold,
                                //         fontSize: 15,
                                //         color: Colors.grey)),
                                // Text('Address:${snapshot.data!.address}',
                                //     style: const TextStyle(
                                //         fontWeight: FontWeight.bold,
                                //         fontSize: 15,
                                //         color: Colors.grey)),
                              ],
                            ),
                          )),
                    )
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
