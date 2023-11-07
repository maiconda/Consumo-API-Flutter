import 'package:assincrona/data/http/http_client.dart';
import 'package:assincrona/data/repositories/produto_repository.dart';
import 'package:assincrona/pages/stores/produto_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ProdutoStore store = ProdutoStore(
      repository: ProdutoRepository(
    client: HttpClient(),
  ));

  @override
  void initState() {
    super.initState();
    store.getProdutos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Consumo de API'),
        ),
      ),
      body: AnimatedBuilder(
        animation: Listenable.merge([
          store.isLoading,
          store.error,
          store.state,
        ]),
        builder: (context, child) {
          if (store.isLoading.value) {
            return const CircularProgressIndicator();
          }

          if (store.error.value.isNotEmpty) {
            return Center(
              child: Text(
                store.error.value,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }

          if (store.state.value.isEmpty) {
            return Center(
              child: Text(
                'Nenhum item na lista',
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            );
          } else {
            return ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                      height: 20,
                    ),
                padding: EdgeInsets.all(16),
                itemCount: store.state.value.length,
                itemBuilder: (_, index) {
                  final item = store.state.value[index];
                  return Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: ClipRRect(
                            child: Image.network(
                              item.thumbnail,
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 200,
                          width: double.infinity,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          item.title,
                          textAlign: TextAlign.left,
                          // Texto alinhado à esquerda
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 23),
                        ),
                        Text(
                          'R\$ ${item.price.toString()}0',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.green,
                              fontSize: 19),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          item.description,
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.grey[800],
                              fontSize: 15),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(11),
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}
