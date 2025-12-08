import 'package:flutter/material.dart';

class TelaProduto extends StatefulWidget {
  const TelaProduto({super.key});

  @override
  State<TelaProduto> createState() => _TelaProdutoState();
}

class _TelaProdutoState extends State<TelaProduto> {
  int quantidade = 1;
  final Color corFundoTopo = const Color(0xFFF5C0B6);
  final Color corCardBege = const Color(0xFFEACCAE); 
  final Color corBotaoRosa = const Color(0xFFFFB5B5); 


  @override
  Widget build(BuildContext context) {
    final double alturaTela = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: corFundoTopo,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          // 1. Botão de Voltar (No topo esquerdo)
          Positioned(
            top: 50,
            left: 20,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),

          // 2. O Cartão Bege (Fica na parte inferior)
          Positioned(
            bottom: 0,
            child: Container(
              height: alturaTela * 0.65, 
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              decoration: BoxDecoration(
                color: corCardBege,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),
                  
                  // Tag de Avaliação (Estrela e nota)
                  Container(
                    width: 80,
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                    decoration: BoxDecoration(
                      color: corBotaoRosa,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        )
                      ]
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star, color: Colors.white, size: 16),
                        SizedBox(width: 5),
                        Text(
                          "4.9",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Título do Produto (Fonte Cursiva)
                  const Text(
                    "Bolo de Chocolate",
                    style: TextStyle(
                      fontFamily: 'Pacifico', 
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Descrição (Lorem Ipsum)
                  const Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                    style: TextStyle(
                      color: Colors.white,
                      height: 1.5,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.justify,
                  ),

                  const Spacer(),

                  // LINHA DE AÇÃO (Contador e Botão Comprar)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Contador (- 1 +)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1), 
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove, color: Colors.white),
                              onPressed: () => setState(() { if(quantidade > 1) quantidade--; }),
                            ),
                            Text(
                              "$quantidade",
                              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add, color: Colors.white),
                              onPressed: () => setState(() => quantidade++),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 20),

                      // Botão Comprar
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: corBotaoRosa,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            elevation: 5,
                          ),
                          onPressed: () {},
                          child: const Text(
                            "Adicionar Ao Carrinho",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // 3. Imagem do Bolo (Centralizada e "Flutuando")
          Positioned(
            top: alturaTela * 0.15,
            child: Column(
              children: [
                Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      )
                    ],
                    // Aqui você coloca a imagem do bolo
                    image: const DecorationImage(
                      image: NetworkImage("https://www.pngall.com/wp-content/uploads/2016/05/Chocolate-Cake-Free-Download-PNG.png"), 
                      fit: BoxFit.cover,
                    ),
                    color: const Color(0xFFF9E0C6), // Cor de fundo caso a imagem seja PNG transparente
                    border: Border.all(color: Colors.white.withOpacity(0.2), width: 4)
                  ),
                ),
                
                // Tag de Preço (Sobrepondo a imagem levemente)
                Transform.translate(
                  offset: const Offset(0, -25), // Sobe a tag para cima da imagem
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2B9B4).withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5)
                      ]
                    ),
                    child: const Text(
                      "R\$ 20,00",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}