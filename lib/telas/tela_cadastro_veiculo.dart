import 'package:flutter/material.dart';
import 'package:gestao_frota/dados.dart';
import 'package:gestao_frota/modelos/veiculo.dart';

class TelaCadastroVeiculo extends StatefulWidget {
  @override
  _TelaCadastroVeiculoState createState() => _TelaCadastroVeiculoState();
}

class _TelaCadastroVeiculoState extends State<TelaCadastroVeiculo> {
  final formKey = GlobalKey<FormState>();

  String modelo = '';
  String placa = '';
  String fabricante = '';
  int ano = 0;
  double kmRodados = 0;

  void salvar() {
    if (!formKey.currentState!.validate()) return;

    formKey.currentState!.save();

    Dados.veiculos.add(
      Veiculo(
        placa: placa,
        modelo: modelo,
        fabricante: fabricante,
        ano: ano,
        kmRodados: kmRodados,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro de Veículo')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Modelo',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Informe o modelo' : null,
                onSaved: (v) => modelo = v!,
              ),

              SizedBox(height: 15),

              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Placa',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Informe a placa' : null,
                onSaved: (v) => placa = v!,
              ),

              SizedBox(height: 15),

              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Fabricante',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Informe o fabricante' : null,
                onSaved: (v) => fabricante = v!,
              ),

              SizedBox(height: 15),

              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Ano',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Informe o ano';
                  final anoNum = int.tryParse(v);
                  if (anoNum == null || anoNum < 1900) {
                    return 'Ano inválido';
                  }
                  return null;
                },
                onSaved: (v) => ano = int.parse(v!),
              ),

              SizedBox(height: 15),

              TextFormField(
                decoration: InputDecoration(
                  labelText: 'KM Rodados',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Informe a quilometragem';
                  final km = double.tryParse(v);
                  if (km == null || km < 0) {
                    return 'Valor inválido';
                  }
                  return null;
                },
                onSaved: (v) => kmRodados = double.parse(v!),
              ),

              ElevatedButton(onPressed: salvar, child: Text('Salvar')),
            ],
          ),
        ),
      ),
    );
  }
}
