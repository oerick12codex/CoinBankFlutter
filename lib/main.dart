import 'package:flutter/material.dart';
import 'apresentacao/screens/login_screen.dart';
import 'screens/cotacao_screen.dart';
import 'screens/transferencia_screen.dart';
import 'screens/home_screen.dart';


void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/cotacao': (context) => const CotacaoScreen(),
        '/transferencia': (context) => const TransferenciaScreen(),
      },
      debugShowCheckedModeBanner: false,
      title: 'CoinBank',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 8, 56, 28),
        ),
      ),
    );
  }
}