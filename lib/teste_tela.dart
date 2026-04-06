import 'package:flutter/material.dart';

class TesteTela extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'insira seu nome',
              border: OutlineInputBorder(),
            ),
          ),

          SizedBox(height: 15),

          TextField(
            decoration: InputDecoration(
              labelText: 'insira sua profissão',
              border: OutlineInputBorder(),
            ),
          ),

          SizedBox(height: 15),

          TextField(
            decoration: InputDecoration(
              labelText: 'sua data de nascimento',
              border: OutlineInputBorder(),
            ),
          ),

          ElevatedButton(onPressed: () {}, child: Text('data')),
        ],
      ),
    );
  }
}
