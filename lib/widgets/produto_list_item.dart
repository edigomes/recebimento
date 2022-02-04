import 'package:flutter/material.dart';
import 'package:pedidos/providers/recebimento.dart';
import 'package:pedidos/providers/produto.dart';
import 'package:pedidos/providers/recebimentos.dart';
import 'package:provider/provider.dart';
import 'package:pedidos/exceptions/http_exception.dart';
import 'package:pedidos/providers/auth.dart';
import 'package:pedidos/sem_uso/cart.dart';
import 'package:pedidos/utils/app_routes.dart';
import '../sem_uso/cart.dart';

// Formato dos produtos do app, com foto e interações em stack,
//como favorito e add carrinho ao lado.

class ProdutoListItem extends StatelessWidget {
  Produto produto;
  Recebimento recebimento;

  ProdutoListItem({this.produto, this.recebimento});

  @override
  Widget build(BuildContext context) {
    Recebimentos recebimentosProvider =
        Provider.of<Recebimentos>(context, listen: false);

    return Card(
      elevation: 1.0,
      child: ListTile(
        title: Container(
          margin: EdgeInsets.only(
            bottom: 6.0,
          ),
          child: Text(
            produto.title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        subtitle: Text('ID: ${produto.cod}' +
            ' | ' +
            'Qtde: ${produto.quant.toString()} KG'),
        trailing: IconButton(
          icon: Icon(Icons.navigate_next),
          onPressed: () {
            Navigator.of(context)
                .pushNamed(
                  AppRoutes.SCREEN_PRODUTO,
                  arguments: produto,
                )
                .then((value) async =>
                    await recebimentosProvider.loadProdutos(recebimento.id));
            recebimentosProvider.bProdutosSearch = false;
          },
        ),
      ),
    );
  }
}
