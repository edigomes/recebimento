import 'package:flutter/cupertino.dart';
import 'package:pedidos/providers/produto.dart';

class Recebimento with ChangeNotifier {
  String nomeFornecedor;
  DateTime dataPedido;
  int id;
  int notaFiscal;
  List<Produto> produtos = []; // n precisa de construt

  Recebimento({
    this.nomeFornecedor,
    this.dataPedido,
    this.id,
    this.notaFiscal,
    this.produtos,
  });
}
