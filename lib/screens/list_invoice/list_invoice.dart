import 'package:flutter/material.dart';
import 'package:isp/models/invoice_list_model.dart';
import 'package:isp/widgets/navigation_drawer_widget.dart';
import 'package:isp/fetchData/Services.dart';

class ListInvoice extends StatefulWidget {
  const ListInvoice({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<ListInvoice> createState() => _ListInvoiceState();
}

class _ListInvoiceState extends State<ListInvoice> {
  late Future<List<InvoiceList>> futureInvoiceList;
  TextEditingController controller = TextEditingController();
  List invoiceFiltered = [];
  String _searchResult = '';
  Services services = Services();

  var d;
  @override
  void initState() {
    super.initState();
    Services.fetchInvoiceList().then((invoiceListFromServer) {
      setState(() {
        invoiceFiltered = invoiceListFromServer;
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
                future: Services.fetchInvoiceList(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    List invoiceListReport = snapshot.data;
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
                                    invoiceFiltered = invoiceListReport
                                        .where((invoice) =>
                                            invoice.date
                                                .contains(_searchResult) ||
                                            invoice.invnum
                                                .contains(_searchResult))
                                        .toList();
                                  });
                                }),
                            trailing: IconButton(
                              icon: const Icon(Icons.cancel),
                              onPressed: () {
                                setState(() {
                                  controller.clear();
                                  _searchResult = '';
                                  invoiceFiltered = invoiceListReport;
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
                                              color: Colors.blue),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Invoice Number',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Package',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Created by',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Price(Tk)',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Expiration',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Action',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue),
                                        ),
                                      ),
                                    ],
                                    rows: List.generate(
                                        invoiceFiltered.length,
                                        (index) => DataRow(cells: [
                                              DataCell(Text(
                                                  '${invoiceFiltered[index].date}')),
                                              DataCell(Text(
                                                  '${invoiceFiltered[index].invnum}')),
                                              DataCell(Text(
                                                  '${invoiceFiltered[index].service}')),
                                              DataCell(Text(
                                                  '${invoiceFiltered[index].managername}')),
                                              DataCell(Text(
                                                  '${invoiceFiltered[index].price}')),
                                              DataCell(Text(
                                                  '${invoiceFiltered[index].expiration}')),
                                              DataCell(InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    width: 35,
                                                    height: 35,
                                                    decoration:
                                                        const ShapeDecoration(
                                                            shape:
                                                                CircleBorder(), //here we set the circular figure
                                                            color: Colors.blue),
                                                    child: const Center(
                                                        child: Icon(
                                                      Icons.preview,
                                                      size: 20,
                                                      color: Colors.white,
                                                    )),
                                                  ))),
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
}
