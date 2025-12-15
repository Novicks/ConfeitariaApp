import 'package:confeitaria_app/db/clienteDAO.dart';
import 'package:confeitaria_app/pages/tela_incialOfertas.dart';
import 'package:flutter/material.dart';

class TelaIncialConta extends StatelessWidget {
  const TelaIncialConta({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          width: double.infinity,
          color: Color(0xFFFFF8F3),
          child: Column(
            children: [
              /*SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                  onPressed: () {},
                  child: Text('Perfil'),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                  onPressed: () {},
                  child: Text('Endereços salvos'),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                  onPressed: () {},
                  child: Text('Historico de compras'),
                ),
              ),*/
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    backgroundColor: Color(0xFFF6Bcb3)
                  ),
                  onPressed: () {
                    if(ClienteDAO.clientePresente() == true){
                      ClienteDAO.sair();
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TelaIncialOferta()));
                    }
                  },
                  child: Text('Sair/Entrar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
