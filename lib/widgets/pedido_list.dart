import 'package:flutter/material.dart';
import 'package:pedidos/providers/pedido.dart';
import 'package:provider/provider.dart';
import 'package:pedidos/providers/pedidos.dart';
import 'package:pedidos/widgets/pedido_list_item.dart';

// Lista em forma de grade

class PedidoList extends StatelessWidget {
  //final bool showFavoriteOnly;

  //const ProductGrid(this.showFavoriteOnly);

  @override
  Widget build(BuildContext context) {
    final pedidoProvider = Provider.of<Recebimentos>(context); // Provider
    final Pedido pedido = Pedido();
    //final pedidos =
    //fornecedorProvider.pedidos; // Lista de produtos filtrada ou não

    return Expanded(
      child: ListView.separated(
        itemCount: pedidoProvider.items.length,
        itemBuilder: (context, index) {
          return ChangeNotifierProvider.value(
            value: pedidoProvider.items[index],
            child: ProductListItem(pedido),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(height: 1.2, indent: 1.0);
        },
        scrollDirection: Axis.vertical,
      ),
    );
  }
}
