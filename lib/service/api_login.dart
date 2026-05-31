import 'mysql_service.dart';

final mysql = MySQLService();

Future<bool> login({
  required String email,
  required String senha,
}) async {

  try {

    final sucesso = await mysql.login(
      email: email,
      senha: senha,
    );

    return sucesso;

  } catch (e) {

    print("Erro no login: $e");

    return false;
  }
}