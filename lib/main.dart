import 'package:flutter/material.dart';
import 'apresentacao/screens/cotacao_screen.dart';
import 'apresentacao/screens/home_screen.dart';
import 'apresentacao/screens/login_screen.dart';
import 'apresentacao/screens/transferencia_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';




void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  
  int usar = 2;
  if (kIsWeb && usar == 1) {
    // Inicialização para rodar no Chrome (Insira os dados que você copiou do site)
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyC0AidzSu36pfm6CohOEuvjCGsmLuuvVGM",
        authDomain: "coinbank-17e65.firebaseapp.com",
        projectId: "coinbank-17e65",
        storageBucket: "coinbank-17e65.firebasestorage.app",
        messagingSenderId: "139568511141",
        appId: "1:139568511141:web:b359d1016eb795c349b54cf",
      ),
    );
  } else {
    // Mantém a inicialização padrão para quando você arrumar um cabo de dados
    await Firebase.initializeApp();
  }

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