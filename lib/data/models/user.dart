class User {
  final String id;
  final String nome;
  final String email;
  final String senha;
  final String chavePix;
  double saldo;

  User({
    required this.id,
    required this.nome,
    required this.email,
    required this.senha,
    required this.chavePix,
    required this.saldo,
  });

  Map<String, dynamic> toJson() {
    return {'nome': nome, 'email': email, 'senha': senha, 'saldo': saldo};
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nome: json['nome'],
      email: json['email'],
      senha: json['senha'],
      chavePix: json['chave_pix'],
      saldo: (json['saldo'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
