import 'package:flutter/material.dart';
import 'package:pedidos/views/pedido_screen.dart';
import 'package:pedidos/views/produto_screen.dart';
import 'package:provider/provider.dart';
import 'package:pedidos/providers/cart.dart';
import 'package:pedidos/providers/orders.dart';
import 'package:pedidos/providers/pedidos.dart';
import 'package:pedidos/utils/app_routes.dart';
import 'package:pedidos/providers/auth.dart';
import 'package:pedidos/views/cart_screen.dart';
import 'package:pedidos/views/orders_screen.dart';
import 'package:pedidos/views/product_detail_screen.dart';
import 'package:pedidos/views/product_form_screen.dart';
import 'package:pedidos/views/product_overview_screen.dart';
import 'package:pedidos/views/products_screen.dart';
import 'package:pedidos/views/screen_for_auth.dart';
import '../utils/app_routes.dart';

// Existe 1 Provider com 2 ChangeNotifier (Product e ProductProvider)

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//------------------------------------------------------------------------------------------------------------------------------------

//PROVIDER

    return MultiProvider(
      // Reconstroi o abaixo

      providers: [
        // Já q Auth vem antes, ai dá print antes
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        //ProxyProvider precisar usar qm ta acima dele
        //Único método de fazer Providers conversarem entre si.
        //Precisa ter o "< >" pra "auth" fazer sentido com "Auth"
        ChangeNotifierProxyProvider<Auth, Pedidos>(
          create: (ctx) {
            print('create');
            return Pedidos();
          },
          // Só preciso saber qual o momento q o token vai mudar
          update: (ctx, auth, previousProducts) {
            return Pedidos(
              // "previous" deve ser obrigatório msm
              // No momento de colocar o "token", Products é reconstruído com "create" dnv, por isso precisa de "previous"
              auth.token,
              // O principal é passar o "token". Provider n tem "context", por isso faz aqui.
              previousProducts.items,
              auth.userId,
            );
          },
        ),

// provider comum:

        ChangeNotifierProvider(
          create: (ctx) {
            return Cart();
          },
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (ctx) => Orders(),
          update: (ctx, auth, previousOrders) {
            return Orders(
              auth.token,
              previousOrders.items,
              auth.userId,
            );
          },
        ),
      ],
//------------------------------------------------------------------------------------------------------------------------------------
      child: MaterialApp(
        title: 'Minha Loja',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        //home: AuthScreen(),
        routes: {
          //AppRoutes.AUTH: (ctx) => AuthScreen(),
          AppRoutes.SCREEN_FOR_AUTH: (ctx) => ScreenForAuth(),
          AppRoutes.HOME: (ctx) => ProductOverviewScreen(),
          AppRoutes.CART: (ctx) => CartScreen(),
          AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailScreen(),
          AppRoutes.ORDERS: (ctx) => OrdersScreen(),
          AppRoutes.PRODUCTS: (ctx) => ProductsScreen(),
          AppRoutes.PRODUCT_FORM: (ctx) => ProductFormScreen(),
          AppRoutes.SCREEN_PEDIDO: (ctx) => PedidoScreen(),
          AppRoutes.SCREEN_PRODUTO: (ctx) => ProdutoScreen(),
        },
      ),
    );
  }
}
