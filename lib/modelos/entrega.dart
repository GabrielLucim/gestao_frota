import 'veiculo.dart';
import 'motorista.dart';

enum StatusEntrega { pendente, emAndamento, concluida, cancelada }

class Entrega {
  String destino;
  Veiculo veiculo;
  Motorista motorista;

  DateTime? dataInicio;
  DateTime? dataFim;
  StatusEntrega status;

  Entrega({
    required this.destino,
    required this.veiculo,
    required this.motorista,
    this.dataInicio,
    this.dataFim,
    this.status = StatusEntrega.pendente,
  });
}
