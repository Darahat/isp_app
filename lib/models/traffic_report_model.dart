// To parse this JSON data, do
//
//     final trafficReport = trafficReportFromJson(jsonString);

import 'dart:convert';

List<TrafficReport> trafficReportFromJson(String str) =>
    List<TrafficReport>.from(
        json.decode(str).map((x) => TrafficReport.fromJson(x)));

String trafficReportToJson(List<TrafficReport> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TrafficReport {
  TrafficReport({
    required this.ip,
    required this.mac,
    required this.acctstarttime,
    required this.acctstoptime,
    required this.upload,
    required this.download,
    required this.nasipaddress,
  });

  String ip;
  String mac;
  String? acctstarttime;
  String? acctstoptime;
  int upload;
  int download;
  String nasipaddress;

  factory TrafficReport.fromJson(Map<String, dynamic> json) => TrafficReport(
        ip: json["ip"],
        mac: json["mac"],
        acctstarttime: json["acctstarttime"],
        acctstoptime: json["acctstoptime"],
        upload: json["upload"],
        download: json["download"],
        nasipaddress: json["nasipaddress"],
      );

  Map<String, dynamic> toJson() => {
        "ip": ip,
        "mac": mac,
        "acctstarttime": acctstarttime,
        "acctstoptime": acctstoptime,
        "upload": upload,
        "download": download,
        "nasipaddress": nasipaddress,
      };
}
