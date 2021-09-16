import 'package:flutter/material.dart';
import 'package:flutter_shop/providers/orders_provider.dart';
import 'package:flutter_shop/providers/products_provider.dart';
import 'package:flutter_shop/screens/auth_screen.dart';
import 'package:flutter_shop/screens/cart_screen.dart';
import 'package:flutter_shop/screens/orders_screen.dart';
import 'package:flutter_shop/screens/product_detail_screen.dart';
import 'package:flutter_shop/screens/products_overview_screen.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/cart_provider.dart';
import 'screens/user_products_screen.dart';
import 'screens/product_form.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => OrdersProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => AuthProvider(),
        )
      ],

      //value: ProductsProvider(),
      child: Consumer<AuthProvider>(
          builder: (ctx, authData, child) => MaterialApp(
                title: 'MyShop',
                theme: ThemeData(
                  primarySwatch: Colors.purple,
                  accentColor: Colors.deepOrange,
                  fontFamily: 'Roboto',
                ),
                home:
                    authData.isAuth! ? ProductsOverviewScreen() : AuthScreen(),
                routes: {
                  ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
                  CartScreen.routeName: (ctx) => CartScreen(),
                  OrdersScreen.routeName: (ctx) => OrdersScreen(),
                  UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
                  ProductFormScreen.routeName: (ctx) => ProductFormScreen()
                },
              )),
    );
  }
}
