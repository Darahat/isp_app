import 'dart:io';

import 'package:flutter/material.dart';
import 'package:isp/fetchData/Services.dart';
import 'package:isp/models/user_model.dart';
import 'package:isp/screens/dashboard/home.dart';
import 'package:isp/screens/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

class NavigationDrawerWidget extends StatefulWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  late Future<Customer> futureCustomer;
  Services service = Services();
  final _addFormKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  late File _image;
  final picker = ImagePicker();
  getId() async {
    final prefs = await SharedPreferences.getInstance();
    final String? username = prefs.getString('username');
    final String? email = prefs.getString('email');
  }

  Widget _buildImage() {
    if (_image == null) {
      return const Padding(
        padding: EdgeInsets.fromLTRB(1, 1, 1, 1),
        child: Icon(
          Icons.add,
          color: Colors.grey,
        ),
      );
    } else {
      return Text(_image.path);
    }
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    futureCustomer = Services.fetchCustomer();
  }

  final padding = const EdgeInsets.symmetric(horizontal: 20.0);
  @override
  Widget build(BuildContext context) {
    String username2 = '';
    String email = '';
    // try {
    //   getId().then((username, email) {
    //     username2 = username;
    //     email = email;
    //   });
    //   print(email);
    // } catch (e) {
    //   throw Exception("Failed to load user information");
    // }
    return Drawer(
      child: Material(
        color: Color.fromARGB(255, 252, 90, 2),
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
          FutureBuilder<Customer>(
            future: futureCustomer,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // ignore: dead_code
                return UserAccountsDrawerHeader(
                  accountName: Text(
                      '${snapshot.data!.firstname} ${snapshot.data!.lastname}',
                      style: const TextStyle(color: Colors.black)),
                  accountEmail: Text(
                    snapshot.data!.email,
                    style: const TextStyle(color: Colors.black),
                  ),
                  currentAccountPicture: CircleAvatar(
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/avatar.png',
                        fit: BoxFit.cover,
                        width: 110,
                        height: 110,
                      ),
                    ),
                  ),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/profilebg.png')),
                  ),
                );
              } else {
                return UserAccountsDrawerHeader(
                  accountName: const Text('Guest'),
                  accountEmail: const Text('Guest'),
                  currentAccountPicture: CircleAvatar(
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/avatar.png',
                        fit: BoxFit.cover,
                        width: 110,
                        height: 110,
                      ),
                    ),
                  ),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/profilebg.png')),
                  ),
                );
              }
            },
          ),
          InkWell(
            child: buildMenuItem(
                text: 'Dashboard',
                icon: Icons.dashboard,
                onClicked: () => Navigator.pushNamed(context, '/home')),
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
          InkWell(
            child: buildMenuItem(
              text: 'Logout',
              icon: Icons.logout,
            ),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool('isLoggedin', false);
              final bool? isLoggedin = prefs.getBool('isLoggedin');
              if (isLoggedin == true) {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (_) => const Home(
                          title: 'Dashboard',
                        )));
              } else {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (_) => const LoginPage(
                          title: 'Login',
                        )));
              }
            },
          ),
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
