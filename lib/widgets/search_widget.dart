import 'package:flutter/material.dart';
import 'package:pedidos/providers/recebimento.dart';
import 'package:pedidos/providers/recebimentos.dart';
import 'package:provider/provider.dart';

class SearchWidget extends StatefulWidget {
  bool autoFocus;

  SearchWidget({this.autoFocus});

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  TextEditingController controller = TextEditingController();

  Recebimentos _provRecebimentos;

  List<Recebimento> listaRecebimentos;

  // listaAnterior pega a lista inicial
  var listaAnterior;

// um método fazendo foreach produzindo uma lista de widget recebimento

  void Onchanged({String texto}) {
    // abaixo foi feito p preservar a lista anterior
    if (texto == '') {
      // lista atual pega o valor da lista inicial
      listaRecebimentos = listaAnterior;
    } else {
      listaRecebimentos
          .where(
            (element) => element.nomeFornecedor.toLowerCase().contains(texto),
          )
          .toList();
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(Onchanged);
  }

// sera q dava pra construir o widget num for e depois passar pra search
//executo o método e guardo o resultado dentro de uma variável
//e uso dentro do searcheble

  @override
  Widget build(BuildContext context) {
    _provRecebimentos = Provider.of(context);

    listaAnterior = listaRecebimentos;

    listaRecebimentos = _provRecebimentos.items;

    return Container(
      margin: EdgeInsets.only(
        top: 8,
        bottom: 32,
        left: 6,
        right: 6,
      ),
      child: TextField(
        controller: controller,
        onChanged: (texto) {
          Onchanged(texto: texto);
        },
        autofocus: widget.autoFocus,
        decoration: InputDecoration(
          hintText: "Procurar recebimento",
        ),
      ),
    );
  }
}
