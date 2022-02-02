// URGENTE:  LOGO APÓS TERMINAR O APP, DOCUMENTAR O QUE FOR NECESSÁRIO !

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pedidos/exceptions/http_exception.dart';
import 'package:pedidos/providers/pedido.dart';
import 'package:pedidos/providers/produto.dart';
import 'package:pedidos/utils/constants.dart';

// O único lugar que Products é usado como instância é em "main". Provavelmente, pra passar da melhor forma
//deve ser feito por ProxyProvider

class Recebimentos with ChangeNotifier {
//----------------------------------------------------------------------------//
  // a lista pede pra ser constante

  List<Pedido> _items = [];
  List<Produto> _produtoItems = [];

  String _token;
  String _userId;

  final _baseUrl = '${Constants.BASE_API_URL}/estoque';

  Recebimentos([
    this._token,
    this._items = const [],
    this._userId,
  ]);

  //  Abaixo (get), cópia da lista ("...") _items para que só possa ser add por addProduct
  // só sendo possível alterar a cópia (read only). Talvez, possibilite fazer filtros
  // da lista principal. Em definitivo, ... limita.

  // O TOKEN é usado para reconhecer o produto do USUÁRIO com seu token person
  List<Pedido> get items {
    return [..._items];
  }

  List<Produto> get produtoItems {
    return [..._produtoItems];
  }

  /*List<Product> get favoriteItems {
    // Aqui cria uma cópia de _items também, justo pq retorna uma lista
    return _items.where((prod) => prod.isFavorite).toList();
  }*/

  // Para produtos!
  int get itemsCount {
    return _items.length;
  }

//----------------------------------------------------------------------------//

  // CARREGA OS PRODUTOS

  Future<void> loadRecebimentos() async {
    if (_items.isNotEmpty) _items.clear();

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
      'Name': 'Antony',
    };

    final recebimentoResponse = await http.get(
      Uri.parse('$_baseUrl/entrada'),
      headers: headers,
    );

    final Map<String, dynamic> dataRecebimentos =
        jsonDecode(recebimentoResponse.body);

    if (dataRecebimentos != null) {
      var data = dataRecebimentos['data'];

      for (var recebimento in data) {
        _items.add(
          Pedido(
            id: recebimento['id'],
            notaFiscal: recebimento['nNF'],
            nomeFornecedor: recebimento['fornecedor'] == null
                ? '--'
                : recebimento['fornecedor']['xFant'],
            dataPedido: recebimento['dEmi'],
            // produtos: (dataProduto['data'] as List<dynamic>)
            //   .map(
            //     (item) => Produto(
            //       cod: item['id'],
            //       title: item['first_name'],
            //       imageUrl: item['avatar'],
            //     ),
            //   )
            //   .toList(),
            //price: productData['price'],
            //: data['data']["avatar"],
            //isFavorite: isFavorite,
          ),
        );
      }
      notifyListeners();
    }
    return Future.value();
  }

  Future<void> loadProdutos(id) async {
    if (_items.isNotEmpty) _items.clear();

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
      'Name': 'Antony',
    };

    final recebimentoResponse = await http.get(
      Uri.parse(
          '$_baseUrl/entrada_mercadoria?page=1&perPage=9999999&search=entrada_id:$id'),
      headers: headers,
    );

    final Map<String, dynamic> dataRecebimentos =
        jsonDecode(recebimentoResponse.body);

    if (dataRecebimentos != null) {
      var data = dataRecebimentos['data'];

      for (var recebimento_item in data) {
        _produtoItems.add(
          Produto(
              cod: recebimento_item['mercadoria_id'],
              title: recebimento_item['mercadoria']['xProd'],
              imageUrl: 'url'),
        );
      }
      notifyListeners();
    }
    return Future.value();
  }
}
