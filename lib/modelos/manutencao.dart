enum StatusManutencao { aberta, emAndamento, concluida }

class Manutencao {
  int? id;

  String descricao;
  double custo;

  int veiculoId;

  StatusManutencao status;

  DateTime? dataInicio;
  DateTime? dataFim;

  Manutencao({
    this.id,
    required this.descricao,
    required this.custo,
    required this.veiculoId,
    this.status = StatusManutencao.aberta,
    this.dataInicio,
    this.dataFim,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'descricao': descricao,
      'custo': custo,
      'veiculoId': veiculoId,
      'status': status.name,
      'dataInicio': dataInicio?.toIso8601String(),
      'dataFim': dataFim?.toIso8601String(),
    };
  }

  factory Manutencao.fromMap(Map<String, dynamic> map) {
    return Manutencao(
      id: map['id'],

      descricao: map['descricao'],

      custo: map['custo'],

      veiculoId: map['veiculoId'],

      status: StatusManutencao.values.firstWhere(
        (s) => s.name == map['status'],
      ),

      dataInicio: map['dataInicio'] != null
          ? DateTime.parse(map['dataInicio'])
          : null,

      dataFim: map['dataFim'] != null ? DateTime.parse(map['dataFim']) : null,
    );
  }
}
