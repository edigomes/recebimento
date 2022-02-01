import 'package:flutter/material.dart';
import 'package:pedidos/providers/pedido.dart';
import 'package:pedidos/providers/produto.dart';
import 'package:pedidos/widgets/produto_list_item.dart';
import 'package:provider/provider.dart';
import 'package:pedidos/providers/pedidos.dart';
import 'package:pedidos/widgets/pedido_list_item.dart';

// Lista em forma de grade

class ProdutoList extends StatelessWidget {
  //final bool showFavoriteOnly;
  ProdutoList(this.pedido);
  Pedido pedido;

  @override
  Widget build(BuildContext context) {
    List<Produto> produtos = pedido.produtos;
    //final pedidos =
    //fornecedorProvider.pedidos; // Lista de produtos filtrada ou não

    return ListView.builder(
      itemBuilder: (context, index) {
        return ChangeNotifierProvider.value(
          value: produtos[index],
          child: ProdutoListItem(produtos[index]),
        );
      },
      itemCount: produtos.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
    );
  }
}
