import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TelaIncialCompras extends StatelessWidget{
  TelaIncialCompras({super.key});

  @override
  List<String> produtinho = ["Bolo de chocolate com confetes", "Torta de limão",
  "Doce de maracuja", "Brigadeiro", "Beijinho", "Gelatina fini Incriveis", "Salgadinhos",
    "Panetone recheado com frutas cristalizadas", "Bolo de cenoura"
  ];
  Widget build(BuildContext context){
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          // tela superior com lista de pedidos e informações de total e subtotal.
          Expanded(
            flex: 5,
            child: SafeArea(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 5),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                ),
                child: Column(
                  children: [
                    Expanded(
                      flex: 8,
                      child: ListView.builder(
                          itemCount: produtinho.length,
                          itemBuilder: (context,index){
                            final i = produtinho[index];
                            return Card(
                              margin: EdgeInsets.symmetric(vertical: 4),
                              child: ListTile(
                                title: Text(i),
                              ),
                            ) ;
                          }
                      ),
                    ),
                    SizedBox(height: 12),
                    Expanded(flex: 2,
                        child: Text('Subtotal'))
                  ],
                ),
              ),
            )
          ),
          SizedBox(height: MediaQuery.of(context).size.height*0.05),
          // container inferior com confirmar compra é
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.03, horizontal: MediaQuery.of(context).size.width*0.08),
              color: Colors.amber,
              child: ElevatedButton(style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
              ),onPressed: (){
                // Adicionar função de comprar
              }, child: Row( mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                Text('Comprar', style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05)),
              ],)),
            ),
          )
        ],
      ),
    );
  }
}