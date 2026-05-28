class User {
  final String nome;
  final String senha;
  double balance;

  User({required this.nome, required this.senha, this.balance = 1000.0});

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'senha': senha,
      'balance': balance,
    };
  }
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      nome: json['nome'],
      senha: json['senha'],
      balance: (json['balance'] as num).toDouble(),
    );
  }
}