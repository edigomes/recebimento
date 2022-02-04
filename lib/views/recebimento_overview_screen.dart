import 'package:flutter/material.dart';
import 'package:pedidos/providers/recebimento.dart';
import 'package:pedidos/sem_uso/search_widget.dart';
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

  // passado p RecebimentoList (param) p foco no TextField de lá
  FocusNode _focusNodeSearcher;

//----------------------------------------------------------------------------
  // Aqui é usado "id" do respectivo recebimento
  Future<void> _refreshRecebimentos(BuildContext context) async {
    await Provider.of<Recebimentos>(context, listen: false).loadRecebimentos();
  }

  //----------------------------------------------------------------------------

  @override
  void initState() {
    super.initState();
    Provider.of<Recebimentos>(context, listen: false).loadRecebimentos().then(
      (_) {
        setState(
          () {
            _isLoading = false;
          },
        );
      },
    );
    _focusNodeSearcher = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    Recebimentos providerRecebimentos = Provider.of<Recebimentos>(context);

    // preciso passar a var abaixo p o construtor do widget de TextForm
    List<Recebimento> provRecebList = providerRecebimentos.items;

    // Onde conecta esse contexto ao contexto do main (ctx)
    return Scaffold(
      appBar: AppBar(
        title: /*_bLupa
            ? SearchWidget(autoFocus: _bTextFieldAutoFocus)
            :*/
            Text('Recebimentos'),
        actions: <Widget>[
          IconButton(
            icon: providerRecebimentos.bRecebimentosSearch
                ? Icon(Icons.close)
                : Icon(Icons.search),
            onPressed: () async {
              // troca bool de lupa p seu valor oposto
              providerRecebimentos.bRecebimentosSearch =
                  !providerRecebimentos.bRecebimentosSearch;
              _focusNodeSearcher.requestFocus();
              /*if (!_bLupa) {
                await _refreshRecebimentos(context);
              }*/

              setState(() {});
            },
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
          margin: EdgeInsets.all(12),
          child: Column(
            children: [
              _isLoading
                  ? Center(
                      child: Container(
                        padding: EdgeInsets.only(top: 100),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : RecebimentoList(
                      focusNodeSearcher: _focusNodeSearcher,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
