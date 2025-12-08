import 'package:confeitaria_app/pages/tela_incialOfertas.dart';
import 'package:confeitaria_app/pages/tela_inicial.dart';
import 'package:confeitaria_app/pages/tela_pagamento.dart';
import 'package:flutter/material.dart';

// 1. Classe auxiliar para representar um produto com preço e quantidade
class ProdutoCarrinho {
  final String nome;
  final double preco;
  int quantidade;

  ProdutoCarrinho({
    required this.nome,
    required this.preco,
    this.quantidade = 1,
  });
}

class TelaIncialCompras extends StatefulWidget {
  const TelaIncialCompras({super.key});

  @override
  State<TelaIncialCompras> createState() => _TelaIncialComprasState();
}

class _TelaIncialComprasState extends State<TelaIncialCompras> {
  late List<ProdutoCarrinho> listaProdutos;

  // --- PALETA DE CORES (Baseada na Tela de Pagamento) ---
  final Color corFundo = const Color(0xFFEBCDA0); // Bege Fundo
  final Color corCard = const Color(0xFFF6Bcb3); // Rosa Card
  final Color corContainerTotal = const Color(0xFFAB9D8F); // Marrom Container
  final Color corBotaoPagar = const Color(0xFFC0C5CA); // Cinza/Prata Botão
  final Color corIconeImagem = const Color(0xFF1A1A1A); // Preto suave para placeholder

  @override
  void initState() {
    super.initState();
    final nomes = [
      "Bolo de chocolate com confetes",
      "Torta de limão",
      "Doce de maracuja",
      "Brigadeiro",
      "Beijinho",
      "Gelatina fini Incriveis",
      "Salgadinhos",
      "Panetone recheado com frutas cristalizadas",
      "Bolo de cenoura",
    ];

    listaProdutos = nomes.map((nome) {
      return ProdutoCarrinho(nome: nome, preco: 12.50); // Preço base fictício
    }).toList();
  }

  // Função para calcular o total
  double get valorTotal {
    return listaProdutos.fold(
      0,
      (soma, item) => soma + (item.preco * item.quantidade),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corFundo, // Fundo Bege
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Meu Carrinho",
          style: TextStyle(
            color: Colors.white, 
            fontWeight: FontWeight.bold,
            shadows: [Shadow(color: Colors.black26, blurRadius: 2)],
          ),
        ),
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TelaInicial()),
              );
            },
          ),
        ),
      ),
      extendBodyBehindAppBar: true, // Para o fundo bege ir até o topo
      body: SafeArea(
        child: Column(
          children: [
            // --- LISTA DE PRODUTOS ---
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                itemCount: listaProdutos.length,
                itemBuilder: (context, index) {
                  final item = listaProdutos[index];
                  return _buildCartItem(item);
                },
              ),
            ),

            // --- RODAPÉ (TOTAL E BOTÃO) ---
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: corContainerTotal, // Marrom/Cinza
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total:",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white70,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "R\$ ${valorTotal.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green, // Cinza Prateado
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        elevation: 5,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TelaPagamento(),
                          ),
                        );
                      },
                      child: const Text(
                        "PAGAR",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget do Card (Estilo Rosa)
  Widget _buildCartItem(ProdutoCarrinho item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: corCard, // Rosa Suave
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // 1. Imagem (Placeholder Preto Arredondado)
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: corIconeImagem,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(Icons.image, color: Colors.white54, size: 30),
          ),
          const SizedBox(width: 16),

          // 2. Informações
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.nome,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Texto Branco
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Unit: R\$ ${item.preco.toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 13, color: Colors.white70),
                ),
                const SizedBox(height: 8),

                // 3. Botões de Quantidade (Estilo Transparente)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _botaoQuantidade(
                        icon: Icons.remove,
                        onTap: () {
                          setState(() {
                            if (item.quantidade > 0) item.quantidade--;
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "${item.quantidade}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      _botaoQuantidade(
                        icon: Icons.add,
                        onTap: () {
                          setState(() {
                            item.quantidade++;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget auxiliar para os botões de + e -
  Widget _botaoQuantidade({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: const BoxDecoration(
          color: Colors.transparent, // Sem fundo, apenas ícone
        ),
        child: Icon(icon, size: 20, color: Colors.white),
      ),
    );
  }
}