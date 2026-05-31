// lib/presentation/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../../data/models/user.dart';
import '../controllers/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeController _controller;
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Captura o usuário enviado pela rota de login apenas uma vez
    if (!_isInitialized) {
      final User user = ModalRoute.of(context)!.settings.arguments as User;
      _controller = HomeController(user: user);
      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CoinBank"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 8, 56, 28),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, child) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                Text(
                  "Bem-vindo, ${_controller.nome}!",
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),

                // Card Saldo (Observando o estado de visibilidade)
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Saldo disponível",
                              style: TextStyle(fontSize: 18),
                            ),
                            IconButton(
                              onPressed: _controller.alternarVisibilidadeSaldo,
                              icon: Icon(
                                _controller.mostrarSaldo
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _controller.mostrarSaldo
                              ? "R\$ ${_controller.balance.toStringAsFixed(2)}"
                              : "••••••",
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Botão Cotação
                SizedBox(
                  height: 55,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/cotacao');
                    },
                    icon: const Icon(Icons.currency_exchange),
                    label: const Text(
                      "Ver Cotação",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Botão Transferência
                SizedBox(
                  height: 55,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/transferencia',
                        arguments: _controller.user,
                      ).then((_) {
                        // Quando voltar da tela, atualiza apenas quem ouve o controller
                        _controller.atualizarSaldo();
                      });
                    },
                    icon: const Icon(Icons.send),
                    label: const Text(
                      "Transferência",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}