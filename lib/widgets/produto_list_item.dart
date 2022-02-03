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
        //leading: CircleAvatar(
        //backgroundImage: NetworkImage(product.imageUrl), //(product.imageUrl),
        //),
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
            print(produto.quant);
          },
        ),
      ),
    );

    /*
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          onTap: () {
            // INCRÍVEL!
            // ctx deve se conectar com o contexto de product detail screen
            Navigator.of(context).pushNamed(
              AppRoutes.PRODUCT_DETAIL,
              arguments: product,
            );
          },
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border),
              color: Theme.of(context).accentColor,
              onPressed: () async {
                try {
                  product.toggleFavorite(auth.token, auth.userId);
                } on HttpException catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        error.toString(),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          // Não precisa de Consumer pq n tem mudança visual
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Produto adicionado com sucesso ! '),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'DESFAZER',
                    onPressed: () => cart.removeSingleItem(product.id),
                  ),
                ),
              );
              cart.addItem(
                  product); // putIfAbsent adiciona e notifica para que cart_screen puxe a lista
              // update modifica o que já tem. Tudo através da lista.
            },
          ),
        ),
      ),
    );*/
  }
}
