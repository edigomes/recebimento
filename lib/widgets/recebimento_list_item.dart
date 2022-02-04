import 'package:flutter/material.dart';
import 'package:pedidos/providers/recebimento.dart';
import 'package:pedidos/providers/produto.dart';
import 'package:pedidos/providers/recebimentos.dart';
import 'package:provider/provider.dart';
import 'package:pedidos/exceptions/http_exception.dart';
import 'package:pedidos/providers/auth.dart';
import 'package:pedidos/sem_uso/cart.dart';
import 'package:pedidos/utils/app_routes.dart';
import '../sem_uso/cart.dart';

// Formato dos produtos do app, com foto e interações em stack,
//como favorito e add carrinho ao lado.

class RecebimentoListItem extends StatelessWidget {
  Recebimento recebimento;

  String fornecedorNome;

  int fornecedorId;
  int fornecedorNF;

  RecebimentoListItem({
    this.fornecedorNome,
    this.fornecedorId,
    this.fornecedorNF,
    this.recebimento,
    Key key, // talvez precise
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Recebimentos recebimentosProvider =
        Provider.of<Recebimentos>(context, listen: false);

    //final Cart cart = Provider.of(context, listen: false);

    //final Auth auth = Provider.of(context, listen: false);

    return Column(
      children: [
        Divider(height: 1.2, indent: 1.0),
        ListTile(
          contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
          title: Text(
            fornecedorNome,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text('ID: $fornecedorId' + ' | ' + '$fornecedorNF'),
          trailing: IconButton(
            icon: Icon(Icons.navigate_next),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(
                    AppRoutes.SCREEN_RECEBIMENTO_DETAIL,
                    arguments: recebimento,
                  )
                  .then((value) async =>
                      await recebimentosProvider.loadRecebimentos());
              // Recolhe o widget Searcher (pesquisa) da
              recebimentosProvider.bRecebimentosSearch = false;
            },
          ),
        ),
      ],
    );
  }
}
