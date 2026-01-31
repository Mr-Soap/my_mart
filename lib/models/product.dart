class Product {
  final String name;
  final double price;
  final String category;
  final String description;
  final String imagePath;
  int quantity;
  int cartQuantity;
  final Map<String, String>? specifications;

  Product({
    required this.name,
    required this.price,
    required this.category,
    required this.description,
    required this.imagePath,
    required this.quantity,
    this.specifications,
    this.cartQuantity = 0,
  });
}