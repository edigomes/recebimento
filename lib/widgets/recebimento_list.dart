import 'package:flutter/material.dart';
import 'package:pedidos/providers/recebimento.dart';
import 'package:provider/provider.dart';
import 'package:pedidos/providers/recebimentos.dart';
import 'package:pedidos/widgets/recebimento_list_item.dart';
import 'package:searchable_listview/searchable_listview.dart';

// Lista em forma de grade

class RecebimentoList extends StatelessWidget {
  FocusNode focusNodeSearcher;

  RecebimentoList({this.focusNodeSearcher});

  @override
  Widget build(BuildContext context) {
    final provRecebimentos = Provider.of<Recebimentos>(context); // Provider
    final Recebimento recebimento = Recebimento();

    // Método usado em SearchebleList abaixo
    List<Recebimento> _filterRecebimentoList(search) {
      var lista = provRecebimentos.items;
      return provRecebimentos.items
          .where(
            (element) =>
                element.nomeFornecedor.contains(search) ||
                element.nomeFornecedor.toLowerCase().contains(search),
          )
          .toList();
    }

    // Abaixo uso de ternário entre dois tipos de ListView (pesquisa ou não)
    return Expanded(
      child: provRecebimentos.bRecebimentosSearch
          ? SearchableList<Recebimento>(
              initialList: provRecebimentos.items,
              builder: (dynamic varr) => RecebimentoListItem(
                fornecedorNome: varr.nomeFornecedor,
                fornecedorId: varr.id,
                fornecedorNF: varr.notaFiscal,
                recebimento: varr,
              ),
              filter: _filterRecebimentoList,
              emptyWidget: const Text('sem resultado !'),
              focusNode: focusNodeSearcher,
              inputDecoration: InputDecoration(
                labelText: "Procurar Recebimento",
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
              itemCount: provRecebimentos.items.length,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                  value: provRecebimentos.items[index],
                  child: RecebimentoListItem(
                    fornecedorNome:
                        provRecebimentos.items[index].nomeFornecedor,
                    fornecedorId: provRecebimentos.items[index].id,
                    fornecedorNF: provRecebimentos.items[index].notaFiscal,
                    recebimento: provRecebimentos.items[index],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(height: 1.2, indent: 1.0);
              },
              scrollDirection: Axis.vertical,
            ),
    );
//------------------------------------------------------------------------------
  }
}
