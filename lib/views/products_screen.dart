import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pedidos/providers/pedidos.dart';
import 'package:pedidos/utils/app_routes.dart';
import 'package:pedidos/widgets/app_drawer.dart';
import 'package:pedidos/widgets/product_item.dart';

class ProductsScreen extends StatelessWidget {
  Future<void> _refreshProducts(BuildContext context) {
    return Provider.of<Pedidos>(context, listen: false).loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final Pedidos productsData = Provider.of(context);
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
