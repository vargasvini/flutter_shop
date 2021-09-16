import 'package:flutter/material.dart';
import 'package:flutter_shop/models/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [];

  var showFavoritesOnly = false;

  List<Product> get items {
    return [..._items];
  }

  Future<void> fetchAndSetProducts() async {
    final url = Uri.parse(
        "https://flutter-app-teste-b15b9-default-rtdb.firebaseio.com/products.json");
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      extractedData.forEach(
        (prodId, prodData) {
          loadedProducts.add(Product(
              id: prodId,
              title: prodData['title'],
              description: prodData['description'],
              price: prodData['price'],
              imageUrl: prodData['imageUrl'],
              isFavorite: prodData['isFavorite']));
        },
      );
      _items = loadedProducts;
    } catch (e) {
      throw e;
    }
    notifyListeners();
  }

  List<Product> get favoriteItems {
    return [..._items].where((prod) => prod.isFavorite).toList();
  }

  Future<void> addProduct(Product product) {
    final url = Uri.parse(
        "https://flutter-app-teste-b15b9-default-rtdb.firebaseio.com/products.json");
    return http
        .post(
      url,
      body: json.encode({
        'title': product.title,
        'description': product.description,
        'imageUrl':
            "https://www.prada.com/content/dam/pradanux_products/S/SPH/SPH109/1WQ8F0002/SPH109_1WQ8_F0002_S_211_SLF.png",
        'price': product.price,
        'isFavorite': product.isFavorite
      }),
    )
        .then(
      (response) {
        final newProduct = Product(
          id: DateTime.now().toString(),
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl:
              "https://www.prada.com/content/dam/pradanux_products/S/SPH/SPH109/1WQ8F0002/SPH109_1WQ8_F0002_S_211_SLF.png",
          isFavorite: product.isFavorite,
        );
        _items.add(newProduct);
        notifyListeners();
      },
    ).catchError((error) {
      throw error;
    });
  }

  Product getProductById(String id) {
    return [..._items].firstWhere((prod) => prod.id == id);
  }

  void updateProduct(String id, Product product) {
    final prodIndex = _items.indexWhere((element) => element.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = product;
      notifyListeners();
    }
  }

  void removeProduct(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
