import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pedidos/providers/cart.dart';
import 'package:pedidos/providers/orders.dart';
import 'package:pedidos/widgets/cart_item_widget.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final cartItems = cart.items.values.toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('carrinho'),
      ),
      //------------------------------------------------ CARD COMPRAR CARRINHO
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(25),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(width: 10),
                  Chip(
                    label: Text(
                      'R\$ ${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color:
                            Theme.of(context).primaryTextTheme.headline6.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  Spacer(),
                  OrderButton(cart: cart),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemsCount,
              itemBuilder: (ctx, i) => CartItemWidget(cartItems[i]),
            ),
          ),
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      //style: ButtonStyle(),
      onPressed: widget.cart.itemsCount == 0
          ? null
          : () async {
              //----------------------------------------------------------------
              setState(() {
                _isLoading = true;
              });
              //----------------------------------------------------------------
              await Provider.of<Orders>(context, listen: false)
                  .addOrder(widget.cart);
              //----------------------------------------------------------------
              setState(() {
                _isLoading = false;
              });
              //----------------------------------------------------------------
              widget.cart.clear();
            },
      child: _isLoading ? CircularProgressIndicator() : Text('COMPRAR'),
    );
  }
}
