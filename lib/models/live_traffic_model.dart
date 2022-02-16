// To parse this JSON data, do
//
//     final liveTraffic = liveTrafficFromJson(jsonString);

import 'dart:convert';

List<LiveTraffic> liveTrafficFromJson(String str) => List<LiveTraffic>.from(
    json.decode(str).map((x) => LiveTraffic.fromJson(x)));

String liveTrafficToJson(List<LiveTraffic> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LiveTraffic {
  LiveTraffic({
    required this.name,
    required this.rxPacketsPerSecond,
    required this.rxBitsPerSecond,
    required this.fpRxPacketsPerSecond,
    required this.fpRxBitsPerSecond,
    required this.rxDropsPerSecond,
    required this.rxErrorsPerSecond,
    required this.txPacketsPerSecond,
    required this.txBitsPerSecond,
    required this.fpTxPacketsPerSecond,
    required this.fpTxBitsPerSecond,
    required this.txDropsPerSecond,
    required this.txQueueDropsPerSecond,
    required this.txErrorsPerSecond,
  });

  String name;
  String rxPacketsPerSecond;
  String rxBitsPerSecond;
  String fpRxPacketsPerSecond;
  String fpRxBitsPerSecond;
  String rxDropsPerSecond;
  String rxErrorsPerSecond;
  String txPacketsPerSecond;
  String txBitsPerSecond;
  String fpTxPacketsPerSecond;
  String fpTxBitsPerSecond;
  String txDropsPerSecond;
  String txQueueDropsPerSecond;
  String txErrorsPerSecond;

  factory LiveTraffic.fromJson(Map<String, dynamic> json) => LiveTraffic(
        name: json["name"],
        rxPacketsPerSecond: json["rx-packets-per-second"],
        rxBitsPerSecond: json["rx-bits-per-second"],
        fpRxPacketsPerSecond: json["fp-rx-packets-per-second"],
        fpRxBitsPerSecond: json["fp-rx-bits-per-second"],
        rxDropsPerSecond: json["rx-drops-per-second"],
        rxErrorsPerSecond: json["rx-errors-per-second"],
        txPacketsPerSecond: json["tx-packets-per-second"],
        txBitsPerSecond: json["tx-bits-per-second"],
        fpTxPacketsPerSecond: json["fp-tx-packets-per-second"],
        fpTxBitsPerSecond: json["fp-tx-bits-per-second"],
        txDropsPerSecond: json["tx-drops-per-second"],
        txQueueDropsPerSecond: json["tx-queue-drops-per-second"],
        txErrorsPerSecond: json["tx-errors-per-second"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "rx-packets-per-second": rxPacketsPerSecond,
        "rx-bits-per-second": rxBitsPerSecond,
        "fp-rx-packets-per-second": fpRxPacketsPerSecond,
        "fp-rx-bits-per-second": fpRxBitsPerSecond,
        "rx-drops-per-second": rxDropsPerSecond,
        "rx-errors-per-second": rxErrorsPerSecond,
        "tx-packets-per-second": txPacketsPerSecond,
        "tx-bits-per-second": txBitsPerSecond,
        "fp-tx-packets-per-second": fpTxPacketsPerSecond,
        "fp-tx-bits-per-second": fpTxBitsPerSecond,
        "tx-drops-per-second": txDropsPerSecond,
        "tx-queue-drops-per-second": txQueueDropsPerSecond,
        "tx-errors-per-second": txErrorsPerSecond,
      };
}
