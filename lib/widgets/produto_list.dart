import 'package:flutter/material.dart';
import 'package:pedidos/providers/recebimento.dart';
import 'package:pedidos/providers/produto.dart';
import 'package:pedidos/widgets/produto_list_item.dart';
import 'package:provider/provider.dart';
import 'package:pedidos/providers/recebimentos.dart';
import 'package:pedidos/widgets/recebimento_list_item.dart';
import 'package:pedidos/utils/constants.dart';
import 'package:searchable_listview/searchable_listview.dart';

class ProdutoList extends StatelessWidget {
  ProdutoList({this.produtoItems, this.recebimento, this.focusNodeSearcher});
  List<Produto> produtoItems; // Essa lista já vem filtrada pelo Recebimento
  Recebimento recebimento;
  FocusNode focusNodeSearcher;

  @override
  Widget build(BuildContext context) {
    List<Produto> produtos = produtoItems;

    Recebimentos provRecebimentos = Provider.of<Recebimentos>(context);

    List<Produto> _filterRecebimentoList(search) {
      return produtos
          .where(
            (element) =>
                element.title.contains(search) ||
                element.title.toLowerCase().contains(search),
          )
          .toList();
    }

    return Expanded(
      child: provRecebimentos.bProdutosSearch
          ? SearchableList<Produto>(
              initialList: produtos,
              builder: (dynamic varr) => ProdutoListItem(
                recebimento: recebimento,
                produto: varr,
              ),
              filter: _filterRecebimentoList,
              emptyWidget: const Text('sem resultado !'),
              focusNode: focusNodeSearcher,
              inputDecoration: InputDecoration(
                labelText: "Procurar Produto",
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.blue,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            )
          : ListView.separated(
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                  value: produtos[index],
                  child: ProdutoListItem(
                    produto: produtos[index],
                    recebimento: recebimento,
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(height: 1.2, indent: 1.0);
              },
              itemCount: produtos.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
            ),
    );
  }
}
