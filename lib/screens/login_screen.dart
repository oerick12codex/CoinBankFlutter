import 'package:coinbank/models/user.dart';
import 'package:coinbank/service/api_login.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController userController =
      TextEditingController();

  final TextEditingController passController =
      TextEditingController();

  @override
  void dispose() {
    userController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),

          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                const Icon(
                  Icons.account_balance,
                  size: 80,
                  color: Color.fromARGB(255, 8, 56, 28),
                ),

                const SizedBox(height: 15),

                const Text(
                  "CoinBank",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 8, 56, 28),
                  ),
                ),

                const SizedBox(height: 40),

                TextField(
                  controller: userController,
                  decoration: InputDecoration(
                    labelText: "Usuário",
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                TextField(
                  controller: passController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Senha",
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 50,

                  child: ElevatedButton(

                    onPressed: () async {

                      final sucesso = await login(
                        email: userController.text,
                        senha: passController.text,
                      );

                      if (sucesso) {

                        final user = User(
                          nome: userController.text,
                          email: userController.text,
                          senha: passController.text,
                        );

                        Navigator.pushReplacementNamed(
                          context,
                          '/home',
                          arguments: user,
                        );

                      } else {

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Login inválido"),
                          ),
                        );

                      }
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 8, 56, 28),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),

                    child: const Text(
                      "Entrar",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}