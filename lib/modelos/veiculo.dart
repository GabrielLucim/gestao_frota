class Veiculo {
  int? id;
  String placa;
  String modelo;
  String fabricante;
  int ano;
  double kmRodados;

  Veiculo({
    this.id,
    required this.placa,
    required this.modelo,
    required this.fabricante,
    required this.ano,
    required this.kmRodados,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'placa': placa,
      'modelo': modelo,
      'fabricante': fabricante,
      'ano': ano,
      'kmRodados': kmRodados,
    };
  }

  factory Veiculo.fromMap(Map<String, dynamic> map) {
    return Veiculo(
      id: map['id'],
      placa: map['placa'],
      modelo: map['modelo'],
      fabricante: map['fabricante'],
      ano: map['ano'],
      kmRodados: map['kmRodados'],
    );
  }
}
