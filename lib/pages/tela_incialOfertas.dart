import 'package:carousel_slider/carousel_slider.dart' as cs;
import 'package:confeitaria_app/Models/categoria.dart';
import 'package:confeitaria_app/Models/produto.dart';
import 'package:confeitaria_app/db/CategoriaDao.dart';
import 'package:confeitaria_app/db/ProdutoDao.dart';
import 'package:confeitaria_app/db/clienteDAO.dart';
import 'package:confeitaria_app/pages/tela_login.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TelaIncialOferta extends StatefulWidget {
  const TelaIncialOferta({super.key});

  @override
  State<TelaIncialOferta> createState() => _TelaIncialOfertaState();
}

class _TelaIncialOfertaState extends State<TelaIncialOferta> {
  final SearchController _searchController = SearchController();
  final PageController _pageControl = PageController(
    initialPage: 0,
    viewportFraction: 0.7,
  );

  late Future<List<Categoria>> _futureCategorias;
  int? categoriaSelecionada;
  int? paginaAtual = 0;
  int activetedPromo = 0;
  final ValueNotifier<int> promoIndex = ValueNotifier(0);
  // alterar para lista produtos atráves do banco de dados conforme digitado
  final List<String> _produtos = ['bolo', 'torta', 'salgado', 'etc'];
  final List<String> _imagensProv = [
    'https://picsum.photos/200/300',
    'https://picsum.photos/200/300',
    'https://picsum.photos/200/300',
    'https://picsum.photos/200/300',
    'https://picsum.photos/200/300',
  ];
  @override
  void initState(){
    super.initState();
        _futureCategorias = CategoriaDAO.listarCategoria();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F3),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // container usuario é marca
          Container(
            //width: MediaQuery.of(context).size.width*0.9,
            // mudar para metodo que identifica se o usuario está logado ou não
            padding: const EdgeInsets.all(24),
            child: Row(
              spacing: 20,
              children: [
                FutureBuilder(
                  future: ClienteDAO.clientePresente(),
                  builder: (context, snapshot){
                    if(snapshot.data == true){
                     return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Color(0xFFF6Bcb3),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              iconSize: 30,
                             onPressed: ()
                             {},
                             icon: Icon(Icons.person),
                            ),
                            Text('Seja bem vindo', style: TextStyle(fontSize: 24))
                          ],
                        ),
                      );
                    } else{
                      return TextButton(onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TelaLogin()));
                      }, child: Text('Aperte aqui para entrar na sua conta!', style: TextStyle(fontSize: 20, color: Colors.black),));
                    }
                  }
                )
                /*IconButton(
                  iconSize: 50,
                  onPressed: () {},
                  icon: Icon(Icons.notifications),
                ),*/
              ],
            ),
          ),
          //container barra de pesquisa
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
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
              suggestionsBuilder:
                  (BuildContext context, SearchController controller) {
                    final tet = controller.text.toLowerCase();
                    final sugestoes = _produtos
                        .where((f) => f.toLowerCase().contains(tet))
                        .toList();

                    return List<Widget>.generate(sugestoes.length, (int index) {
                      final produto = sugestoes[index];
                      return ListTile(
                        title: Text(produto),
                        onTap: () {
                          controller.closeView(produto);
                        },
                      );
                    });
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
                  alignment: Alignment.centerLeft,
                  child: Text('Promoções!', style: TextStyle(fontSize: 30)),
                ),
                SizedBox(height: 5),
                // trabalhar com elementos adicionar altura para especificar o status
                Column(
                  children: [
                    cs.CarouselSlider.builder(
                        options: cs.CarouselOptions(
                          height: 180,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          enlargeStrategy: cs.CenterPageEnlargeStrategy.height,
                          autoPlayInterval: Duration(seconds: 2),
                          onPageChanged: (index, reason) {
                            promoIndex.value = index;
                          }
                        ),
                        itemCount: _imagensProv.length,
                      itemBuilder: (context, index, realIndex){
                          final urlImage = _imagensProv[index];
                          return buildImage (urlImage, index);
                      },
                    ),
                    const SizedBox(height: 5,),
                    buildIndicator()
                  ],
                )
              ],
            ),
          ),
          Divider(height: 1, color: Colors.black),
          SizedBox(height: 8),

          // List view de categorias com botão tipo chips sempre defini altura se não o list view buga.
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: 40,
              child: FutureBuilder<List<Categoria>>(
                future: _futureCategorias,
                builder: (context, snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError){
                    return Text('Erro: ${snapshot.error}');
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty){
                    return const Text('Nenhuma categoria');
                  }
                  final categorias = snapshot.data!;
                  
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding:  const EdgeInsets.symmetric(horizontal: 8),
                    itemCount: categorias.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8,),
                    itemBuilder: (context, index) {
                      final categoria = categorias[index];
                      final bool isSelected = categoriaSelecionada == categoria.id;

                      return InputChip(label: Text(categoria.nome ?? '', style: TextStyle(color: Colors.white),),
                        selected: isSelected,
                        showCheckmark: false,
                        onSelected: (_){
                          setState(() => categoriaSelecionada = categoria.id);
                        },
                        backgroundColor: const Color(0x80E4A663),
                        selectedColor: const Color(0xFFFFC0CB),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        elevation: isSelected ? 2 : 0,
                        shadowColor: Colors.black26,
                      );
                    },
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 5),


          //teste apresentação de produtos 1 // melhor somente ajustar para ficar dinamico
          SizedBox(
            height: 280,
            child: FutureBuilder<List<Produto>>(
              future: categoriaSelecionada == null ? null : ProdutoDAO.listarProdutoporCategoria(categoriaSelecionada),
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError){
                  return Text('Erro: ${snapshot.error}');
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty){
                  return const Text('Nenhuma Produto');
                }
                final produtos = snapshot.data!;

                return PageView.builder(
                  controller: _pageControl,
                  itemCount: produtos.length,
                    onPageChanged: (index){ setState(() => paginaAtual = index);},
                  itemBuilder: (context, index){
                    final produto = produtos[index];
                    final ativo = index == paginaAtual;
                    return AnimatedScale( scale: ativo? 1.0 : 0.85,
                        duration: const Duration(milliseconds: 300),
                        child: _cardProduto(produto, ativo));
                  }
                );
              }
            ),
          )
        ],
      ),
    );
  }
  Widget _cardProduto(Produto produto,bool ativo){
    return Card(
      elevation: ativo? 6:2,
      color: Color(0xFFFFC0CB),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(padding: const EdgeInsets.all(12), child: Container(
        child: Column( children: [
          Expanded(flex: 5, child: Text('Imagem')),
          Expanded(child: Column(children: [
            Text(produto.nome.toString()),
            SizedBox(height: 5,),
            SizedBox(height: 60, child: SingleChildScrollView(child: Text(produto.descricao.toString()),))
          ],), flex: 4,),
          Expanded(child:
            Row(
              children: [
                Text('${produto.preco}'),
                ElevatedButton(onPressed: (){
                  ProdutoDAO.itensPedidos(produto, 1);
                }, child: Text("${produto.nome}"))
              ],
            ), flex: 2,)
        ],)
      ),),
    );
  }
  Widget buildImage(String urlImage, int index) => Container(
    margin: EdgeInsets.symmetric(horizontal: 5),
    color: Colors.grey,
    width: double.infinity,
    child: Image.network(urlImage, fit: BoxFit.cover,),
  );
  Widget buildIndicator() {
    return ValueListenableBuilder<int>(
      valueListenable: promoIndex,
      builder: (_, value, _){
        return AnimatedSmoothIndicator(activeIndex: value, count: _imagensProv.length, effect: WormEffect(),);
      },
    );
  }
}
