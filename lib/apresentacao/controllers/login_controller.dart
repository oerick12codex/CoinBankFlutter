// lib/apresentacao/controllers/login_controller.dart
import 'package:flutter/foundation.dart';
import '../../data/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class LoginController extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<User?> login(String email, String senha) async {
    // 1. Validações iniciais de campo
    if (email.isEmpty || senha.isEmpty) {
      _errorMessage = "Por favor, preencha todos os campos.";
      notifyListeners();
      return null;
    }

    if (!email.contains("@")) {
      _errorMessage = "Por favor, insira um email válido.";
      notifyListeners();
      return null;
    }

    // 2. Ativa o loading na tela
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // 3. Busca o usuário diretamente na nuvem do Firebase
      final resultado = await FirebaseFirestore.instance
          .collection('usuarios')
          .where('email', isEqualTo: email.trim()) // .trim() remove espaços acidentais
          .limit(1)
          .get();

      // Se o email não existir no Firebase
      if (resultado.docs.isEmpty) {
        _errorMessage = "Usuário não cadastrado.";
        _isLoading = false;
        notifyListeners();
        return null;
      }

      // 4. Captura os dados do documento encontrado
      final snapshot = resultado.docs.first;
      final dadosUsuario = snapshot.data();
      
      String senhaDoServidor = dadosUsuario['senha']?? '';

      // 5. Verifica se a senha bate
      if (senhaDoServidor != senha) {
        _errorMessage = "Senha incorreta.";
        _isLoading = false;
        notifyListeners();
        return null;
      }

      // 6. Login feito com sucesso! 
      User usuarioLogado = User(
        id: snapshot.id,
        nome: dadosUsuario['nome'] ?? '',
        email: dadosUsuario['email'] ?? '',
        chavePix: dadosUsuario['chave-pix'] ?? '',
        saldo: (dadosUsuario['saldo'] as num?)?.toDouble() ?? 0.0,
        senha: senhaDoServidor,
      );

      print("Sucesso! ${usuarioLogado.nome} entrou no CoinBank.");

      _isLoading = false;
      notifyListeners();
      return usuarioLogado; // Retorna o usuário pronto para a tela usar!

    } catch (e) {
      print("Erro no Firebase: $e");
      _errorMessage = "Erro de conexão com o servidor. Tente novamente.";
      _isLoading = false;
      notifyListeners();
      return null;
    }
  }
}
