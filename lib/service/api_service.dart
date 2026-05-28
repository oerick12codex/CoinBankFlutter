import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<Map<String, double>> getCurrencies() async {
    final response = await http.get(
      Uri.parse("https://economia.awesomeapi.com.br/json/last/USD-BRL,EUR-BRL"),
    );

    final data = json.decode(response.body);

    return {
      "USD": double.parse(data["USDBRL"]["bid"]),
      "EUR": double.parse(data["EURBRL"]["bid"]),
    };
  }
}