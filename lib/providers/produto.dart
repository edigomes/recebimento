//    MARCAÇÃO FAVORITO
// A marcação de favorito foi deixado nos próprios produtos internamente e no
//servidor fica uma parte separada para os favoritos de cada usuário.

// fornecedor precisa de nome e lista de pedidos
// produto precisa ter nome, código (é do proprio produto), quantidade
import 'package:http/http.dart' as http;
import 'package:pedidos/exceptions/http_exception.dart';
import 'package:pedidos/utils/constants.dart';
import 'package:flutter/material.dart';

class Produto with ChangeNotifier {
  // id é do retorno do servidor
  final int cod;
  final String title;
  final double quant;
  //final double price;
  final String imageUrl;
  //bool isFavorite;

  Produto({
    this.quant,
    this.cod,
    //@required this.quant,
    this.title,
    //@required this.price,
    this.imageUrl,
    //this.isFavorite = false,
  });
//------------------------------------------------------------------------------
/*
  Future<void> toggleFavorite(String token, String userId) async {
    final _baseUrl = '${Constants.BASE_API_URL}/userFavorites/$userId';

    isFavorite = !isFavorite;

    //    PATCH ou PUT ?
    // Precisa mandar "put", pq vai mudar toda a info e não uma das info
    //caso usando "patch".
    final response = await http.put(
      Uri.parse('$_baseUrl/$id.json?auth=$token'),
      // Manda apenas uma marcação logo após o token do produto.
      body: jsonEncode(isFavorite),
    );

    if (response.statusCode >= 400) {
      isFavorite = !isFavorite;

      //notify, pois quando dá erro o código para aqui
      notifyListeners();

      throw HttpException('Ocorreu um erro ao favoritar.');
    }

    notifyListeners();
  }
  */
}
