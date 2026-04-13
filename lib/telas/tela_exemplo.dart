import 'package:flutter/material.dart';

class TelaExemplo extends StatefulWidget{
  @override
  _TelaExemploState createState() => _TelaExemploState();
}

class _TelaExemploState extends State <TelaExemplo>{
  final formKey = GlobalKey<FormState>();

  String email = '';
  String senha = '';

  void salvar(){
    if (!formKey.currentState!.validate()) return;

    formKey.currentState!.save();
  }

  Widget build(BuildContext context){
    return Scaffold(

    );
  }
}