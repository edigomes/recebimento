import 'package:flutter/material.dart';
import 'package:pedidos/providers/recebimento.dart';
import 'package:provider/provider.dart';
import 'package:pedidos/providers/recebimentos.dart';
import 'package:pedidos/widgets/recebimento_list_item.dart';

// Lista em forma de grade

class RecebimentoList extends StatelessWidget {
  //final bool showFavoriteOnly;

  //const ProductGrid(this.showFavoriteOnly);

  @override
  Widget build(BuildContext context) {
    final pedidoProvider = Provider.of<Recebimentos>(context); // Provider
    final Recebimento pedido = Recebimento();
    //final pedidos =
    //fornecedorProvider.pedidos; // Lista de produtos filtrada ou não

    return Expanded(
      child: ListView.separated(
        itemCount: pedidoProvider.items.length,
        itemBuilder: (context, index) {
          return ChangeNotifierProvider.value(
            value: pedidoProvider.items[index],
            child: RecebimentoListItem(pedido),
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
