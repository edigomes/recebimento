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
    final pedidoProvider = Provider.of<Pedidos>(context); // Provider
    final Pedido pedido = Pedido();
    //final pedidos =
    //fornecedorProvider.pedidos; // Lista de produtos filtrada ou não

    return ListView.builder(
      itemBuilder: (context, index) {
        return ChangeNotifierProvider.value(
          value: pedidoProvider.items[index],
          child: ProductListItem(pedido),
        );
      },
      itemCount: pedidoProvider.items.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
    );

    /*return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        // Precisa da localização do changeNotify
        //mesma classe em cada product na lista de products
        // Abaixo, product para cada ítem da lista
        value: products[i], // value tem inst do Prov. na lista.
        // itemBuilder é executado até o fim da lista
        // E, talvez, o que vai diferenciar um de cada é value, pois era por construtor
        child: ProductGridItem(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
    */
  }
}
