import 'dart:io';

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
    Provider.of<Recebimentos>(context, listen: false).loadRecebimentos().then(
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
          Column(
            children: [
              //--------------------------------------------------------------
              Card(
                child: ListTile(
                  title: Text(
                    produto.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
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
              //--------------------------------------------------------------
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
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "CX",
                                  style: TextStyle(fontSize: 20),
                                ),
                                Container(
                                    margin:
                                        EdgeInsetsDirectional.only(end: 12)),
                                Text(
                                  "015",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
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
                                Container(
                                  margin: EdgeInsets.all(18),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.add),
                                ),
                                Container(
                                  margin: EdgeInsets.all(15),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.remove),
                                )
                                //
                              ],
                            ),
                          ],
                        ),
                        margin: EdgeInsets.only(right: 20),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 12),
                      ),
                      Row(
                        children: [
                          //Icon(Icons.plus_one),
                          Text(
                            "UN",
                            style: TextStyle(fontSize: 20),
                          ),
                          Container(
                              margin: EdgeInsetsDirectional.only(end: 12)),
                          Text(
                            "150",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Expanded(
                            child: SizedBox(
                              width: 30,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(17),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.add),
                                ),
                                Container(
                                  margin: EdgeInsets.all(15),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.remove),
                                )
                                //
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              //--------------------------------------------------------------
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
                          margin: EdgeInsets.only(right: 6),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(bottom: 16, right: 8),
                            child: TextField(
                              autofocus: true,
                              decoration: InputDecoration(
                                hintText: "Entre o código de barras",
                                prefixIcon: Icon(MdiIcons.barcode),
                              ),
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
        ],
      ),
    );
  }
}
