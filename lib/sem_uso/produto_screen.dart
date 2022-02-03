import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pedidos/providers/recebimentos.dart';
import 'package:pedidos/utils/app_routes.dart';
import 'package:pedidos/widgets/app_drawer.dart';
import 'package:pedidos/sem_uso/product_item_widget.dart';

class ProdutoScreen extends StatelessWidget {
  // colocado a async e await
  Future<void> _refreshProducts(BuildContext context) async {
    return await Provider.of<Recebimentos>(context, listen: false)
        .loadRecebimentos();
  }

  @override
  Widget build(BuildContext context) {
    final Recebimentos productsData = Provider.of(context);
    final products = productsData.items;

    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciar Produtos'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // poderia usar .then(() => ) no final com retorno de pop
              Navigator.of(context).pushNamed(AppRoutes.PRODUCT_FORM);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () {
          return _refreshProducts(context);
        },
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemBuilder: (ctx, i) => Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                //ProductItem(products[i]),
                SizedBox(
                  height: 10,
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
            itemCount: productsData.itemsCount,
          ),
        ),
      ),
    );
  }
}
