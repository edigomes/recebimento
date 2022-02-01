import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pedidos/providers/cart.dart';
import 'package:pedidos/providers/pedidos.dart';
import 'package:pedidos/widgets/app_drawer.dart';
import 'package:pedidos/widgets/badge.dart';
import 'package:pedidos/widgets/pedido_list.dart';
import '../utils/app_routes.dart';

enum FilterOptions {
  Favorite,
  All,
}

// Tela mostrando lista de produtos
class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _showFavoriteOnly = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // "listen = false" pq vai ficar por initState
    Provider.of<Pedidos>(context, listen: false).loadProducts().then(
      (_) {
        setState(
          () {
            _isLoading = false;
          },
        );
      },
    );
  }
  // ao voltar n executa o build pois espera

  @override
  Widget build(BuildContext context) {
    // Onde conecta esse contexto ao contexto do main (ctx)
    return Scaffold(
      appBar: AppBar(
        title: Text('Recebimentos'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          Consumer<Cart>(
            // Em relação ao Consumer, child é o que não vai ser modificado
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.CART);
              },
            ),

            // O que vai ser modificado:
            builder: (ctx, cart, child) => Badge(
              value: cart.itemsCount.toString(),
              child: child,
            ),
          ),
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('favoritos'),
                value: FilterOptions.Favorite,
              ),
              PopupMenuItem(
                child: Text('todos'),
                value: FilterOptions.All,
              ),
            ],
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorite) {
                  _showFavoriteOnly = true;
                } else {
                  _showFavoriteOnly = false;
                }
              });
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Container(
        margin: EdgeInsetsDirectional.all(16.0),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 6.0,
                bottom: 24.0,
                left: 20.0,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                "hoje",
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : PedidoList(),
          ],
        ),
      ),
    );
  }
}
