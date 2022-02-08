// To parse this JSON data, do
//
//     final customer = customerFromJson(jsonString);

import 'dart:convert';

Customer customerFromJson(String str) => Customer.fromJson(json.decode(str));

String customerToJson(Customer data) => json.encode(data.toJson());

class Customer {
  Customer({
    required this.username,
    required this.password,
    required this.enableuser,
    required this.firstname,
    required this.lastname,
    required this.mobile,
    required this.address,
    required this.city,
    required this.zip,
    required this.country,
    required this.mac,
    required this.expiration,
    required this.createdon,
    required this.email,
    required this.srvname,
    required this.unitprice,
  });

  String username;
  String password;
  int enableuser;
  String firstname;
  String lastname;
  String mobile;
  String address;
  String city;
  String zip;
  String country;
  String mac;
  DateTime expiration;
  DateTime createdon;
  String email;
  String srvname;
  String unitprice;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        username: json["username"],
        password: json["password"],
        enableuser: json["enableuser"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        mobile: json["mobile"],
        address: json["address"],
        city: json["city"],
        zip: json["zip"],
        country: json["country"],
        mac: json["mac"],
        expiration: DateTime.parse(json["expiration"]),
        createdon: DateTime.parse(json["createdon"]),
        email: json["email"],
        srvname: json["srvname"],
        unitprice: json["unitprice"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "enableuser": enableuser,
        "firstname": firstname,
        "lastname": lastname,
        "mobile": mobile,
        "address": address,
        "city": city,
        "zip": zip,
        "country": country,
        "mac": mac,
        "expiration": expiration.toIso8601String(),
        "createdon":
            "${createdon.year.toString().padLeft(4, '0')}-${createdon.month.toString().padLeft(2, '0')}-${createdon.day.toString().padLeft(2, '0')}",
        "email": email,
        "srvname": srvname,
        "unitprice": unitprice,
      };
}
