import 'package:confeitaria_app/pages/tela_incialConta.dart';
import 'package:confeitaria_app/pages/tela_incialOfertas.dart';
import 'package:confeitaria_app/pages/tela_inicialCompras.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TelaInicial extends StatefulWidget{
  TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  int indexBar = 0;
  final List<Widget> listadePaginas = [
    TelaIncialOferta(),
    TelaIncialCompras(),
    TelaIncialConta()
  ];
  @override
  Widget build(BuildContext context){
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          setState(() {
            indexBar = index;
          });
        },
          currentIndex: indexBar,
          items: const[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.menu_rounded), label: ''),
      ]),
      body: listadePaginas[indexBar]
    );
  }
}