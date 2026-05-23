class Motorista {
  int? id;

  String nome;
  String categoria_cnh;
  String cpf;
  DateTime dataNascimento;

  Motorista({
    this.id,
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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'categoria_cnh': categoria_cnh,
      'cpf': cpf,
      'dataNascimento': dataNascimento.toIso8601String(),
    };
  }

  factory Motorista.fromMap(Map<String, dynamic> map) {
    return Motorista(
      id: map['id'],
      nome: map['nome'],
      categoria_cnh: map['categoria_cnh'],
      cpf: map['cpf'],
      dataNascimento: DateTime.parse(map['dataNascimento']),
    );
  }
}
