import 'package:confeitaria_app/Models/ProdutoCarrinho.dart';
import 'package:confeitaria_app/Models/itens_pedido.dart';
import 'package:confeitaria_app/Models/produto.dart';
import 'package:confeitaria_app/db/ProdutoDao.dart';
import 'package:confeitaria_app/pages/tela_incialOfertas.dart';
import 'package:confeitaria_app/pages/tela_inicial.dart';
import 'package:confeitaria_app/pages/tela_pagamento.dart';
import 'package:flutter/material.dart';

// 1. Classe auxiliar para representar um produto com preço e quantidade
class TelaIncialCompras extends StatefulWidget {
  const TelaIncialCompras({super.key});

  @override
  State<TelaIncialCompras> createState() => _TelaIncialComprasState();
}

class _TelaIncialComprasState extends State<TelaIncialCompras> {

  // --- PALETA DE CORES (Baseada na Tela de Pagamento) ---
  final Color corFundo = const Color(0xFFFFF8F3); // Bege Fundo 0xFFFFF8F3
  final Color corCard = const Color(0xFFF6Bcb3); // Rosa Card
  final Color corContainerTotal = const Color(0xFFAB9D8F); // Marrom Container
  final Color corBotaoPagar = const Color(0xFFC0C5CA); // Cinza/Prata Botão
  final Color corIconeImagem = const Color(0xFF1A1A1A); // Preto suave para placeholder
  late Future<List<ProdutoCarrinho>> _futureProduto;
  double total = 0;
  @override
  void initState() {
    super.initState();
    _futureProduto = ProdutoDAO.listarCarrinho();
    /*listaProdutos = nomes.map((nome) {
      return Produto(nome: nome, preco: 12.50); // Preço base fictício
    }).toList();*/
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corFundo, // Fundo Bege
      appBar: AppBar(
        backgroundColor: Color(0xFFEBCDA0),
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
              child: FutureBuilder<List<ProdutoCarrinho>>(
                future: _futureProduto,
                builder: (context, snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const Center(child: CircularProgressIndicator(),);
                  }
                  if(snapshot.hasError){
                    return const Center(child: Text('Erro ao carregar carrinho'),);
                  }
                  final carrinho = snapshot.data?? [];
                  if (carrinho.isEmpty){
                    return const Center(child: Text('Carrinho vazio'),);
                  }

                  try {
                  } catch (e, s) {
                    print(s);
                  }
                  total = carrinho.fold(0, (soma, item) => soma + item.subtotal);

                  return ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: carrinho.length,
                    itemBuilder: (context, index){
                      return _buildCartItem(carrinho[index]);
                    }
                  );
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
                        "R\$ ${total.toString()}",
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
                  item.p.nome.toString(),
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
                  "Unit: R\$ ${item.p.preco.toString()}",
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