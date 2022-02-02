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

class Pedidos with ChangeNotifier {
//----------------------------------------------------------------------------//
  // a lista pede pra ser constante

  List<Pedido> _items = [];

  String _token;
  String _userId;

  final _baseUrl = '${Constants.BASE_API_URL}/products';

  Pedidos([
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

  Future<void> loadProducts() async {
    if (_items.isNotEmpty) _items.clear();

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': _token,
      'Name': 'Antony',
    };

    final pedidoResponse = await http.get(
        Uri.parse(
            'https://reqres.in/api/users/2' /*'$_baseUrl/$_userId.json?auth=$_token'*/),
        headers: requestHeaders);
    final Map<String, dynamic> dataPedido = jsonDecode(pedidoResponse.body);

    final produtosResponse = await http.get(
      Uri.parse('https://reqres.in/api/users?page=2'),
    );
    final Map<String, dynamic> dataProduto = jsonDecode(produtosResponse.body);

    //final favResponse = await http.get(Uri.parse(
    //    '${Constants.BASE_API_URL}/userFavorites/$_userId.json?auth=$_token'));
    //final favMap = jsonDecode(favResponse.body);

    // retorna no padrão json Map<String, Map<String, dynamic>>
    //print(data['']['e']);
    if (dataPedido != null) {
      final Map<String, Map<String, dynamic>> teste = {
        'a': {'b': 'c'},
        'd': {'e': 'f'},
      };

      // n pd vir null pq n se faz forEach no nada !

      // chave/valor do map/json
      //data.forEach((productId, productData) {
      //final isFavorite = favMap == null ? false : favMap[productId] ?? false;
      // Se n for nulo passa direto
      // Se nulo n marca, do contrário pega de favMap, caso n false tmbm.
      // anotei sobre nulo
      //final String idJson = ;
      //print(productData['data']['cod'] + "+++++++++++++askaskaoskaoskasokaso");

      _items.add(
        Pedido(
          id: dataPedido['data']["id"],
          notaFiscal: dataPedido['data']['id'],
          nomeFornecedor: dataPedido['data']["first_name"], //productId,
          dataPedido: dataPedido['data']["last_name"],
          produtos: (dataProduto['data'] as List<dynamic>)
              .map(
                (item) => Produto(
                  cod: item['id'],
                  title: item['first_name'],
                  imageUrl: item['avatar'],
                ),
              )
              .toList(),
          //price: productData['price'],
          //: data['data']["avatar"],
          //isFavorite: isFavorite,
        ),
      );
      //});
      notifyListeners();
    }

    return Future.value();
  }

/*
//----------------------------------------------------------------------------//

  // ADICIONAR PRODUTO

  // Método que adiciona um produto por parâmetro e notifica
  Future<void> addProduct(Product newProduct) async {
    // Não se usa mais só url

    // "http" vem de "as http" no import
    // post pede uma url e um object, tipo Map, para convert em Json String
    // É recomend q as requis sejam feitas no Provider (centralizada).  <<
    // return para Future e n para void (retorna cm value) o qual é um Fut tmbm
    // async/await deixa sincrono o que seria assinc usando só Future. Assim
    //como ser mais leve e usar em locais específicos.
    final response = await http.post(
      Uri.parse('$_baseUrl/$_userId.json?auth=$_token'),
      //Aqui tmbm poderia ser colocado try e tal
      body: jsonEncode(
        {
          'title': newProduct.title,
          //'description': newProduct.description,
          //'price': newProduct.price,
          'imageUrl': newProduct.imageUrl,
          //'isFavorite': newProduct.isFavorite,
        },
      ),
    );

    _items.add(
      Product(
        // response.body é o cod do obj (retorno) do servidor com 'name'
        cod: jsonDecode(response.body)['name'],
        //description: newProduct.description,
        title: newProduct.title,
        //price: newProduct.price,
        imageUrl: newProduct.imageUrl,
      ),
    );
    // Precisa  notificar pq aqui é "criado" os itens q vem do servidor.
    notifyListeners();
  }

//----------------//----------------//-----------------//----------------//-----

  // ATUALIZAR PRODUTO

  Future<void> updateProduct(Product product) async {
    // "product" é o que vou alterar

    if (product == null || product.cod == null) return;

    final index = _items.indexWhere((prod) => prod.cod == product.cod);

    // Abaixo faz um ser = ao outro
    if (index >= 0) {
      await http.patch(
        Uri.parse('$_baseUrl/${product.cod}.json?auth=$_token'),
        body: jsonEncode(
          {
            'title': product.title,
            //'description': product.description,
            //'price': product.price,
            'imageUrl': product.imageUrl,
          },
        ),
      );
      _items[index] = product; //_items[index] é exist c msm ID
    }
    notifyListeners();
  }

//----------------------------------------------------------------------------//

  // REMOVER PRODUTO

  Future<void> removeProduct(String cod) async {
    final index = _items.indexWhere((prod) => prod.cod == cod);

    if (index >= 0) {
      // A ideia aqui é add primeiro, remover dps e add caso problema
      // Para add o ítem removido precisa de product, invés de removeWhere
      // Exclusão otimista
      final product = _items[index];
      _items.remove(product);

      final response = await http
          .delete(Uri.parse('$_baseUrl/${product.cod}.json?auth=$_token'));

      // Pra aparecer "statusCode", "response" deve ser "await"
      // 200: retorno da familía de conclusão
      // *400: retorno da família de erros de requisição
      // 500: retorno da família de erros do servidor
      if (response.statusCode >= 400) {
        // insert pra colocar onde estava
        _items.insert(index, product);
        notifyListeners();
        // caso queira usar exceptions de forma descentralizada
        // "on HttpException catch()" pode ser usado em "catch"
        // ?
        throw HttpException('Ocorreu um erro ao tentar remover o produto.');
      }

      // _items.removeWhere((prod) => prod.cod == cod);       <<
    }
    notifyListeners();
  }
//----------------//----------------//----------------//----------------//------
*/
}
