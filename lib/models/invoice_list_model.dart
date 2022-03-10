// To parse this JSON data, do
//
//     final invoiceList = invoiceListFromJson(jsonString);

import 'dart:convert';

List<InvoiceList> invoiceListFromJson(String str) => List<InvoiceList>.from(
    json.decode(str).map((x) => InvoiceList.fromJson(x)));

String invoiceListToJson(List<InvoiceList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InvoiceList {
  InvoiceList({
    required this.date,
    required this.invnum,
    required this.service,
    required this.managername,
    required this.price,
    required this.expiration,
  });

  DateTime date;
  String invnum;
  String service;
  String managername;
  String price;
  DateTime expiration;

  factory InvoiceList.fromJson(Map<String, dynamic> json) => InvoiceList(
        date: DateTime.parse(json["date"]),
        invnum: json["invnum"],
        service: json["service"],
        managername: json["managername"],
        price: json["price"],
        expiration: DateTime.parse(json["expiration"]),
      );

  Map<String, dynamic> toJson() => {
        "date": date.toIso8601String(),
        "invnum": invnum,
        "service": service,
        "managername": managername,
        "price": price,
        "expiration":
            "${expiration.year.toString().padLeft(4, '0')}-${expiration.month.toString().padLeft(2, '0')}-${expiration.day.toString().padLeft(2, '0')}",
      };
}
