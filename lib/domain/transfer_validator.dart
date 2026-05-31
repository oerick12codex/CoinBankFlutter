class TransferValidator {
  static String? validar({
    required double valor,
    required double valorAtual,
    required String chavePixDestino,
  }) {
    if(chavePixDestino.trim().isEmpty) {
      return "A chave Pix de destino não pode estar vazia.";
    }

    if (valor <= 0) {
      return "O valor da transferência deve ser maior que zero.";
    }

    if(valor > valorAtual) {
      return "Saldo insuficiente para realizar a transferência.";
    }
    return null;
  }
}