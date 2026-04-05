import 'package:flutter/material.dart';
import 'package:gestao_frota/dados.dart';
import 'package:gestao_frota/modelos/entrega.dart';

class TelaIniciarEntrega extends StatefulWidget {
  @override
  _TelaIniciarEntregaState createState() => _TelaIniciarEntregaState();
}

class _TelaIniciarEntregaState extends State<TelaIniciarEntrega> {
  Entrega? entregaSelecionada;

  void iniciarEntrega() {
    if (entregaSelecionada == null) return;

    if (entregaSelecionada!.status == StatusEntrega.pendente) {
      setState(() {
        entregaSelecionada!.status = StatusEntrega.emAndamento;
        entregaSelecionada!.dataInicio = DateTime.now();
      });
    }
  }

  void finalizarEntrega() {
    if (entregaSelecionada == null) return;

    if (entregaSelecionada!.status == StatusEntrega.emAndamento) {
      setState(() {
        entregaSelecionada!.status = StatusEntrega.concluida;
        entregaSelecionada!.dataFim = DateTime.now();
      });
    }
  }

  void cancelarEntrega() {
    if (entregaSelecionada == null) return;

    if (entregaSelecionada!.status == StatusEntrega.emAndamento) {
      setState(() {
        entregaSelecionada!.status = StatusEntrega.cancelada;
        entregaSelecionada!.dataFim = DateTime.now();
      });
    }
  }

  String formatarData(DateTime? data) {
    if (data == null) return '-';
    return '${data.day}/${data.month}/${data.year} '
        '${data.hour}:${data.minute.toString().padLeft(2, '0')}';
  }

  String textoStatus(StatusEntrega status) {
    switch (status) {
      case StatusEntrega.pendente:
        return 'Pendente';
      case StatusEntrega.emAndamento:
        return 'Em andamento';
      case StatusEntrega.concluida:
        return 'Concluída';
      case StatusEntrega.cancelada:
        return 'Cancelada';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Iniciar Entrega')),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<Entrega>(
              hint: Text('Selecione uma entrega'),
              initialValue: entregaSelecionada,
              items: Dados.entregas.map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(
                    '${e.destino} - ${e.veiculo.modelo} (${e.motorista.nome})',
                  ),
                );
              }).toList(),
              onChanged: (e) {
                setState(() {
                  entregaSelecionada = e;
                });
              },
            ),

            SizedBox(height: 20),

            if (entregaSelecionada != null) ...[
              Card(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Destino: ${entregaSelecionada!.destino}'),
                      Text('Veículo: ${entregaSelecionada!.veiculo.modelo}'),
                      Text('Motorista: ${entregaSelecionada!.motorista.nome}'),
                      Text(
                        'Status: ${textoStatus(entregaSelecionada!.status)}',
                      ),
                      Text(
                        'Início: ${formatarData(entregaSelecionada!.dataInicio)}',
                      ),
                      Text('Fim: ${formatarData(entregaSelecionada!.dataFim)}'),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),

              ElevatedButton(
                onPressed: entregaSelecionada!.status == StatusEntrega.pendente
                    ? iniciarEntrega
                    : null,
                child: Text('Iniciar Entrega'),
              ),

              ElevatedButton(
                onPressed:
                    entregaSelecionada!.status == StatusEntrega.emAndamento
                    ? finalizarEntrega
                    : null,
                child: Text('Finalizar Entrega'),
              ),

              ElevatedButton(
                onPressed:
                    entregaSelecionada!.status == StatusEntrega.emAndamento
                    ? cancelarEntrega
                    : null,
                child: Text('Cancelar Entrega'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
