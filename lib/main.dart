import 'package:flutter/material.dart';
import 'package:pedidos/views/recebimento_detail_screen.dart';
import 'package:pedidos/views/produto_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:pedidos/sem_uso/cart.dart';
import 'package:pedidos/sem_uso/orders.dart';
import 'package:pedidos/providers/recebimentos.dart';
import 'package:pedidos/utils/app_routes.dart';
import 'package:pedidos/providers/auth.dart';
import 'package:pedidos/sem_uso/cart_screen.dart';
import 'package:pedidos/sem_uso/orders_screen.dart';
import 'package:pedidos/sem_uso/product_detail_screen.dart';
import 'package:pedidos/sem_uso/product_form_screen.dart';
import 'package:pedidos/views/recebimento_overview_screen.dart';
import 'package:pedidos/sem_uso/produto_screen.dart';
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
        ChangeNotifierProxyProvider<Auth, Recebimentos>(
          create: (ctx) {
            return Recebimentos();
          },
          // Só preciso saber qual o momento q o token vai mudar
          update: (ctx, auth, previousProducts) {
            return Recebimentos(
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
          AppRoutes.HOME: (ctx) => RecebimentoOverviewScreen(),
          AppRoutes.CART: (ctx) => CartScreen(),
          AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailScreen(),
          AppRoutes.ORDERS: (ctx) => OrdersScreen(),
          //AppRoutes.PRODUCTS: (ctx) => ProductsScreen(),
          AppRoutes.PRODUCT_FORM: (ctx) => ProductFormScreen(),
          AppRoutes.SCREEN_RECEBIMENTO_DETAIL: (ctx) => RecebimentoDetailScreen(
              recebimento: ModalRoute.of(ctx).settings.arguments),
          AppRoutes.SCREEN_PRODUTO: (ctx) => RecebimentoDetail(),
        },
      ),
    );
  }
}
