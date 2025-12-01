import 'package:flutter/material.dart';

class TelaPagamento extends StatefulWidget {
  const TelaPagamento({super.key});

  @override
  State<TelaPagamento> createState() => _TelaPagamentoState();
}

enum MetodoPagamento { credito, debito, pix, dinheiro }

class _TelaPagamentoState extends State<TelaPagamento> {
  final _formKey = GlobalKey<FormState>();

  MetodoPagamento _metodo = MetodoPagamento.credito;

  final _nomeController = TextEditingController();
  final _numeroCartaoController = TextEditingController();
  final _validadeController = TextEditingController();
  final _cvvController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    _numeroCartaoController.dispose();
    _validadeController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  void _confirmarPagamento() {
    final bool usaCartao =
        _metodo == MetodoPagamento.credito || _metodo == MetodoPagamento.debito;

    // se for cartão, valida o formulário
    if (usaCartao && !_formKey.currentState!.validate()) {
      return;
    }

    // aqui entraria sua lógica real de envio do pedido / pagamento
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Pagamento realizado com sucesso! 🎂')),
    );

    // se quiser, volta para a tela anterior:
    // Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final bool usaCartao =
        _metodo == MetodoPagamento.credito || _metodo == MetodoPagamento.debito;

    return Scaffold(
      appBar: AppBar(title: const Text('Pagamento')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Escolha a forma de pagamento',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            // Métodos de pagamento
            RadioListTile<MetodoPagamento>(
              title: const Text('Cartão de crédito'),
              value: MetodoPagamento.credito,
              groupValue: _metodo,
              onChanged: (value) {
                setState(() => _metodo = value!);
              },
            ),
            RadioListTile<MetodoPagamento>(
              title: const Text('Cartão de débito'),
              value: MetodoPagamento.debito,
              groupValue: _metodo,
              onChanged: (value) {
                setState(() => _metodo = value!);
              },
            ),
            RadioListTile<MetodoPagamento>(
              title: const Text('Pix'),
              value: MetodoPagamento.pix,
              groupValue: _metodo,
              onChanged: (value) {
                setState(() => _metodo = value!);
              },
            ),
            RadioListTile<MetodoPagamento>(
              title: const Text('Dinheiro na entrega'),
              value: MetodoPagamento.dinheiro,
              groupValue: _metodo,
              onChanged: (value) {
                setState(() => _metodo = value!);
              },
            ),

            const SizedBox(height: 16),

            // Campos do cartão (aparecem só se for crédito/débito)
            if (usaCartao)
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _nomeController,
                      decoration: const InputDecoration(
                        labelText: 'Nome impresso no cartão',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Informe o nome do cartão';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _numeroCartaoController,
                      decoration: const InputDecoration(
                        labelText: 'Número do cartão',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      maxLength: 16,
                      validator: (value) {
                        if (value == null || value.trim().length < 13) {
                          return 'Número de cartão inválido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _validadeController,
                            decoration: const InputDecoration(
                              labelText: 'Validade (MM/AA)',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.datetime,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Informe a validade';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            controller: _cvvController,
                            decoration: const InputDecoration(
                              labelText: 'CVV',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            maxLength: 3,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.trim().length != 3) {
                                return 'CVV inválido';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 24),

            // Botão Finalizar
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _confirmarPagamento,
                child: const Text('Finalizar pedido'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
