import 'package:flutter/material.dart';
import 'package:flutter_shop/widgets/app_drawer.dart';
import 'package:flutter_shop/widgets/order_item.dart';
import 'package:provider/provider.dart';
import '../providers/orders_provider.dart' show OrdersProvider;

class OrdersScreen extends StatelessWidget {
  static const routeName = '/order-detail';
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<OrdersProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
      ),
      drawer: AppDrawer(),
    );
  }
}
