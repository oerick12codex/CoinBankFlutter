// lib/presentation/screens/cotacao_screen.dart
import 'package:flutter/material.dart';
import '../controllers/cotacao_controller.dart';

class CotacaoScreen extends StatefulWidget {
  const CotacaoScreen({super.key});

  @override
  State<CotacaoScreen> createState() => _CotacaoScreenState();
}

class _CotacaoScreenState extends State<CotacaoScreen> {
  // Instanciamos o controlador da tela
  final CotacaoController _controller = CotacaoController();

  @override
  void initState() {
    super.initState();
    // Dispara a busca automática assim que a tela abre
    _controller.buscarCotacoes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cotações de Moedas"),
        backgroundColor: const Color.fromARGB(255, 8, 56, 28),
        foregroundColor: Colors.white,
      ),
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, child) {
          // 1º Estado: Carregando dados da API
          if (_controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Color.fromARGB(255, 8, 56, 28)),
              ),
            );
          }

          // 2º Estado: Se aconteceu algum erro (ex: sem internet)
          if (_controller.errorMessage != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red, size: 48),
                    const SizedBox(height: 12),
                    Text(
                      _controller.errorMessage!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: _controller.buscarCotacoes,
                      icon: const Icon(Icons.refresh),
                      label: const Text("Tentar Novamente"),
                    )
                  ],
                ),
              ),
            );
          }

          final double valorDolar = _controller.moedas["USD"] ?? 0.00;
          final double valorEuro =  _controller.moedas["EUR"] ?? 0.00;

          final usd = valorDolar.toStringAsFixed(2);
          final eur = valorEuro.toStringAsFixed(2);

          return RefreshIndicator(
            onRefresh: _controller.buscarCotacoes, // Permite puxar a tela para atualizar
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: const Icon(Icons.attach_money, color: Colors.green, size: 36),
                    title: const Text("Dólar Comercial (USD)"),
                    trailing: Text(
                      "R\$ $usd",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: const Icon(Icons.euro, color: Colors.blue, size: 36),
                    title: const Text("Euro (EUR)"),
                    trailing: Text(
                      "R\$ $eur",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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