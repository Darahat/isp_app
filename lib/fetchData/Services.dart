import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:isp/models/live_traffic_model.dart';
import 'package:isp/models/user_model.dart';
import 'package:isp/models/traffic_report_model.dart';
import 'package:isp/models/invoice_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Services {
  FormData formData = FormData.fromMap({"user": "ictsohel"});

  static Future<Customer> fetchCustomer() async {
    final prefs = await SharedPreferences.getInstance();
    final String? username = prefs.getString('username');
    String userurl = 'http://api.aniknetwork.net/user/$username';

    try {
      final response = await http.get(Uri.parse(userurl));
      if (response.statusCode == 200) {
        final Customer customers = customerFromJson(response.body);
        return customers;
      } else {
        throw Exception('Failed to load user');
      }
    } catch (e) {
      throw Exception('Failed to load user from try');
    }
  }

  static Future<Customer> authUser(username, password) async {
    String authurl = 'http://api.aniknetwork.net/user/$username';
    try {
      final response = await http.get(Uri.parse(authurl));

      if (response.statusCode == 200) {
        // Obtain shared preferences.
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedin', true);
        final Customer customers = customerFromJson(response.body);

        var passutf = utf8.encode(password);
        var digest2 = md5.convert(passutf).toString();
        var apipass = customers.password.toString();

        if (customers.username == username && apipass == digest2) {
          await prefs.setString('username', customers.username);
          return customers;
        } else {
          return throw Exception('Authentication Failed');
        }
      } else {
        throw Exception('Failed to load user');
      }
    } catch (e) {
      throw Exception('Failed to load user from try');
    }
  }

  static Future<List<TrafficReport>> fetchTrafficReport() async {
    final prefs = await SharedPreferences.getInstance();
    final String? username = prefs.getString('username');
    print(username);
    String trafficReporturl =
        'http://api.aniknetwork.net/traffic_report/$username';
    try {
      var response = await get(Uri.parse(trafficReporturl));

      if (response.statusCode == 200) {
        List jsonResponse = jsonDecode(response.body);
        return jsonResponse.map((job) => TrafficReport.fromJson(job)).toList();
      } else {
        throw Exception('Failed to load Traffic Report ');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<List<InvoiceList>> fetchInvoiceList() async {
    final prefs = await SharedPreferences.getInstance();
    final String? username = prefs.getString('username');
    String invoiceurl = "https://api.aniknetwork.net/list_invoice/$username";
    try {
      var response = await get(Uri.parse(invoiceurl));

      if (response.statusCode == 200) {
        List jsonResponse = jsonDecode(response.body);
        return jsonResponse.map((job) => InvoiceList.fromJson(job)).toList();
      } else {
        throw Exception('Failed to load Invoice List ');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<List<LiveTraffic>> fetchTrafficLiveReport() async {
    final prefs = await SharedPreferences.getInstance();
    final String? username = prefs.getString('username');
    String LiveTrafficurl =
        'https://api.aniknetwork.net/live_traffic/$username';
    try {
      var response = await get(Uri.parse(LiveTrafficurl));

      if (response.statusCode == 200) {
        List jsonResponse = jsonDecode(response.body);
        return jsonResponse.map((job) => LiveTraffic.fromJson(job)).toList();
      } else {
        throw Exception('Failed to load Invoice List ');
      }
    } catch (e) {
      throw Exception('Failed to load user');
    }
  }
}
