import 'dart:html';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
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
                    margin: EdgeInsetsDirectional.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.add_box),
                                Container(
                                    margin:
                                        EdgeInsetsDirectional.only(end: 12)),
                                Text(
                                  "015",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Expanded(
                              child: SizedBox(
                                width: 30,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
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
                                )
                                //
                              ],
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 6),
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
                            Expanded(
                              child: SizedBox(
                                width: 30,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "UN",
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
                                )
                                //
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 4,
                  margin: EdgeInsets.only(
                    left: 12,
                    right: 12,
                    bottom: 12,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              top: 8,
                              left: 6,
                              bottom: 12,
                            ),
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text("+ PARCIAL"),
                              //style: ButtonStyle(padding: MaterialStateProperty.),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              top: 16,
                              bottom: 3,
                              left: 6,
                            ),
                            child: Text("Parciais"),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.all(6),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.archive),
                                Text("25"),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.archive),
                                Text("50"),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.archive),
                                Text("75"),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.all(8),
                            child: Icon(MdiIcons.barcode),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 6),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(8),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    labelText: "Entre o código de barras"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}