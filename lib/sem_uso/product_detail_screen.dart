import 'package:flutter/material.dart';
import 'package:pedidos/providers/produto.dart';

// Tela que mostra os detalhes do produto
class ProductDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final precisa ser inicializada por constr ou diretamente
    // modalRoute passa o ctx e var para o outro widget por argumento
    // Pode ser tanto o cast quanto por referência de instância (Prod prod)
    final Produto product =
        ModalRoute.of(context).settings.arguments as Produto;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              'R\$ ${'texto' /*product.price*/}',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                '',
                /*product.description,*/
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
