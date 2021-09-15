import 'package:flutter/material.dart';
import 'package:flutter_shop/providers/cart_provider.dart' show CartProvider;
import 'package:flutter_shop/providers/orders_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart-detail';
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total', style: TextStyle(fontSize: 20)),
                  Spacer(),
                  Chip(
                    label: Text(
                      "\$${cartProvider.totalAmount.toString()}",
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  TextButton(
                      onPressed: () => {
                            Provider.of<OrdersProvider>(context, listen: false)
                                .addOrder(
                              cartProvider.items.values.toList(),
                              cartProvider.totalAmount,
                            ),
                            cartProvider.clear()
                          },
                      child: Text('ORDER NOW'))
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
              child: ListView.builder(
                  itemCount: cartProvider.items.length,
                  itemBuilder: (ctx, i) => CartItem(
                        cartProvider.items.values.toList()[i].id,
                        cartProvider.items.keys.toList()[i],
                        cartProvider.items.values.toList()[i].price,
                        cartProvider.items.values.toList()[i].quantity,
                        cartProvider.items.values.toList()[i].title,
                      )))
        ],
      ),
    );
  }
}
