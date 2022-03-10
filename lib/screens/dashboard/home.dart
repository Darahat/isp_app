// ignore_for_file: unnecessary_const

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
            style: const TextStyle(
              color: Color(0xff2BC992),
            )),
        iconTheme: const IconThemeData(
          color: Color(0xff2BC992),
        ),
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
            bool _customTileExpanded = false;
            const double gap = 10;
            return Container(
                padding: EdgeInsets.all(30),
                child: ListView(
                  children: <Widget>[
                    Card(
                        elevation: 10,
                        color: const Color(0xff79ADDC),
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
                                                            const Color(
                                                                0xff79ADDC)),
                                                backgroundColor:
                                                    MaterialStateColor
                                                        .resolveWith(
                                                  (states) =>
                                                      const Color(0xffFFEE93),
                                                )),
                                            onPressed: () => {
                                              Navigator.of(context)
                                                  .pushNamed('/payment')
                                            },
                                            child: const Text('Pay Now'),
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
                                          color: const Color(0xffFFEE93),
                                        ),
                                      ),
                                      Text(
                                        'Mac Address:',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          color: const Color(0xffFFEE93),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.price_change,
                                            color: const Color(0xffFFEE93),
                                            size: 24.0,
                                            semanticLabel:
                                                'Text to announce in accessibility modes',
                                          ),
                                          Text(
                                            '  ${snapshot.data!.unitprice.substring(0, snapshot.data!.unitprice.indexOf('.'))} TK',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: const Color(0xffFFEE93)),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        snapshot.data!.mac,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            color: Color(0xffFFEE93)),
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
                                    color: const Color(0xff2BC992),
                                  ),
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
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                const Text(
                                  'Acc. Created:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: const Color(0xff2BC992),
                                  ),
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
                              'My Details',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: const Color(0xff79ADDC),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: Container(
                          alignment: Alignment.centerLeft,
                          color: Colors.white10,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: ExpansionTile(
                                    title: const Text('Personal Info',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: const Color(0xff79ADDC),
                                        )),
                                    children: <Widget>[
                                      ListTile(
                                        title: const Text(
                                          'Name',
                                          style: TextStyle(
                                            color: const Color(0xff79ADDC),
                                          ),
                                        ),
                                        subtitle: Text(
                                            '${snapshot.data!.firstname} ${snapshot.data!.lastname}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Colors.grey)),
                                      ),
                                      ListTile(
                                        title: const Text('Username',
                                            style: TextStyle(
                                              color: const Color(0xff79ADDC),
                                            )),
                                        subtitle: Text(snapshot.data!.username,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Colors.grey)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                    Card(
                      child: Container(
                          alignment: Alignment.centerLeft,
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: ExpansionTile(
                                      title: const Text('Contact Info',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: const Color(0xff79ADDC),
                                          )),
                                      children: <Widget>[
                                        ListTile(
                                          title: const Text('Email',
                                              style: TextStyle(
                                                color: const Color(0xff79ADDC),
                                              )),
                                          subtitle: Text(snapshot.data!.email,
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  color: Colors.grey)),
                                        ),
                                        ListTile(
                                          title: const Text('Mobile',
                                              style: TextStyle(
                                                color: const Color(0xff79ADDC),
                                              )),
                                          subtitle: Text(snapshot.data!.mobile,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  color: Colors.grey)),
                                        ),
                                      ],
                                    ),
                                  )
                                ]),
                          )),
                    ),
                    Card(
                      child: Container(
                          alignment: Alignment.centerLeft,
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: ExpansionTile(
                                      title: const Text('Address',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: const Color(0xff79ADDC),
                                          )),
                                      children: <Widget>[
                                        ListTile(
                                          title: const Text('Area',
                                              style: TextStyle(
                                                color: const Color(0xff79ADDC),
                                              )),
                                          subtitle: Text(snapshot.data!.address,
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  color: Colors.grey)),
                                        ),
                                        ListTile(
                                          title: const Text('City',
                                              style: TextStyle(
                                                color: const Color(0xff79ADDC),
                                              )),
                                          subtitle: Text(snapshot.data!.city,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  color: Colors.grey)),
                                        ),
                                        ListTile(
                                          title: const Text('Zip',
                                              style: TextStyle(
                                                color: const Color(0xff79ADDC),
                                              )),
                                          subtitle: Text(snapshot.data!.zip,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  color: Colors.grey)),
                                        ),
                                      ],
                                    ),
                                  )
                                ]),
                          )),
                    )
                  ],
                ));
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
