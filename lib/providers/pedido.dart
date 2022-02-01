import 'package:flutter/cupertino.dart';
import 'package:pedidos/providers/produto.dart';

class Pedido with ChangeNotifier {
  int notaFiscal;
  String nomeFornecedor;
  int id;
  String dataPedido;
  List<Produto> produtos = []; // n precisa de construt

  Pedido({
    this.nomeFornecedor,
    this.dataPedido,
    this.id,
    this.notaFiscal,
    this.produtos,
  });
}
