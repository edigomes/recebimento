import 'dart:async';

import 'package:dio/dio.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:pedidos/providers/recebimento.dart';
import 'package:pedidos/providers/recebimentos.dart';
import 'package:provider/provider.dart';
import 'package:searchable_listview/searchable_listview.dart';

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

  // filtra a lista de recebimentos
  void onChanged({String inputText}) {
    Provider.of<Recebimentos>(context, listen: false)
        .loadRecebimentos(searchQuery: inputText);
  }

  @override
  void initState() {
    print("initState");
    super.initState();
    //controller.addListener(onChanged);
  }

  @override
  Widget build(BuildContext context) {
    _provRecebimentos = Provider.of(context);

    listaRecebimentos = _provRecebimentos.items;

    return TextField(
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
      },
      onChanged: (String inputText) async {
        print('input >>> ' + inputText.length.toString());

        EasyDebounce.cancelAll();

        if (inputText.length < 1) {
          EasyDebounce.debounce(
            'my-debouncer',
            Duration(milliseconds: 2000),
            () {
              onChanged(inputText: null);
            },
          );
        } else {
          EasyDebounce.debounce(
            'my-debouncer',
            Duration(milliseconds: 2000),
            () {
              onChanged(inputText: inputText);
            },
          );
        }
      },
    );
  }
}
