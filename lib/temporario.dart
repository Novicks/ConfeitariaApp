import 'package:flutter/material.dart';
import 'package:confeitaria_app/tela_cadastro.dart';
import 'package:confeitaria_app/tela_inicial.dart';
import 'package:confeitaria_app/tela_login.dart';
import 'package:confeitaria_app/tela_pagamento.dart';
import 'package:confeitaria_app/tela_produto.dart';
import 'package:flutter/cupertino.dart';

class Temp extends StatelessWidget{
  const Temp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Padding(padding: const EdgeInsets.all(60.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TelaInicial())
                );
              }, child: const Text('Tela home')),
              ElevatedButton(onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TelaProduto())
                );
              }, child: const Text('Tela produto')),
              ElevatedButton(onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TelaLogin())
                );
              }, child: const Text('Tela login')),
              ElevatedButton(onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TelaPagamento())
                );
              }, child: const Text('Tela Pagamento')),
              ElevatedButton(onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TelaCadastro())
                );
              }, child: const Text('Tela cadastro')),
            ],
          ),
        ));
  }
}