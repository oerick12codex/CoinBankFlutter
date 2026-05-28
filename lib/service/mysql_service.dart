import 'package:mysql_client/mysql_client.dart';

class MySQLService {

  Future<MySQLConnection> conectar() async {

    final conn = await MySQLConnection.createConnection(
      host: "zephyr.proxy.rlwy.net",
      port: 29269,
      userName: "root",
      password: "xzMlbtDLWdMYsEdRJQEiPpkCugymImRP",
      databaseName: "dbcontausuario",
    );

    await conn.connect();

    print("Conectado ao MySQL");

    return conn;
  }

  Future<bool> login({
    required String email,
    required String senha,
  }) async {

    final conn = await conectar();

    var result = await conn.execute(
      """
      SELECT * FROM contausuario
      WHERE email = :email
      AND senha = :senha
      """,
      {
        "email": email,
        "senha": senha,
      },
    );

    await conn.close();

    return result.rows.isNotEmpty;
  }

  Future<void> cadastrar({
    required String nome,
    required String email,
    required String senha,
  }) async {

    final conn = await conectar();

    await conn.execute(
      """
      INSERT INTO users(nome, email, senha)
      VALUES(:nome, :email, :senha)
      """,
      {
        "nome": nome,
        "email": email,
        "senha": senha,
      },
    );

    await conn.close();

    print("Usuário cadastrado");
  }
}