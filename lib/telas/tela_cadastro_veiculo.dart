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

  void salvar() {
    formKey.currentState!.save();

    Dados.veiculos.add(
      Veiculo(modelo: modelo, placa: placa, fabricante: fabricante),
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
                onSaved: (v) => modelo = v!,
              ),

              SizedBox(height: 15),

              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Placa',
                  border: OutlineInputBorder(),
                ),
                onSaved: (v) => placa = v!,
              ),

              SizedBox(height: 15),

              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Fabricante',
                  border: OutlineInputBorder(),
                ),
                onSaved: (v) => fabricante = v ?? '',
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
