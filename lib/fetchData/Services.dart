import 'package:http/http.dart' as http;
import 'package:isp/models/user_model.dart';

class Services {
  static const String url = 'http://api.aniknetwork.net/user/ictsohel';

  static Future<Customer> fetchCustomer() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Customer customers = customerFromJson(response.body);
        return customers;
      } else {
        throw Exception('Failed to load album');
      }
    } catch (e) {
      throw Exception('Failed to load album from try');
    }
  }
}
