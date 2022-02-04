import 'package:flutter/material.dart';
import 'package:pedidos/providers/recebimento.dart';
import 'package:provider/provider.dart';
import 'package:pedidos/providers/recebimentos.dart';
import 'package:pedidos/widgets/recebimento_list_item.dart';
import 'package:searchable_listview/searchable_listview.dart';

// Lista em forma de grade

class RecebimentoList extends StatelessWidget {
  //final bool showFavoriteOnly;

  //const ProductGrid(this.showFavoriteOnly);

  @override
  Widget build(BuildContext context) {
    final recebimentosProvider = Provider.of<Recebimentos>(context); // Provider
    final Recebimento recebimento = Recebimento();

    List<RecebimentoListItem> Lista() {
       List<RecebimentoListItem> listaWidget;
      for(var tal in recebimentosProvider.items) {
        listaWidget.add(RecebimentoListItem(tal.));
      }
      RecebimentoListItem()
      
    }
    // lista do listview vai ter q vir do widget de search
    //final pedidos =
    //fornecedorProvider.pedidos; // Lista de produtos filtrada ou não

/*
recebimentosProvider.bLupa
        ? Expanded(
            child: SearchableList<Recebimento>(
              initialList: recebimentosProvider.items,
              builder: (dynamic vars) => RecebimentoListItem(vars),
              filter: (value) => recebimentosProvider.items
                  .where(
                    (element) =>
                        element.nomeFornecedor.toLowerCase().contains(value),
                  )
                  .toList(),
              emptyWidget: const Text('sem resultado !'),
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
            ),
          )
        : 
*/

// acredito q tem q colocar em child o searchable e dentro do build fica RecebimentoListItem(pedido)
// na verdade o builder precisa ter acesso ao ítem diretamente
// se digitar no textformfield do searcheble (!= null) mostra ele, se n mostra o outro
// isso msm, só preciso usar o textController e usar controller.addListener(função)
// sempre q onChanged de executar precisa dar setstate()

    return Expanded(
      child: ListView.separated(
        itemCount: recebimentosProvider.items.length,
        itemBuilder: (context, index) {
          return ChangeNotifierProvider.value(
            value: recebimentosProvider.items[index],
            child: RecebimentoListItem(recebimento),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(height: 1.2, indent: 1.0);
        },
        scrollDirection: Axis.vertical,
      ),
    );
  }
}


// da pra usar o textformfield com seu controller pra filtrar a lista
// vou criar uma variável string que vai ficar no parametro de digitação do textform e
// e vou colocar no onchanged pra executar um where
// Abaixo o textfield q o icone da lupa vai ficar dentro dele
/*
TextField(
                              autofocus: textFieldAutoFocus,
                              decoration: InputDecoration(
                                hintText: "Entre o código de barras",
                                prefixIcon: Icon(MdiIcons.barcode),
                              ),
                            ),
*/
// o icone da lupa ao ser tocado abre o textform (acima) na parte superior da pagina.
// Apertando nele de novo fecha 