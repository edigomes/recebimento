// URGENTE:  LOGO APÓS TERMINAR O APP, DOCUMENTAR O QUE FOR NECESSÁRIO !

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pedidos/exceptions/http_exception.dart';
import 'package:pedidos/providers/recebimento.dart';
import 'package:pedidos/providers/produto.dart';
import 'package:pedidos/utils/constants.dart';
import 'package:provider/provider.dart';

// O único lugar que Products é usado como instância é em "main". Provavelmente, pra passar da melhor forma
//deve ser feito por ProxyProvider

class Recebimentos with ChangeNotifier {
//----------------------------------------------------------------------------//
  // a lista pede pra ser constante

  List<Recebimento> _items = [];
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
  List<Recebimento> get items {
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

  // usada em "recebimentosOverviewScreen" e "recebimentosList"
  bool bRecebimentosSearch = false;

  //
  bool bProdutosSearch = false;

  bool bLoadingRecebimentos = true;

  bool teste;

  // Usada no widget "search_widget.dart" p cancelar a requisição de "loadRecebimentos()"
  //bool bTerminou = false;

//----------------------------------------------------------------------------//

  // CARREGA OS PRODUTOS

  Future<void> loadRecebimentos({searchQuery}) async {
    teste = false;
    bLoadingRecebimentos = true;
    if (_items.isNotEmpty) _items.clear();

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };

    //&custom={"status":"1"}'),

    // se [search != null] ent mostra lista filtrada por searchQuery (texto do searcher)
    var url = '$_baseUrl/entrada?page=1' +
        (searchQuery != null ? '&search=' + searchQuery : '');

    final recebimentoResponse = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    final Map<String, dynamic> dataRecebimentos =
        jsonDecode(recebimentoResponse.body);

    if (dataRecebimentos != null) {
      var data = dataRecebimentos['data'];

      for (var recebimento in data) {
        _items.add(
          // agora como construtor opcional
          Recebimento(
            nomeFornecedor: recebimento['fornecedor'] == null
                ? '--'
                : recebimento['fornecedor']['xFant'],
            dataPedido: DateTime.parse(recebimento['dEmi']),
            id: recebimento['id'],
            notaFiscal: recebimento['nNF'],

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

    //bLoadingRecebimentos = false;

    return Future.value();
  }

//------------------------------------------------------------------------------

  Future<void> loadProdutos(id) async {
    // antes duplicava pq tava _items
    if (_produtoItems.isNotEmpty) _produtoItems.clear();

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
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
            imageUrl: 'url',
            quant: double.parse(recebimento_item['qTrib']),
          ),
        );
      }
      notifyListeners();
    }
    return Future.value();
  }
}
