import 'package:flutter/material.dart';
import 'package:isp/fetchData/Services.dart';
import 'package:isp/models/user_model.dart';

class NavigationDrawerWidget extends StatefulWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  late Future<Customer> futureCustomer;
  @override
  void initState() {
    super.initState();
    futureCustomer = Services.fetchCustomer();
  }

  final padding = const EdgeInsets.symmetric(horizontal: 20.0);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.green,
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
          FutureBuilder<Customer>(
            future: futureCustomer,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // ignore: dead_code
                return UserAccountsDrawerHeader(
                  accountName: Text(
                      '${snapshot.data!.firstname} ${snapshot.data!.firstname}'),
                  accountEmail: Text(snapshot.data!.email),
                  currentAccountPicture: CircleAvatar(
                    child: ClipOval(
                      child: Image.network(
                        'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
                        fit: BoxFit.cover,
                        width: 90,
                        height: 90,
                      ),
                    ),
                  ),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
                  ),
                );
              } else {
                return UserAccountsDrawerHeader(
                  accountName: const Text('Guest'),
                  accountEmail: const Text('Guest'),
                  currentAccountPicture: CircleAvatar(
                    child: ClipOval(
                      child: Image.network(
                        'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
                        fit: BoxFit.cover,
                        width: 90,
                        height: 90,
                      ),
                    ),
                  ),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
                  ),
                );
              }
            },
          ),
          InkWell(
            child: buildMenuItem(
                text: 'Dashboard',
                icon: Icons.dashboard,
                onClicked: () => Navigator.pushNamed(context, '/')),
          ),
          const Divider(),
          InkWell(
            child: buildMenuItem(
              text: 'Traffic Report',
              icon: Icons.traffic,
            ),
            onTap: () {
              Navigator.of(context).pushNamed('/traffic_report');
            },
          ),
          InkWell(
            child: buildMenuItem(
              text: 'User Live Traffic',
              icon: Icons.auto_graph,
            ),
            onTap: () {
              Navigator.of(context).pushNamed('/live_traffic');
            },
          ),
          const Divider(),
          InkWell(
            child: buildMenuItem(
              text: 'List Invoice',
              icon: Icons.description_outlined,
            ),
            onTap: () {
              Navigator.of(context).pushNamed('/list_invoice');
            },
          ),
          InkWell(
            child: buildMenuItem(
              text: 'Payment',
              icon: Icons.payment,
            ),
            onTap: () {
              Navigator.of(context).pushNamed('/payment');
            },
          ),
          InkWell(
            child: buildMenuItem(
              text: 'How to Pay',
              icon: Icons.info,
            ),
            onTap: () {
              Navigator.of(context).pushNamed('/how_to_pay');
            },
          ),
          const Divider(),
          InkWell(
            child: buildMenuItem(
              text: 'Complain',
              icon: Icons.headset_mic,
            ),
            onTap: () {
              Navigator.of(context).pushNamed('/complain');
            },
          ),
          const Divider(),
        ]),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const color = Colors.white;
    const hoverColor = Colors.white70;
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: const TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }
}
