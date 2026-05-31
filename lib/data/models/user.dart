class User {
  final String nome;
  final String email;
  final String senha;
  double balance;

  User({ required this.nome, required this.email, required this.senha, this.balance = 1000.0});

  Map<String, dynamic> toJson() {
    return {'nome': nome,'email': email, 'senha': senha, 'balance': balance};
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
       nome: json['nome'],
      email: json['email'],
      senha: json['senha'],
      balance: (json['balance'] as num).toDouble(),
    );
  }
}
