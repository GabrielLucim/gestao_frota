import 'package:flutter/material.dart';
import 'package:gestao_frota/dados.dart';
import 'package:gestao_frota/modelos/entrega.dart';
import 'package:gestao_frota/modelos/veiculo.dart';
import 'package:gestao_frota/modelos/motorista.dart';

class TelaCadastroEntrega extends StatefulWidget {
  @override
  _TelaCadastroEntregaState createState() => _TelaCadastroEntregaState();
}

class _TelaCadastroEntregaState extends State<TelaCadastroEntrega> {
  final formKey = GlobalKey<FormState>();

  String destino = '';
  Veiculo? veiculo;
  Motorista? motorista;

  void salvar() {
    if (!formKey.currentState!.validate()) return;

    formKey.currentState!.save();

    Dados.entregas.add(
      Entrega(destino: destino, veiculo: veiculo!, motorista: motorista!),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro de Entrega')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Destino',
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'Informe o destino';
                  }
                  return null;
                },
                onSaved: (v) => destino = v!,
              ),

              SizedBox(height: 15),

              DropdownButtonFormField<Veiculo>(
                hint: Text('Selecione um veículo'),
                items: Dados.veiculos.map((v) {
                  return DropdownMenuItem(value: v, child: Text(v.modelo));
                }).toList(),
                onChanged: (v) => veiculo = v,
                validator: (v) => v == null ? 'Selecione um veículo' : null,
              ),

              SizedBox(height: 15),

              DropdownButtonFormField<Motorista>(
                hint: Text('Selecione um motorista'),
                items: Dados.motoristas.map((m) {
                  return DropdownMenuItem(value: m, child: Text(m.nome));
                }).toList(),
                onChanged: (m) => motorista = m,
                validator: (m) => m == null ? 'Selecione um motorista' : null,
              ),

              SizedBox(height: 20),

              ElevatedButton(onPressed: salvar, child: Text('Salvar')),
            ],
          ),
        ),
      ),
    );
  }
}
