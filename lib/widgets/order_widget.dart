import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pedidos/providers/orders.dart';

class OrderWidget extends StatefulWidget {
  final Order order;

  OrderWidget(this.order);

  @override
  _OrderWidgetState createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6.0,
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('R\$ ${widget.order.total.toStringAsFixed(2)}'),
            subtitle: Text(
              DateFormat('dd/MM/yyyy hh:mm').format(widget.order.date),
            ),
            trailing: IconButton(
              icon: Icon(Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Column(
              children: [
                Divider(),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 4,
                  ),
                  height: (widget.order.products.length * 25.0) + 40,
                  child: ListView(
                    children: widget.order.products
                        .map(
                          (product) => Column(
                            children: [
                              SizedBox(
                                height: 5.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    product.title,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '${product.quantity} x R\$ ${product.price}',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.blueGrey),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }
}