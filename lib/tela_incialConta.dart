import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TelaIncialConta extends StatelessWidget{
  TelaIncialConta({super.key});

  @override
  Widget build(B    uildContext context){
    return Center(
      child: SafeArea(child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        color: Colors.red,
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))) ,onPressed: (){}, child: Text('Perfil')),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))) ,onPressed: (){}, child: Text('Endereços salvos')),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))) ,onPressed: (){}, child: Text('Historico de compras')),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))) ,onPressed: (){}, child: Text('Sair/Entrar')),
            ),
          ],
        ),
      ))
    );
  }
}