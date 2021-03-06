import 'dart:io';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pedidos/providers/recebimento.dart';
import 'package:pedidos/providers/recebimentos.dart';
import 'package:pedidos/providers/produto.dart';
import 'package:provider/provider.dart';
import 'package:searchable_listview/searchable_listview.dart';

class RecebimentoDetail extends StatefulWidget {
  @override
  _RecebimentoDetailScreenState createState() =>
      _RecebimentoDetailScreenState();
}

class _RecebimentoDetailScreenState extends State<RecebimentoDetail> {
  bool _isLoading = true;
  bool textFieldAutoFocus = true;

  int qtdPorCaixa = 10;
  int qtdUn = 0;
  int qtdCx = 0;

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
                  subtitle: Text('ID: ' + produto.cod.toString()),
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
                        margin: EdgeInsets.only(right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.add_box),
                                Container(
                                  margin: EdgeInsetsDirectional.only(end: 18),
                                ),
                                Text(
                                  qtdCx.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 23,
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
                                Text(
                                  "CX",
                                  style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey[100],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(10),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      this.qtdUn += this.qtdPorCaixa;
                                      this.qtdCx++;
                                    });
                                    print('CX: ' + qtdCx.toString());
                                    print('UN: ' + qtdUn.toString());
                                  },
                                  child: Icon(Icons.add, color: Colors.white),
                                  style: ElevatedButton.styleFrom(
                                    shape: CircleBorder(),
                                    padding: EdgeInsets.all(16),
                                    primary: Colors
                                        .cyanAccent[400], // <-- Button color
                                    onPrimary: Colors.red, // <-- Splash color
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(8),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    /*
                                    setState(() {
                                      this.qtdUn += this.qtdPorCaixa;
                                      this.qtdCx++;
                                    });
                                    print('CX: ' + qtdCx.toString());
                                    print('UN: ' + qtdUn.toString());
                                    */
                                  },
                                  child:
                                      Icon(Icons.remove, color: Colors.white),
                                  style: ElevatedButton.styleFrom(
                                    shape: CircleBorder(),
                                    padding: EdgeInsets.all(16),
                                    primary: Colors
                                        .cyanAccent[400], // <-- Button color
                                    onPrimary: Colors.red, // <-- Splash color
                                  ),
                                ),
                                //
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 12),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Icon(Icons.plus_one),
                            Container(
                                margin: EdgeInsetsDirectional.only(end: 18)),
                            Text(
                              qtdUn.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 23),
                            ),
                            Expanded(
                              child: SizedBox(
                                width: 30,
                              ),
                            ),
                            Text(
                              "UN",
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey[100],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(10),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        this.qtdUn++;
                                      });
                                      var resto =
                                          (this.qtdUn % this.qtdPorCaixa);
                                      print('RES: ' + resto.toString());
                                      if (resto == 0) {
                                        setState(() {
                                          this.qtdCx++;
                                        });
                                      }
                                    },
                                    child: Icon(Icons.add, color: Colors.white),
                                    style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(),
                                      padding: EdgeInsets.all(16),
                                      primary: Colors
                                          .cyanAccent[400], // <-- Button color
                                      onPrimary: Colors.red, // <-- Splash color
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(8),
                                  ),
                                  //
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        this.qtdUn++;
                                      });
                                      var resto =
                                          (this.qtdUn % this.qtdPorCaixa);
                                      print('RES: ' + resto.toString());
                                      if (resto == 0) {
                                        setState(() {
                                          this.qtdCx++;
                                        });
                                      }
                                    },
                                    child:
                                        Icon(Icons.remove, color: Colors.white),
                                    style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(),
                                      padding: EdgeInsets.all(16),
                                      primary: Colors
                                          .cyanAccent[400], // <-- Button color
                                      onPrimary: Colors.red, // <-- Splash color
                                    ),
                                  ),
                                  //
                                ],
                              ),
                            ),
                          ],
                        ),
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
                        // teste da lupa
                        //SearchableList(initialList: initialList, filter: filter, builder: builder, emptyWidget: , searchTextController: ,),
                        Container(
                          margin: EdgeInsets.all(12),
                          child: ElevatedButton(
                              onPressed: () {},
                              child: Container(
                                margin: EdgeInsets.all(12),
                                child: Text(
                                  "+ PARCIAL",
                                  style: TextStyle(fontSize: 18),
                                ),
                              )
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
                              autofocus: textFieldAutoFocus,
                              decoration: InputDecoration(
                                hintText: "Entre o c??digo de barras",
                                prefixIcon: Icon(MdiIcons.barcode),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5, right: 5, bottom: 5),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            child: RaisedButton(
                              onPressed: () {},
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: 12,
                                  bottom: 12,
                                  left: 20,
                                  right: 20,
                                ),
                                child: Text(
                                  'CONCLUIR',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                              color: Colors.cyanAccent[400],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 5),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            child: RaisedButton(
                              padding: EdgeInsets.all(1),
                              onPressed: () {},
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: 12,
                                  bottom: 12,
                                  left: 36,
                                  right: 36,
                                ),
                                child: Text(
                                  'ETIQUETAS',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                              color: Colors.deepPurple[900],
                            ),
                          ),
                        ],
                      ),
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
