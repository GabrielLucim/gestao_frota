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
  String cpf = '';
  int idade = 0;

  void salvar() {
    if (!formKey.currentState!.validate()) return;

    formKey.currentState!.save();

    Dados.motoristas.add(
      Motorista(nome: nome, categoria_cnh: categoria, cpf: cpf, idade: idade),
    );

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
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'Informe o nome';
                  }
                  return null;
                },
                onSaved: (v) => nome = v!,
              ),

              SizedBox(height: 15),

              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Categoria CNH (B, C, D, E)',
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'Informe a categoria';
                  }

                  final validas = ['B', 'C', 'D', 'E'];

                  if (!validas.contains(v.toUpperCase())) {
                    return 'Categoria inválida (use B, C, D ou E)';
                  }

                  return null;
                },
                onSaved: (v) => categoria = v!.toUpperCase(),
              ),

              SizedBox(height: 15),

              TextFormField(
                decoration: InputDecoration(
                  labelText: 'CPF',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Informe o CPF';
                  if (v.length < 11) return 'CPF inválido';
                  return null;
                },
                onSaved: (v) => cpf = v!,
              ),

              SizedBox(height: 15),

              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Idade',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Informe a idade';
                  final idadeNum = int.tryParse(v);
                  if (idadeNum == null || idadeNum < 18) {
                    return 'Idade inválida (mínimo 18)';
                  }
                  return null;
                },
                onSaved: (v) => idade = int.parse(v!),
              ),

              ElevatedButton(onPressed: salvar, child: Text('Salvar')),
            ],
          ),
        ),
      ),
    );
  }
}
