import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TelaPagamento(),
  ));
}

class TelaPagamento extends StatefulWidget {
  const TelaPagamento({super.key});

  @override
  State<TelaPagamento> createState() => _TelaPagamentoState();
}

enum MetodoPagamento { credito, debito, pix, dinheiro }

// Modelo simples para os produtos visuais da tela
class ProdutoResumo {
  final String nome;
  final int quantidade;
  final double valorUnitario;

  ProdutoResumo(this.nome, this.quantidade, this.valorUnitario);

  double get valorTotal => quantidade * valorUnitario;
}

class _TelaPagamentoState extends State<TelaPagamento> {
  final _formKey = GlobalKey<FormState>();
  MetodoPagamento _metodo = MetodoPagamento.credito;

  // Controllers
  final _nomeController = TextEditingController();
  final _numeroCartaoController = TextEditingController();
  final _validadeController = TextEditingController();
  final _cvvController = TextEditingController();

  // Lista fictícia baseada na imagem
  final List<ProdutoResumo> produtos = [
    ProdutoResumo("Bolo de Chocolate", 1, 20.00),
    ProdutoResumo("Torta de Limão", 2, 15.00),
    ProdutoResumo("Brigadeiros", 10, 2.50),
  ];

  // Cores extraídas da imagem
  final Color corFundo = const Color(0xFFEBCDA0); // Bege Fundo
  final Color corCardProduto = const Color(0xFFF6Bcb3); // Rosa Card
  final Color corContainerEscuro = const Color(0xFFAB9D8F); // Marrom/Cinza containers
  final Color corBotaoPagar = const Color(0xFFC0C5CA); // Prata/Cinza botão

  @override
  void dispose() {
    _nomeController.dispose();
    _numeroCartaoController.dispose();
    _validadeController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  double get totalGeral => produtos.fold(0, (sum, item) => sum + item.valorTotal);

  void _confirmarPagamento() {
    final bool usaCartao =
        _metodo == MetodoPagamento.credito || _metodo == MetodoPagamento.debito;

    if (usaCartao && !_formKey.currentState!.validate()) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pagamento realizado com sucesso! 🎂'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool usaCartao =
        _metodo == MetodoPagamento.credito || _metodo == MetodoPagamento.debito;

    return Scaffold(
      backgroundColor: corFundo,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              // 1. LISTA DE PRODUTOS (Cards Rosas)
              ...produtos.map((produto) => _buildCardProduto(produto)),

              const SizedBox(height: 20),

              // Efeito de separador brilhante (Opcional, baseado no "brilho" da imagem)
              Container(
                height: 5,
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white.withOpacity(0.4),
                  boxShadow: [
                    BoxShadow(color: Colors.pink.withOpacity(0.2), blurRadius: 10, spreadRadius: 2)
                  ]
                ),
              ),

              const SizedBox(height: 10),

              // 2. TOTAL (Container Escuro 1)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                decoration: BoxDecoration(
                  color: corContainerEscuro,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))
                  ]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Total: ", style: TextStyle(color: Colors.white70, fontSize: 20)),
                    Text(
                      "R\$ ${totalGeral.toStringAsFixed(2).replaceAll('.', ',')}",
                      style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // 3. FORMA DE PAGAMENTO (Container Escuro 2)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: corContainerEscuro,
                  borderRadius: BorderRadius.circular(20),
                   boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))
                  ]
                ),
                child: Column(
                  children: [
                    const Text(
                      "Forma de pagamento",
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 15),
                    
                    // Grid de Opções (Simulando os quadrados da imagem)
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      alignment: WrapAlignment.center,
                      children: [
                        _buildBotaoPagamento(Icons.credit_card, "Crédito", MetodoPagamento.credito),
                        _buildBotaoPagamento(Icons.credit_card_outlined, "Débito", MetodoPagamento.debito),
                        _buildBotaoPagamento(Icons.pix, "Pix", MetodoPagamento.pix),
                        _buildBotaoPagamento(Icons.attach_money, "Dinheiro", MetodoPagamento.dinheiro),
                      ],
                    ),

                    // Formulário do Cartão (Só aparece se for Crédito ou Débito)
                    if (usaCartao) ...[
                      const SizedBox(height: 20),
                      const Divider(color: Colors.white30),
                      const SizedBox(height: 10),
                      _buildFormularioCartao(),
                    ]
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // 4. BOTÃO PAGAR (Cinza Grande)
              SizedBox(
                width: double.infinity,
                height: 65,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: corBotaoPagar,
                    foregroundColor: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: _confirmarPagamento,
                  child: const Text(
                    "PAGAR",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Widget para os Cards dos Produtos (Rosa)
  Widget _buildCardProduto(ProdutoResumo produto) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: corCardProduto,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
           BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 4))
        ]
      ),
      child: Row(
        children: [
          // Ícone/Imagem quadrado preto com cantos arredondados
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A), // Preto suave
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.image, color: Colors.white54, size: 30),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  produto.nome,
                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  "Quantidade: ${produto.quantidade}",
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Unit: R\$ ${produto.valorUnitario}",
                      style: const TextStyle(color: Colors.white70, fontSize: 11),
                    ),
                    Text(
                      "Total: R\$ ${produto.valorTotal}",
                      style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // Widget para os quadradinhos de seleção de pagamento
  Widget _buildBotaoPagamento(IconData icon, String label, MetodoPagamento valor) {
    final bool selecionado = _metodo == valor;
    
    return GestureDetector(
      onTap: () => setState(() => _metodo = valor),
      child: Container(
        width: 70,
        height: 50,
        decoration: BoxDecoration(
          color: selecionado ? Colors.white : Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
          border: selecionado ? Border.all(color: Colors.white, width: 2) : null,
        ),
        child: Icon(
          icon,
          color: selecionado ? corContainerEscuro : Colors.white70,
        ),
      ),
    );
  }

  // Formulário estilizado para ficar dentro do container marrom
  Widget _buildFormularioCartao() {
    // Estilo padrão dos inputs dentro do container escuro
    final inputDecoration = InputDecoration(
      filled: true,
      fillColor: Colors.white.withOpacity(0.2),
      labelStyle: const TextStyle(color: Colors.white70),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
    );

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nomeController,
            style: const TextStyle(color: Colors.white),
            decoration: inputDecoration.copyWith(labelText: 'Nome no cartão'),
            validator: (v) => v!.isEmpty ? 'Campo obrigatório' : null,
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _numeroCartaoController,
            style: const TextStyle(color: Colors.white),
            keyboardType: TextInputType.number,
            maxLength: 16,
            decoration: inputDecoration.copyWith(labelText: 'Número do cartão', counterText: ""),
            validator: (v) => v!.length < 13 ? 'Inválido' : null,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _validadeController,
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.datetime,
                  decoration: inputDecoration.copyWith(labelText: 'MM/AA'),
                  validator: (v) => v!.isEmpty ? 'Inválido' : null,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  controller: _cvvController,
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.number,
                  maxLength: 3,
                  decoration: inputDecoration.copyWith(labelText: 'CVV', counterText: ""),
                  validator: (v) => v!.length != 3 ? 'Inválido' : null,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}