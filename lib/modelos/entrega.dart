enum StatusEntrega { pendente, emAndamento, concluida, cancelada }

class Entrega {
  int? id;

  String destino;

  int veiculoId;
  int motoristaId;

  DateTime? dataInicio;
  DateTime? dataFim;

  StatusEntrega status;

  Entrega({
    this.id,
    required this.destino,
    required this.veiculoId,
    required this.motoristaId,
    this.dataInicio,
    this.dataFim,
    this.status = StatusEntrega.pendente,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'destino': destino,
      'veiculoId': veiculoId,
      'motoristaId': motoristaId,
      'dataInicio': dataInicio?.toIso8601String(),
      'dataFim': dataFim?.toIso8601String(),
      'status': status.name,
    };
  }

  factory Entrega.fromMap(Map<String, dynamic> map) {
    return Entrega(
      id: map['id'],
      destino: map['destino'],
      veiculoId: map['veiculoId'],
      motoristaId: map['motoristaId'],
      dataInicio: map['dataInicio'] != null
          ? DateTime.parse(map['dataInicio'])
          : null,
      dataFim: map['dataFim'] != null ? DateTime.parse(map['dataFim']) : null,
      status: StatusEntrega.values.firstWhere((s) => s.name == map['status']),
    );
  }
}
