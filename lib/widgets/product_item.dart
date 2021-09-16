import 'package:flutter/material.dart';
import 'package:flutter_shop/providers/cart_provider.dart';
import 'package:flutter_shop/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<CartProvider>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black54,
          leading: Consumer<Product>(
            builder: (ctx, product, child) => IconButton(
              //color: product.isFavorite ? Colors.red : Colors.black,
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border),
              onPressed: () => product.toggleFavoriteStatus(),
            ),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_bag,
            ),
            onPressed: () => {
              cart.addItem(product.id!, product.price, product.title),
              ScaffoldMessenger.of(context).hideCurrentSnackBar(),
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Added item to cart'),
                  behavior: SnackBarBehavior.fixed,
                  action: SnackBarAction(
                    onPressed: () => {
                      cart.removeSingleItem(product.id!),
                    },
                    label: 'DESFAZER',
                    textColor: Colors.black,
                  ),
                  backgroundColor: (Colors.green),
                ),
              )
            },
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
