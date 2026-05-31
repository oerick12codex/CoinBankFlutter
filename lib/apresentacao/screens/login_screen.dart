// lib/presentation/screens/login_screen.dart
import 'package:flutter/material.dart';
import '../controllers/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  
  // Instanciamos o controlador da tela
  final LoginController _controller = LoginController();

  @override
  void dispose() {
    userController.dispose();
    passController.dispose();
    super.dispose();
  }

  void _tentarLogar() async {
    final usuarioAutenticado = await _controller.login(
      userController.text,
      passController.text,
    );

    // Se o login falhar e houver mensagem de erro, exibe o SnackBar
    if (usuarioAutenticado == null && _controller.errorMessage != null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_controller.errorMessage!),
          backgroundColor: Colors.redAccent,
        ),
      );
    } 
    // Se der sucesso, navega para a Home passando o User correto
    else if (usuarioAutenticado != null) {
      if (!mounted) return;
      Navigator.pushReplacementNamed(
        context,
        '/home',
        arguments: usuarioAutenticado,
      );
    }
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
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email",
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
                
                // Monitora o estado de Loading do controlador
                ListenableBuilder(
                  listenable: _controller,
                  builder: (context, child) {
                    return SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        // Se estiver carregando, desabilita cliques adicionais no botão
                        onPressed: _controller.isLoading ? null : _tentarLogar,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 8, 56, 28),
                          disabledBackgroundColor: const Color.fromARGB(100, 8, 56, 28),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: _controller.isLoading
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : const Text(
                                "Entrar",
                                style: TextStyle(fontSize: 18, color: Colors.white),
                              ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}