import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:pedidos/providers/recebimento.dart';
import 'package:pedidos/views/search_widget.dart';
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

  bool bRecebimentosSearch = false;

  // passado p RecebimentoList (param) p foco no TextField de lá
  FocusNode _focusNodeSearcher;

  TextEditingController controller = TextEditingController();

//----------------------------------------------------------------------------
  // Aqui é usado "id" do respectivo recebimento
  Future<void> _refreshRecebimentos() async {
    _isLoading = true;
    await Provider.of<Recebimentos>(context, listen: false)
        .loadRecebimentos()
        .then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

//----------------------------------------------------------------------------
// Para searcher
  void onChanged({String inputText}) async {
    await Provider.of<Recebimentos>(context, listen: false)
        .loadRecebimentos(searchQuery: inputText)
        .then((value) {
      setState(() {
        _isLoading = false;
      });
    });

    print(_isLoading);
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

    // Onde conecta esse contexto ao contexto do main (ctx)
    return Scaffold(
      appBar: AppBar(
        title: bRecebimentosSearch
            ? TextField(
                cursorColor: Colors.white,
                controller: controller,
                autofocus: bRecebimentosSearch,
                decoration: const InputDecoration(
                  hintText: 'Pesquisar',
                  border: InputBorder.none,
                  hintStyle: const TextStyle(color: Colors.white30),
                ),
                style: const TextStyle(color: Colors.white, fontSize: 16.0),
                onSubmitted: (inputText) {
                  onChanged(inputText: inputText);
                },
                onChanged: (String inputText) async {
                  print('input >>> ' + inputText.length.toString());

                  EasyDebounce.cancelAll();

                  _isLoading = true;

                  if (inputText.length < 1) {
                    EasyDebounce.debounce(
                      'my-debouncer',
                      Duration(milliseconds: 2000),
                      () {
                        onChanged(inputText: null);
                      },
                    );
                  }
                  if (inputText.length > 0) {
                    EasyDebounce.debounce(
                      'my-debouncer',
                      Duration(milliseconds: 2000),
                      () {
                        onChanged(inputText: inputText);
                      },
                    );
                  }
                  print(_isLoading);
                },
              )
            : Text('Recebimentos'),
        actions: <Widget>[
          IconButton(
            icon: bRecebimentosSearch ? Icon(Icons.close) : Icon(Icons.search),
            onPressed: () {
              print('1');
              bRecebimentosSearch = !bRecebimentosSearch;
              setState(() {});
              print('2');
              _focusNodeSearcher.requestFocus();
              print('3');
              _refreshRecebimentos();
              print('4');
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () async {
          await _refreshRecebimentos();
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
                      //focusNodeSearcher: _focusNodeSearcher,
                      ),
            ],
          ),
        ),
      ),
    );
  }
}
