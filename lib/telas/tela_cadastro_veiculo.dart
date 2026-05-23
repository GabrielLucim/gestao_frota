import 'package:flutter/material.dart';
import 'package:gestao_frota/dao/veiculo_dao.dart';
import 'package:gestao_frota/modelos/veiculo.dart';

class TelaCadastroVeiculo extends StatefulWidget {
  final Veiculo? veiculo;

  TelaCadastroVeiculo({this.veiculo});

  @override
  _TelaCadastroVeiculoState createState() => _TelaCadastroVeiculoState();
}

class _TelaCadastroVeiculoState extends State<TelaCadastroVeiculo> {
  final formKey = GlobalKey<FormState>();

  final VeiculoDAO veiculoDAO = VeiculoDAO();

  String modelo = '';
  String placa = '';
  String fabricante = '';
  int ano = 0;
  double kmRodados = 0;

  @override
  void initState() {
    super.initState();

    if (widget.veiculo != null) {
      modelo = widget.veiculo!.modelo;
      placa = widget.veiculo!.placa;
      fabricante = widget.veiculo!.fabricante;
      ano = widget.veiculo!.ano;
      kmRodados = widget.veiculo!.kmRodados;
    }
  }

  Future<void> salvar() async {
    if (!formKey.currentState!.validate()) return;

    formKey.currentState!.save();

    Veiculo veiculo = Veiculo(
      placa: placa,
      modelo: modelo,
      fabricante: fabricante,
      ano: ano,
      kmRodados: kmRodados,
    );

    if (widget.veiculo == null) {
      await veiculoDAO.inserir(veiculo);
    } else {
      veiculo.id = widget.veiculo!.id;

      await veiculoDAO.atualizar(veiculo);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.veiculo == null ? 'Cadastro de Veículo' : 'Editar Veículo',
        ),
      ),

      body: Padding(
        padding: EdgeInsets.all(16),

        child: Form(
          key: formKey,

          child: Column(
            children: [
              TextFormField(
                initialValue: modelo,

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
                initialValue: placa,

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
                initialValue: fabricante,

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
                initialValue: ano == 0 ? '' : ano.toString(),

                decoration: InputDecoration(
                  labelText: 'Ano',
                  border: OutlineInputBorder(),
                ),

                keyboardType: TextInputType.number,

                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'Informe o ano';
                  }

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
                initialValue: kmRodados == 0 ? '' : kmRodados.toString(),

                decoration: InputDecoration(
                  labelText: 'KM Rodados',
                  border: OutlineInputBorder(),
                ),

                keyboardType: TextInputType.number,

                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'Informe a quilometragem';
                  }

                  final texto = v.replaceAll(',', '.');

                  final km = double.tryParse(texto);

                  if (km == null || km < 0) {
                    return 'Valor inválido';
                  }

                  return null;
                },

                onSaved: (v) {
                  kmRodados = double.parse(v!.replaceAll(',', '.'));
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
