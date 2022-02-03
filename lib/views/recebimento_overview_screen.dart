import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pedidos/sem_uso/cart.dart';
import 'package:pedidos/providers/recebimentos.dart';
import 'package:pedidos/widgets/app_drawer.dart';
import 'package:pedidos/sem_uso/badge.dart';
import 'package:pedidos/widgets/recebimento_list.dart';
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
  bool _isLoading = true;

//----------------------------------------------------------------------------
  // Aqui é usado "id" do respectivo recebimento
  Future<void> _refreshRecebimentos(BuildContext context) async {
    await Provider.of<Recebimentos>(context, listen: false).loadRecebimentos();
  }
  //----------------------------------------------------------------------------

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
      body: RefreshIndicator(
        onRefresh: () async {
          _isLoading = true;
          await _refreshRecebimentos(context)
              .then((value) => _isLoading = false);
        },
        child: Container(
          margin: EdgeInsetsDirectional.all(16.0),
          child: Column(
            children: [
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : RecebimentoList(),
            ],
          ),
        ),
      ),
    );
  }
}
