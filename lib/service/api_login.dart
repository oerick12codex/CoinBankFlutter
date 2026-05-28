import 'dart:convert';
import 'package:http/http.dart' as http;

Future<bool> login({
  required String email,
  required String senha,
}) async {

  final url = Uri.parse(
    'https://servidor-usuario.up.railway.app/contausuario/login',
  );

  final body = {
    "email": email,
    "senha": senha,
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

  return response.statusCode == 200;
}