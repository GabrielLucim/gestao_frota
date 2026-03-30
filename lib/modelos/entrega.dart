import 'veiculo.dart';
import 'motorista.dart';

class Entrega {
  String destino;
  Veiculo veiculo;
  Motorista motorista;

  Entrega({
    required this.destino,
    required this.veiculo,
    required this.motorista,
  });
}
