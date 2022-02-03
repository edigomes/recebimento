import 'package:flutter/material.dart';
import 'package:pedidos/providers/recebimento.dart';
import 'package:pedidos/providers/produto.dart';
import 'package:pedidos/widgets/produto_list_item.dart';
import 'package:provider/provider.dart';
import 'package:pedidos/providers/recebimentos.dart';
import 'package:pedidos/widgets/recebimento_list_item.dart';
import 'package:pedidos/utils/constants.dart';

// Lista em forma de grade

class ProdutoList extends StatelessWidget {
  //final bool showFavoriteOnly;
  ProdutoList({this.produtoItems, this.recebimento});
  List<Produto> produtoItems;
  Recebimento recebimento;

  @override
  Widget build(BuildContext context) {
    List<Produto> produtos = produtoItems;
    //final pedidos =
    //fornecedorProvider.pedidos; // Lista de produtos filtrada ou não

    return Expanded(
      child: ListView.separated(
        itemBuilder: (context, index) {
          return ChangeNotifierProvider.value(
            value: produtos[index],
            child: ProdutoListItem(
              produto: produtos[index],
              recebimento: recebimento,
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(height: 1.2, indent: 1.0);
        },
        itemCount: produtos.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
      ),
    );
  }
}
