import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pedidos/providers/recebimento.dart';
import 'package:pedidos/providers/recebimentos.dart';
import 'package:pedidos/widgets/produto_list.dart';
import 'package:pedidos/widgets/produto_list_item.dart';
import 'package:provider/provider.dart';

// No momento que esta tela é executada a lista de produtos (que vem de
//"Recebimentos") é filtrada de acordo com o id do recebimento. Logo, enquanto
//ficar nesta tela, a lista é filtrada.

class RecebimentoDetailScreen extends StatefulWidget {
  final Recebimento recebimento; // vindo por modalroute em main

  const RecebimentoDetailScreen({Key key, this.recebimento}) : super(key: key);

  @override
  _RecebimentoDetailScreenState createState() =>
      _RecebimentoDetailScreenState();
}

class _RecebimentoDetailScreenState extends State<RecebimentoDetailScreen> {
  bool _isLoading = true;

  // passado p ProdutoList (por param) p o foco no TextField de lá
  FocusNode _focusNodeSearcher;

  //----------------------------------------------------------------------------
  // Aqui é usado "id" do respectivo recebimento
  Future<void> _refreshProdutos(BuildContext context, id) async {
    await Provider.of<Recebimentos>(context, listen: false).loadProdutos(id);
  }
  //----------------------------------------------------------------------------

  @override
  void initState() {
    super.initState();
    Provider.of<Recebimentos>(context, listen: false)
        .loadProdutos(widget.recebimento.id)
        .then(
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
    // Argumentos rota
    //Recebimento recebimento = ModalRoute.of(context).settings.arguments;
    // Provider
    final providerRecebimentos = Provider.of<Recebimentos>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("#" + widget.recebimento.id.toString()),
        actions: [
          IconButton(
            icon: providerRecebimentos.bProdutosSearch
                ? Icon(Icons.close)
                : Icon(Icons.search),
            onPressed: () {
              providerRecebimentos.bProdutosSearch =
                  !providerRecebimentos.bProdutosSearch;

              _focusNodeSearcher.requestFocus();

              setState(() {});
            },
          ),
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('favoritos'),
                value: null,
              ),
              PopupMenuItem(
                child: Text('todos'),
                value: null,
              ),
            ],
            onSelected: null,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _isLoading = true;
          await _refreshProdutos(context, widget.recebimento.id)
              .then((value) => _isLoading = false);
        },
        child: Container(
          margin: EdgeInsetsDirectional.only(
            top: 20,
            start: 5,
            end: 5,
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  //top: 6.0,
                  bottom: 18.0,
                  left: 20.0,
                ),
                alignment: AlignmentDirectional.centerStart,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.recebimento.nomeFornecedor,
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Text(
                      'NF:  ' + widget.recebimento.notaFiscal.toString(),
                      style: TextStyle(fontSize: 16.0),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      'Data:  ' +
                          DateFormat('dd/MM/yyyy')
                              .format(widget.recebimento.dataPedido),
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ProdutoList(
                      produtoItems: providerRecebimentos.produtoItems,
                      recebimento: widget.recebimento,
                      focusNodeSearcher: _focusNodeSearcher,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
