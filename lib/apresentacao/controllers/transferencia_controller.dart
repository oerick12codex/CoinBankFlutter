import 'package:flutter/foundation.dart';
import '../../domain/transfer_validator.dart';
import '../../data/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TransferenciaController extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  bool _success = false;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get success => _success;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> transferir({
    required User remetente,
    required String chavePixDestino,
    required double valor,
  }) async {
    _errorMessage = null;
    _success = false;

    final erroValidacao = TransferValidator.validar(
      valor: valor,
      valorAtual: remetente.saldo,
      chavePixDestino: chavePixDestino,
    );

    if (erroValidacao != null) {
      _errorMessage = erroValidacao;
      notifyListeners();
      return false;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final String chaveTratada = chavePixDestino.trim().toLowerCase();

      final consultarDestino = await _firestore
          .collection('usuarios')
          .where('chave-pix', isEqualTo: chaveTratada)
          .limit(1)
          .get();

      if (consultarDestino.docs.isEmpty) {
        throw Exception("Chave Pix de destino não encontrada.");
      }

      final docDestino = consultarDestino.docs.first;
      final String idDestino = docDestino.id;
      final double saldoDestino =(docDestino.data()['saldo'] as num?)?.toDouble() ?? 0.0;

      await _firestore.runTransaction((transaction) async {
        final DocumentReference refRemetente = _firestore
            .collection('usuarios')
            .doc(remetente.id);
        final DocumentReference refDestino = _firestore
            .collection('usuarios')
            .doc(idDestino);

        final novoSaldoRemetente = remetente.saldo - valor;
        final novoSaldoDestino = saldoDestino + valor;

        transaction.update(refRemetente, {'saldo': novoSaldoRemetente});
        transaction.update(refDestino, {'saldo': novoSaldoDestino});

        remetente.saldo = novoSaldoRemetente;
      });

      _success = true;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      notifyListeners();
      return false;
    }
  }
}
