import 'package:flutter/material.dart';
import 'package:isp/widgets/navigation_drawer_widget.dart';
import 'package:isp/fetchData/Services.dart';

class TrafficReport extends StatefulWidget {
  const TrafficReport({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<TrafficReport> createState() => _TrafficReportState();
}

class _TrafficReportState extends State<TrafficReport> {
  late Future<List<TrafficReport>> futureTrafficReport;
  TextEditingController controller = TextEditingController();
  List usersFiltered = [];
  String _searchResult = '';
  Services services = Services();

  var d;
  @override
  void initState() {
    super.initState();
    Services.fetchTrafficReport().then((trafficReportFromServer) {
      setState(() {
        usersFiltered = trafficReportFromServer;
      });
    });
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
                  style: const TextStyle(
                    color: Color(0xff2BC992),
                  )),
              iconTheme: const IconThemeData(
                color: Color(0xff2BC992),
              ),
            ),
            body: FutureBuilder(
                future: Services.fetchTrafficReport(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    List trafficReport = snapshot.data;

                    // usersFiltered = trafficReport;
                    return ListView(
                      children: <Widget>[
                        Card(
                          child: ListTile(
                            leading: const Icon(Icons.search),
                            title: TextField(
                                controller: controller,
                                decoration: const InputDecoration(
                                    hintText: 'Search',
                                    border: InputBorder.none),
                                onChanged: (value) {
                                  setState(() {
                                    _searchResult = value;
                                    usersFiltered = trafficReport
                                        .where((traffic) =>
                                            traffic.acctstarttime
                                                .contains(_searchResult) ||
                                            traffic.ip.contains(_searchResult))
                                        .toList();
                                  });
                                }),
                            trailing: IconButton(
                              icon: const Icon(Icons.cancel),
                              onPressed: () {
                                setState(() {
                                  controller.clear();
                                  _searchResult = '';
                                  usersFiltered = trafficReport;
                                });
                              },
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
                                    columns: const <DataColumn>[
                                      DataColumn(
                                        label: Text(
                                          'Date',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff79ADDC)),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Upload(Mbps)',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff79ADDC)),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Download(Mbps)',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff79ADDC)),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'IP',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff79ADDC)),
                                        ),
                                      ),
                                    ],
                                    rows: List.generate(
                                        usersFiltered.length,
                                        (index) => DataRow(cells: [
                                              DataCell(Text(
                                                  '${usersFiltered[index].acctstarttime}')),
                                              DataCell(Text(
                                                  '${(usersFiltered[index].upload / 1000000).toStringAsFixed(3)}')),
                                              DataCell(Text(
                                                  '${(usersFiltered[index].download / 1000000).toStringAsFixed(3)}')),
                                              DataCell(Text(
                                                  '${usersFiltered[index].ip}')),
                                            ])))))
                      ],
                    );
                  } else {
                    return const Center(
                      child: Text(
                        'Loading.....',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.grey),
                      ),
                    );
                  }
                })));
  }

  // Widget buildSearch() => SearchWidget(
  //       text: query,
  //       hintText: 'Search',
  //       onChanged: searchBook,
  //     );
  //   void searchDatatable(String query){
  //     final datas = Services.fetchTrafficReport().where((data){

  //     })

  //   }
}


//  ||
//                                         traffic.upload
//                                             .contains(_searchResult) ||
//                                         traffic.download
//                                             .contains(_searchResult)