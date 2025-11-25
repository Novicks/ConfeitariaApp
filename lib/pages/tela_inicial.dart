import 'package:confeitaria_app/pages/tela_incialConta.dart';
import 'package:confeitaria_app/pages/tela_incialOfertas.dart';
import 'package:confeitaria_app/pages/tela_inicialCompras.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  int indexBar = 0;
  final List<Widget> listadePaginas = [
    TelaIncialOferta(),
    TelaIncialCompras(),
    TelaIncialConta(),
  ];
  final items = [
    Icon(Icons.home, size: 30),
    Icon(Icons.shopping_cart, size: 30),
    Icon(Icons.menu_rounded, size: 30),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listadePaginas[indexBar],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        height: 60,
        index: indexBar,
        items: items,
        onTap: (index) => setState(() {
          indexBar = index;
        }),
      ),
    );
  }
}
