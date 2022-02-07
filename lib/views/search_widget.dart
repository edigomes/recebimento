import 'dart:async';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:pedidos/providers/recebimento.dart';
import 'package:pedidos/providers/recebimentos.dart';
import 'package:provider/provider.dart';
import 'package:searchable_listview/searchable_listview.dart';

// AMANHA vou tentar colocar o bounce dnv e testar ele em async

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

  // filtra a lista de recebimentos
  void onChanged({String inputText}) {
    Provider.of<Recebimentos>(context, listen: false)
        .loadRecebimentos(searchQuery: inputText);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(onChanged);
  }

// TALVEZ PRECISE USAR P DIMINUIR USO DE MEMORIA
/*
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }
*/

  @override
  Widget build(BuildContext context) {
    _provRecebimentos = Provider.of(context);

    listaAnterior = listaRecebimentos;

    listaRecebimentos = _provRecebimentos.items;

    //SearchableList

    return new TextField(
      cursorColor: Colors.white,
      controller: controller,
      autofocus: widget.autoFocus,
      decoration: const InputDecoration(
        hintText: 'Pesquisar',
        border: InputBorder.none,
        hintStyle: const TextStyle(color: Colors.white30),
      ),
      style: const TextStyle(color: Colors.white, fontSize: 16.0),
      onSubmitted: (inputText) {
        onChanged(inputText: inputText);
        //setState(() {});
      },
      // CUIDADO: o capeta está presente a seguir...
      /*onChanged: (String inputText) {
        
        print('input >>> ' + inputText.length.toString());
        EasyDebounce.cancelAll();
        // bool var true
        // o valor inicial é variável
        if (inputText.length < 1) {
          //EasyDebounce.cancelAll();
          //onChanged(inputText: null);
          EasyDebounce.debounce(
            'my-debouncer',
            Duration(milliseconds: 300),
            () {
              onChanged(inputText: null);
            }, // <-- The target method
          );
        } else {
          EasyDebounce.debounce(
            'my-debouncer',
            Duration(milliseconds: 300),
            () {
              onChanged(inputText: inputText);
            }, // <-- The target method
          );
          
        }
        

        // daria pra ver a diferença entre uma ativação e outra ?
        // onChanged só vai pegar uma nova string quando

        // o tempo de requisição do servidor é maior
      },
      */
    );
  }
}

// onchanged vai ser executado com a ressalva do
// A bool de isLoading das listas precisa ficar no provider

/*return Container(
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
    );*/


// o on changed deve parar de 




        /*EasyDebounce.debounce(
            'my-debouncer',
            Duration(milliseconds: 400),
            () {
              onChanged(inputText: inputText);
            }, // <-- The target method
          ); */