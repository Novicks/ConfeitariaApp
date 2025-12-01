import 'package:flutter/material.dart';

class PersonalizarPedidoPage extends StatefulWidget {
  const PersonalizarPedidoPage({super.key});

  @override
  State<PersonalizarPedidoPage> createState() => _PersonalizarPedidoPageState();
}

class _PersonalizarPedidoPageState extends State<PersonalizarPedidoPage> {
  // ----- LISTA COMPLETA DE RECHEIOS -----
  final List<String> recheios = [
  "Abacaxi com coco",
  "Beijinho",
  "Brigadeiro ao leite",
  "Brigadeiro meio amargo",
  "Brigadeiro branco",
  "Brigadeiro de leite ninho",
  "Brigadeiro crocante",
  "Brigadeiro de café",
  "Brigadeiro de queijo",
  "Brigadeiro de paçoca",
  "Brigadeiro de Nutella",
  "Brigadeiro de Limão",
  "Brigadeiro de morango",
  "Creme belga com morango",
  "Creme belga chocolate",
  "Doce de leite",
  "Doce de leite c/ ameixa",
  "Doce de leite c/ amendoim",
