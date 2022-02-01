import 'package:flutter/material.dart';
import 'package:pedidos/providers/pedido.dart';
import 'package:pedidos/providers/pedidos.dart';
import 'package:pedidos/providers/produto.dart';
import 'package:provider/provider.dart';

class ProdutoScreen extends StatefulWidget {
  @override
  _ProdutoScreenState createState() => _ProdutoScreenState();
}

class _ProdutoScreenState extends State<ProdutoScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // "listen = false" pq vai ficar por initState
    Provider.of<Pedidos>(context, listen: false).loadProducts().then(
      (_) {
        setState(
          () {
            _isLoading = false;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Produto produto = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Conferir Item #" + produto.cod.toString()),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('favoritos'),
                value: null,
              ),
              PopupMenuItem(
                child: Text('todos'),
                value: null,
              ),
            ],
            onSelected: null,
          ),
        ],
      ),
      // body junto com _isLoading
      body: ListView(
        children: [
          Card(
            margin: EdgeInsets.all(12),
            elevation: 4,
            child: Column(
              children: [
                Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(produto.imageUrl),
                    ),
                    title: Text(produto.title),
                    subtitle: Text(produto.cod.toString()),
                  ),
                  elevation: 4,
                  margin: EdgeInsets.only(
                    top: 12,
                    left: 12,
                    right: 12,
                    bottom: 6,
                  ),
                ),
                //Container(
                // margin: EdgeInsets.only(top: 0.5),
                //padding: EdgeInsets.only(top: 0.5),
                //),
                Card(
                  elevation: 4,
                  margin: EdgeInsets.only(
                    left: 12,
                    right: 12,
                    bottom: 6,
                  ),
                  child: Container(
                    margin: EdgeInsetsDirectional.all(8),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.add_box),
                                    Container(
                                        margin: EdgeInsetsDirectional.only(
                                            end: 12)),
                                    Text(
                                      "015",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "CX",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    //
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.add),
                                    ),
                                    //
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.remove),
                                    ),
                                  ],
                                )
                                //
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.add),
                            Container(
                                margin: EdgeInsetsDirectional.only(end: 12)),
                            Text(
                              "150",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Card(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
