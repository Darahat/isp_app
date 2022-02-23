import 'package:flutter/material.dart';
import 'package:isp/screens/complain/complain.dart';
import 'package:isp/screens/dashboard/home.dart';
import 'package:isp/screens/how_to_pay/how_to_pay.dart';
import 'package:isp/screens/list_invoice/list_invoice.dart';
import 'package:isp/screens/live_traffic/live_traffic.dart';
import 'package:isp/screens/login/login.dart';
import 'package:isp/screens/payment/payment.dart';
import 'package:isp/screens/traffic_report/traffic_report.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => const Home(
                  title: 'Dashboard',
                ));
      case '/traffic_report':
        return MaterialPageRoute(
            builder: (_) => const TrafficReport(title: 'Traffic Report'));
      case '/login':
        return MaterialPageRoute(
            builder: (_) => const LoginPage(title: 'Login'));
      case '/live_traffic':
        return MaterialPageRoute(
            builder: (_) => const LiveTraffic(title: 'User Live Traffic'));
      case '/list_invoice':
        return MaterialPageRoute(
            builder: (_) => const ListInvoice(title: 'List Invoice'));
      case '/payment':
        return MaterialPageRoute(
            builder: (_) => const Payment(title: 'Payment'));
      case '/how_to_pay':
        return MaterialPageRoute(
            builder: (_) => const HowToPay(title: 'How To Pay'));
      case '/complain':
        return MaterialPageRoute(
            builder: (_) => const Complain(title: 'Complain'));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
