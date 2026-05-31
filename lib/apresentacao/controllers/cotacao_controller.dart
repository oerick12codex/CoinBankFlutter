import 'package:flutter/material.dart';
import '../../data/service/api_service.dart';

class CotacaoController extends ChangeNotifier {
  Map<String, double> _moedas= {};
  bool _isLoading = false;
  String? _errorMessage;

  //getters
  Map<String, double> get moedas => _moedas;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> buscarCotacoes() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _moedas = await ApiService.getCurrencies();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}