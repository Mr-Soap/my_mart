import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:xml/xml.dart';
import 'package:my_mart/models/product.dart';

class Shop extends ChangeNotifier {
  //list produk
  final List<Product> _shop = [];

  //keranjang
  final List<Product> _cart = [];

  //getter
  List<Product> get shop => _shop;
  List<Product> get cart => _cart;

  //add to cart
  void addToCart(Product item) {
    if (item.cartQuantity < item.quantity) {
      item.cartQuantity++;
      if (!_cart.contains(item)) {
        _cart.add(item);
      }
      notifyListeners();
    }
  }

  //remove from cart
  void removeFromCart(Product item) {
    if (item.cartQuantity > 0) {
      item.cartQuantity--;
      if (item.cartQuantity == 0) {
        _cart.remove(item);
      }
      notifyListeners();
    }
  }

  //hapus nol cart
  void removeItemCompletely(Product item) {
    item.cartQuantity = 0;
    _cart.remove(item);
    notifyListeners();
  }

  //fungsi tombol detail produk
  void addToCartWithQuantity(Product item, int qty) {
    final available = item.quantity - item.cartQuantity;
    final toAdd = qty <= available ? qty : available;

    item.cartQuantity += toAdd;

    if (!_cart.contains(item) && item.cartQuantity > 0) {
      _cart.add(item);
    }

    notifyListeners();
  }

  //load xml
  Future<void> loadProductsFromXml() async {
    try {
      final xmlString = await rootBundle.loadString('assets/data/data.xml');
      final document = XmlDocument.parse(xmlString);

      final products = document.findAllElements('product').map((node) {
        // Parse specs
        final specs = <String, String>{};
        final specsNode = node.getElement('specs');
        if (specsNode != null) {
          for (var specNode in specsNode.findAllElements('spec')) {
            final key = specNode.getElement('key')?.innerText ?? '';
            final value = specNode.getElement('value')?.innerText ?? '';
            if (key.isNotEmpty) specs[key] = value;
          }
        }

        return Product(
          name: node.getElement('name')?.innerText ?? 'Unnamed',
          price: double.tryParse(node.getElement('price')?.innerText ?? '0') ?? 0.0,
          category: node.getElement('category')?.innerText ?? '',
          description: node.getElement('description')?.innerText ?? '',
          quantity: int.tryParse(node.getElement('quantity')?.innerText ?? '0') ?? 0,
          imagePath: node.getElement('imagePath')?.innerText ?? '',
          specifications: specs,
        );
      }).toList();

      _shop.clear();
      _shop.addAll(products);
      notifyListeners();
    } catch (e) {
      // ignore: avoid_print
      print("Error loading XML: $e");
    }
  }
}