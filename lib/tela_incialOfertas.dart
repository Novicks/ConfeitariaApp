import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TelaIncialOferta extends StatefulWidget{
  TelaIncialOferta({super.key});

  @override
  State<TelaIncialOferta> createState() => _TelaIncialOfertaState();
}

class _TelaIncialOfertaState extends State<TelaIncialOferta> {
  final CarouselController controllerCarousel = CarouselController(initialItem: 1);
  final SearchController _searchController = SearchController();
  // alterar para lista produtos atráves do banco de dados conforme digitado
  final List<String> _produtos = ['bolo','torta', 'salgado', 'etc'];
  final List<String> _imagensProv = ['https://picsum.photos/200/300','https://picsum.photos/200/300', 'https://picsum.photos/200/300', 'https://picsum.photos/200/300', 'https://picsum.photos/200/300'];
  @override
  Widget build(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // container usuario é marca
        Container(
          padding: const EdgeInsets.all(24),
          child: Row(
          spacing: 20,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.red,
              ),
              child: IconButton(iconSize: 60,onPressed: (){}, icon:  Icon(Icons.person)),
          ),
            Text('Seja bem vindo', style: TextStyle(fontSize: 24)),
            IconButton(iconSize: 50,onPressed: (){}, icon: Icon(Icons.notifications))
          ],
        ),
      ),
        //container barra de pesquisa
        Container(
          padding: const EdgeInsets.all(10),
          // ajustar barra de pesquisa
          child: SearchAnchor(
            searchController: _searchController,
            builder: (BuildContext context, SearchController controller) {
              return SearchBar(
                controller: controller,
                hintText: 'Buscar produto...',
                padding: const WidgetStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 16),
                ),
                leading: const Icon(Icons.search),
                onChanged: (_) => controller.openView(),
              );
            },
            // provisorio somente para demonstra funcionamento da pagina
            suggestionsBuilder: (BuildContext context, SearchController controller){
              final tet = controller.text.toLowerCase();
              final sugestoes = _produtos.where((f) => f.toLowerCase().contains(tet)).toList();

              return List<Widget>.generate(
                sugestoes.length,
                  (int index){
                  final produto = sugestoes[index];
                  return ListTile(
                    title: Text(produto),
                    onTap: (){
                      controller.closeView(produto);
                    },
                  );
                  }
              );
            },
          ),
        ),
        // container com Carousell de promos
        Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                child: Text('Promoções!', style: TextStyle(fontSize: 30),),
                alignment: Alignment.centerLeft,
              ),
              SizedBox(height: 20),
              // trabalhar com elementos adicionar altura para especificar o status
              SizedBox(
                height: 200,
              // adicionar uma linha divisoria?
              child: CarouselView(
                  itemExtent: MediaQuery.of(context).size.width*0.8,
                  shrinkExtent: 0.9,
                  children: _imagensProv.map((url){
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(url, fit: BoxFit.cover, loadingBuilder: (context, child, progress){
                        if (progress==null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                      ),
                    );
                  }).toList(),
              )
              ),
            ],
          ),
        ),
        Container(
          height: 80,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Card(),
              SizedBox(width: 12),
            ],
          ),
        )
      ],
    );
  }
}