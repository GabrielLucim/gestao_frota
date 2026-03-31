import 'package:flutter/material.dart';
import 'package:gestao_frota/dados.dart';
import 'package:gestao_frota/modelos/motorista.dart';

class TelaCadastroMotorista extends StatefulWidget {
  @override
  _TelaCadastroMotoristaState createState() => _TelaCadastroMotoristaState();
}

class _TelaCadastroMotoristaState extends State<TelaCadastroMotorista> {
  final formKey = GlobalKey<FormState>();

  String nome = '';
  String categoria = '';

  void salvar() {
    formKey.currentState!.save();

    Dados.motoristas.add(Motorista(nome: nome, categoria_cnh: categoria));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro de Motorista')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nome do motorista',
                  border: OutlineInputBorder(),
                ),
                onSaved: (v) => nome = v!,
              ),

              SizedBox(height: 15),

              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Categoria CNH (B, C...)',
                  border: OutlineInputBorder(),
                ),
                onSaved: (v) => categoria = v!,
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
