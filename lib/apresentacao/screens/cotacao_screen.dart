import 'package:flutter/material.dart';
import '../../service/api_service.dart';

class CotacaoScreen extends StatefulWidget {
  const CotacaoScreen({super.key});

  @override
  State<CotacaoScreen> createState() => _CotacaoScreenState();
}

class _CotacaoScreenState extends State<CotacaoScreen> {
  double? dolar;
  double? euro;

  @override
  void initState() {
    super.initState();
    carregarCotacoes();
  }

  void carregarCotacoes() async {
    final moedas = await ApiService.getCurrencies();

    setState(() {
      dolar = moedas["USD"];
      euro = moedas["EUR"];
    });
  }

  Widget buildCard({
    required String moeda,
    required double valor,
    required IconData icon,
  }) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),

      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Row(
          children: [
            Icon(
              icon,
              size: 40,
              color: Colors.green,
            ),

            const SizedBox(width: 20),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  moeda,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  "R\$ ${valor.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool carregando = dolar == null || euro == null;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cotação"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: carregando
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  const SizedBox(height: 20),

                  const Text(
                    "Cotações do Dia",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 30),

                  buildCard(
                    moeda: "Dólar (USD)",
                    valor: dolar!,
                    icon: Icons.attach_money,
                  ),

                  buildCard(
                    moeda: "Euro (EUR)",
                    valor: euro!,
                    icon: Icons.euro,
                  ),

                  const SizedBox(height: 30),

                  ElevatedButton.icon(
                    onPressed: carregarCotacoes,
                    icon: const Icon(Icons.refresh),
                    label: const Text("Atualizar"),
                  ),
                ],
              ),
      ),
    );
  }
}