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
class RecebimentoOverviewScreen extends StatefulWidget {
  @override
  _RecebimentoOverviewScreenState createState() =>
      _RecebimentoOverviewScreenState();
}

class _RecebimentoOverviewScreenState extends State<RecebimentoOverviewScreen> {
  bool _showFavoriteOnly = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // "listen = false" pq vai ficar por initState
    Provider.of<Recebimentos>(context, listen: false).loadRecebimentos().then(
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
        ],
      ),
      drawer: AppDrawer(),
      body: Container(
        margin: EdgeInsetsDirectional.all(16.0),
        child: Column(
          children: [
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : PedidoList(),
          ],
        ),
      ),
    );
  }
}
