import 'package:flutter/material.dart';
import '../models/user.dart';

class TransferenciaScreen extends StatefulWidget {
  const TransferenciaScreen({super.key});

  @override
  State<TransferenciaScreen> createState() => _TransferenciaScreenState();
}

class _TransferenciaScreenState extends State<TransferenciaScreen> {
  final TextEditingController valorController = TextEditingController();

  void realizarTransferencia(User user) {
    double valor = double.tryParse(valorController.text) ?? 0;

    if (valor <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Digite um valor válido"),
        ),
      );
      return;
    }

    if (valor > user.balance) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Saldo insuficiente"),
        ),
      );
      return;
    }

    setState(() {
      user.balance -= valor;
    });

    valorController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Transferência de R\$ $valor realizada com sucesso!"),
      ),
    );
  }

  @override
  void dispose() {
    valorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context)!.settings.arguments as User;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Transferência"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "Usuário: ${user.nome}",
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 10),

            Text(
              "Saldo: R\$ ${user.balance.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            TextField(
              controller: valorController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Valor da transferência",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => realizarTransferencia(user),
                child: const Text("Transferir"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}