// lib/apresentacao/screens/transferencia_screen.dart
import 'package:flutter/material.dart';
import '../../data/models/user.dart';
import '../controllers/transferencia_controller.dart';

class TransferenciaScreen extends StatefulWidget {
  const TransferenciaScreen({super.key});

  @override
  State<TransferenciaScreen> createState() => _TransferenciaScreenState();
}

class _TransferenciaScreenState extends State<TransferenciaScreen> {
  final TextEditingController _pixController = TextEditingController();
  final TextEditingController _valorController = TextEditingController();
  final TransferenciaController _transferController = TransferenciaController();

  @override
  void dispose() {
    _pixController.dispose();
    _valorController.dispose();
    _transferController.dispose();
    super.dispose();
  }

  void _executarTransferencia(User userLogado) async {
    final double valorDigitado = double.tryParse(_valorController.text) ?? 0.0;

    final sucesso = await _transferController.transferir(
      remetente: userLogado,
      chavePixDestino: _pixController.text,
      valor: valorDigitado,
    );

    if (sucesso && mounted) {
      // Alerta de sucesso!
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Transferência realizada com sucesso!"),
          backgroundColor: Colors.green,
        ),
      );
      // Volta para a HomeScreen. Lembra do .then((_) => setState(() {})) que tens lá?
      // O saldo vai atualizar na hora!
      Navigator.pop(context); 
    } else if (_transferController.errorMessage != null && mounted) {
      // Exibe os erros gerados pelo Validator ou pelo Firebase
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_transferController.errorMessage!),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Captura o usuário logado vindo da HomeScreen
    final User userLogado = ModalRoute.of(context)!.settings.arguments as User;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Enviar Pix"),
        backgroundColor: const Color.fromARGB(255, 8, 56, 28),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Campo Chave Pix
            TextField(
              controller: _pixController,
              decoration: InputDecoration(
                labelText: "Chave Pix do Destinatário",
                prefixIcon: const Icon(Icons.vpn_key),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 20),

            // Campo Valor
            TextField(
              controller: _valorController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: "Valor (R\$)",
                prefixIcon: const Icon(Icons.monetization_on),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 30),

            // Botão reativo ao loading do controller
            ListenableBuilder(
              listenable: _transferController,
              builder: (context, child) {
                return SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _transferController.isLoading 
                        ? null 
                        : () => _executarTransferencia(userLogado),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 8, 56, 28),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: _transferController.isLoading
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                          )
                        : const Text(
                            "Confirmar Pix",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}