class Motorista {
  String nome;
  String categoria_cnh;
  String cpf;
  DateTime dataNascimento;

  Motorista({
    required this.nome,
    required this.categoria_cnh,
    required this.cpf,
    required this.dataNascimento,
  });

  // Getter para calcular idade automaticamente
  int get idade {
    final hoje = DateTime.now();
    int idade = hoje.year - dataNascimento.year;

    if (hoje.month < dataNascimento.month ||
        (hoje.month == dataNascimento.month && hoje.day < dataNascimento.day)) {
      idade--;
    }

    return idade;
  }
}
