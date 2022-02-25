import 'dart:async';

import 'package:flutter/material.dart';
import 'package:isp/fetchData/Services.dart';
import 'package:isp/screens/dashboard/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var formKey = GlobalKey<FormState>();
  var usernameCtrl = TextEditingController();
  var passwordCtrl = TextEditingController();
  // Toggles the password show status
  var username, password;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> handleSubmit() async {
    final prefs = await SharedPreferences.getInstance();

    if (formKey.currentState!.validate()) {
      // If the form is valid, display a Snackbar.
      formKey.currentState!.save();
      try {
        var req = await Services.authUser(username, password);
        final bool? isLoggedin = prefs.getBool('isLoggedin');
        print(isLoggedin);
        if (isLoggedin == true) {
          // Navigator.of(context).pop();
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (_) => const Home(
                    title: 'Dashboard',
                  )));
        } else {
          // Navigator.of(context).pop();
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (_) => const LoginPage(
                    title: 'Login',
                  )));
        }
      } on Exception catch (e) {
        print(e.toString());
      }

      // print("Name is : $username");
      // print("password is : $password");
    }
  }

// void PushError(){
//     Navigator.push(context, MaterialPageRoute(
//         builder: (context) => Error();
//     ));
// }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Center(
              child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 40.0),
                        child: const Text(
                          'Login Page',
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      Row(
                        children: const [
                          Image(
                              fit: BoxFit.contain,
                              height: 300.0,
                              width: 300.0,
                              image: AssetImage('assets/images/bg.png'))
                        ],
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 15, top: 5),
                                        child: TextFormField(
                                          controller: usernameCtrl,
                                          decoration: const InputDecoration(
                                              labelText: "Your Username"),
                                          validator: (value) {
                                            if (value!.isEmpty)
                                              return 'Username is required';
                                          },
                                          onSaved: (value) {
                                            username = value;
                                          },
                                        )))),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Stack(
                                alignment: const Alignment(0, 0),
                                children: <Widget>[
                                  Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15, right: 15, top: 5),
                                          child: TextFormField(
                                            controller: passwordCtrl,
                                            decoration: const InputDecoration(
                                                labelText: "Your Password"),
                                            validator: (value) {
                                              if (value!.isEmpty)
                                                return 'Password is required';
                                            },
                                            onSaved: (value) {
                                              password = value;
                                            },
                                            obscureText: true,
                                          ))),
                                ],
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(10),
                                child: SizedBox(
                                  height: 50,
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: const Color(0xff2BC992),
                                      onPrimary: Colors.white,
                                      onSurface: Colors.grey,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                    ),
                                    onPressed: () {
                                      // Validate returns true if the form is valid, or false
                                      // otherwise.
                                      handleSubmit();
                                    },
                                    child: const Text(
                                      'Submit',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      )
                    ],
                  )),
            )));
  }
}
