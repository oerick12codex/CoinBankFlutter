import 'package:flutter/material.dart';
import '../../data/models/user.dart';

class HomeController extends ChangeNotifier {
  final User user;
  bool _mostrarSaldo = true;

  HomeController({required this.user});

  //getters
  bool get mostrarSaldo => _mostrarSaldo;
  double get balance => user.saldo;
  String get nome => user.nome;

  void alternarVisibilidadeSaldo() {
    _mostrarSaldo = !_mostrarSaldo;
    notifyListeners();
  }

  void atualizarSaldo() {
    notifyListeners();
  }
}
