import 'package:flutter/material.dart';
import 'package:pedidos/providers/pedido.dart';
import 'package:pedidos/providers/pedidos.dart';
import 'package:pedidos/widgets/produto_list.dart';
import 'package:pedidos/widgets/produto_list_item.dart';
import 'package:provider/provider.dart';

class PedidoScreen extends StatefulWidget {
  final Pedido pedido;

  const PedidoScreen({Key key, this.pedido}) : super(key: key);

  @override
  _PedidoScreenState createState() => _PedidoScreenState();
}

class _PedidoScreenState extends State<PedidoScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // "listen = false" pq vai ficar por initState
    Provider.of<Recebimentos>(context, listen: false)
        .loadProdutos(widget.pedido.id)
        .then(
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
    // Argumentos rota
    Pedido pedido = ModalRoute.of(context).settings.arguments;
    // Provider
    final provider = Provider.of<Recebimentos>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("#" + pedido.id.toString()),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
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
      body: Container(
        margin: EdgeInsetsDirectional.only(
          top: 20,
          start: 5,
          end: 5,
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                //top: 6.0,
                bottom: 18.0,
                left: 20.0,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pedido.nomeFornecedor,
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    pedido.notaFiscal.toString(),
                    style: TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    pedido.dataPedido,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : ProdutoList(provider.produtoItems),
          ],
        ),
      ),
    );
  }
}
