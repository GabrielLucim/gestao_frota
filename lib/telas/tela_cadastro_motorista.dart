import 'package:flutter/material.dart';
import 'package:gestao_frota/dao/motorista_dao.dart';
import 'package:gestao_frota/modelos/motorista.dart';

class TelaCadastroMotorista extends StatefulWidget {
  final Motorista? motorista;

  TelaCadastroMotorista({this.motorista});

  @override
  _TelaCadastroMotoristaState createState() => _TelaCadastroMotoristaState();
}

class _TelaCadastroMotoristaState extends State<TelaCadastroMotorista> {
  final formKey = GlobalKey<FormState>();

  final MotoristaDAO motoristaDAO = MotoristaDAO();

  String nome = '';
  String categoria = '';
  String cpf = '';
  DateTime? dataNascimento;

  @override
  void initState() {
    super.initState();

    if (widget.motorista != null) {
      nome = widget.motorista!.nome;
      categoria = widget.motorista!.categoria_cnh;
      cpf = widget.motorista!.cpf;
      dataNascimento = widget.motorista!.dataNascimento;
    }
  }

  Future<void> salvar() async {
    if (!formKey.currentState!.validate()) return;

    formKey.currentState!.save();

    Motorista motorista = Motorista(
      nome: nome,
      categoria_cnh: categoria,
      cpf: cpf,
      dataNascimento: dataNascimento!,
    );

    if (widget.motorista == null) {
      await motoristaDAO.inserir(motorista);
    } else {
      motorista.id = widget.motorista!.id;

      await motoristaDAO.atualizar(motorista);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.motorista == null
              ? 'Cadastro de Motorista'
              : 'Editar Motorista',
        ),
      ),

      body: Padding(
        padding: EdgeInsets.all(16),

        child: Form(
          key: formKey,

          child: Column(
            children: [
              TextFormField(
                initialValue: nome,

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
                initialValue: categoria,

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
                initialValue: cpf,

                decoration: InputDecoration(
                  labelText: 'CPF',
                  border: OutlineInputBorder(),
                ),

                keyboardType: TextInputType.number,

                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'Informe o CPF';
                  }

                  if (v.length < 11) {
                    return 'CPF inválido';
                  }

                  return null;
                },

                onSaved: (v) => cpf = v!,
              ),

              SizedBox(height: 15),

              TextFormField(
                initialValue: dataNascimento == null
                    ? ''
                    : '${dataNascimento!.day.toString().padLeft(2, '0')}/'
                          '${dataNascimento!.month.toString().padLeft(2, '0')}/'
                          '${dataNascimento!.year}',

                decoration: InputDecoration(
                  labelText: 'Data de nascimento (DD/MM/AAAA)',
                  border: OutlineInputBorder(),
                ),

                keyboardType: TextInputType.datetime,

                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'Informe a data';
                  }

                  final partes = v.split('/');

                  if (partes.length != 3) {
                    return 'Formato inválido';
                  }

                  final dia = int.tryParse(partes[0]);

                  final mes = int.tryParse(partes[1]);

                  final ano = int.tryParse(partes[2]);

                  if (dia == null || mes == null || ano == null) {
                    return 'Data inválida';
                  }

                  dataNascimento = DateTime(ano, mes, dia);

                  return null;
                },
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
