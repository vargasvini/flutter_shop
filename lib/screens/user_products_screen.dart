import 'package:flutter/material.dart';
import 'package:flutter_shop/providers/products_provider.dart';
import 'package:flutter_shop/screens/product_form.dart';
import 'package:flutter_shop/widgets/app_drawer.dart';
import 'package:flutter_shop/widgets/user_product_item.dart';
import 'package:provider/provider.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () =>
                {Navigator.of(context).pushNamed(ProductFormScreen.routeName)},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productsProvider.items.length,
          itemBuilder: (ctx, i) => Column(
            children: [
              UserProductItem(
                id: productsProvider.items[i].id!,
                title: productsProvider.items[i].title,
                imageUrl: productsProvider.items[i].imageUrl,
              ),
              Divider()
            ],
          ),
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
