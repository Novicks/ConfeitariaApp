import 'package:flutter/material.dart';

class Tela_Pedidos_Admin extends StatefulWidget {
  Tela_Pedidos_Admin({super.key});

  @override
  State<Tela_Pedidos_Admin> createState() => Tela_Pedidos_AdminState();
}

class Tela_Pedidos_AdminState extends State<Tela_Pedidos_Admin> {
  List <Pedidos> pedidos= [];

  @override
  void initState(){
    super.initState();
    carregaPedidos();
  }
  Future<void> carregaPedidos()async{
    final lista = await.listarTodos();
    setState((){
      Pedidos = lista;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Pedidos"),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => ()));
          }, icon: Icon(Icons.add))
        ],
      ),
      body: Padding(padding: const EdgeInsets.all(10),
        child: ListView.builder(
            itemCount: pedidos.length,
            itemBuilder: (context, index){
              final r = pedidos[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8),
                child:  ListTile(
                  title:  Text(r.nome?? 'Sem nome'),
                  subtitle:  Text('ID: ${r.codigo}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: (){
                            //Codigo para Editar Restaurante
                          },
                          icon: Icon(Icons.edit, color: Colors.blue)
                      ),
                      IconButton(
                          onPressed: (){
                            //Codigo para EXCLUIR Pedido
                            AlertDialog(
                              title:  Text("Confirmar ação"),
                              content: Text("Deseja realmente exluir?"),
                              actions: <Widget>[
                                TextButton(
                                    onPressed: () {

                                      //Código para excluir o registro
                                    },
                                    child: Text("sim")
                                ),
                                TextButton(
                                    onPressed: (){
                                    },
                                    child: Text("não")
                                ),
                              ],
                            );
                          },
                          icon: Icon(Icons.delete, color: Colors.red)
                      ),
                    ],
                  ),
                ),
              );
            }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => ()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}