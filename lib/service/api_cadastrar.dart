import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> cadastrar() async {
  final url = Uri.parse('http://10.0.2.2:8080/auth/register');

  final body = {
    "nome": "João",
    "email": "joao@email.com",
    "senha": "123456"
  };

  final response = await http.post(
    url,
    headers: {
      "Content-Type": "application/json",
    },
    body: jsonEncode(body),
  );

  print(response.statusCode);
  print(response.body);
}