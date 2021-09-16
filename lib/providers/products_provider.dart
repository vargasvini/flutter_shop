import 'package:flutter/material.dart';
import 'package:flutter_shop/models/product.dart';

class ProductsProvider with ChangeNotifier {
  //List<Product> loadedProducts = ProductListMock.loadedProducts;
  static List<Product> _items = [
    new Product(
        id: "p1",
        title: "Produto 1",
        description: "Descrição do produto 1",
        price: 1.99,
        imageUrl:
            "https://www.prada.com/content/dam/pradanux_products/S/SPH/SPH109/1WQ8F0002/SPH109_1WQ8_F0002_S_211_SLF.png"),
    new Product(
        id: "p2",
        title: "Produto 1",
        description: "Descrição do produto 1",
        price: 1.99,
        imageUrl:
            "https://www.prada.com/content/dam/pradanux_products/S/SPH/SPH109/1WQ8F0002/SPH109_1WQ8_F0002_S_211_SLF.png"),
    new Product(
        id: "p3",
        title: "Produto 1",
        description: "Descrição do produto 1",
        price: 1.99,
        imageUrl:
            "https://www.prada.com/content/dam/pradanux_products/S/SPH/SPH109/1WQ8F0002/SPH109_1WQ8_F0002_S_211_SLF.png"),
    new Product(
        id: "p4",
        title: "Produto 1",
        description: "Descrição do produto 1",
        price: 1.99,
        imageUrl:
            "https://www.prada.com/content/dam/pradanux_products/S/SPH/SPH109/1WQ8F0002/SPH109_1WQ8_F0002_S_211_SLF.png"),
    new Product(
        id: "p5",
        title: "Produto 1",
        description: "Descrição do produto 1",
        price: 1.99,
        imageUrl:
            "https://www.prada.com/content/dam/pradanux_products/S/SPH/SPH109/1WQ8F0002/SPH109_1WQ8_F0002_S_211_SLF.png"),
    new Product(
        id: "p6",
        title: "Produto 1",
        description: "Descrição do produto 1",
        price: 1.99,
        imageUrl:
            "https://www.prada.com/content/dam/pradanux_products/S/SPH/SPH109/1WQ8F0002/SPH109_1WQ8_F0002_S_211_SLF.png"),
  ];
  //List<Product> loadedProducts = [];
  var showFavoritesOnly = false;

  // List<Product> get items {
  //   if (showFavoritesOnly) {
  //     return [..._items].where((prod) => prod.isFavorite).toList();
  //   }
  //   return [..._items];
  // }

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return [..._items].where((prod) => prod.isFavorite).toList();
  }

  void addProduct(Product product) {
    final newProduct = Product(
      id: DateTime.now().toString(),
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
      isFavorite: product.isFavorite,
    );
    _items.add(newProduct);
    notifyListeners();
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
