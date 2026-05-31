import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _url = "https://economia.awesomeapi.com.br/json/last/USD-BRL,EUR-BRL";

  static Future<Map<String, double>> getCurrencies() async {
    try {
      final response = await http.get(Uri.parse(_url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {
          "USD": double.parse(data["USDBRL"]["bid"]),
          "EUR": double.parse(data["EURBRL"]["bid"]),
        };
      } else {
        throw Exception("Falha ao carregar as cotações do servidor.");
      }
    } catch (e) {
      // Captura falta de internet ou qualquer outro erro de rede
      throw Exception("Erro de conexão. Verifique sua internet.");
    }
  }
}