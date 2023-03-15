import 'dart:convert';
class Product
{
  final String name;
  final double price;
  final String description;
  final double qty;
  final String category;
  final List<String> images;
  String? id;
  String? userId;

  Product({
      required this.name,
      required this.price,
      required this.description,
      required this.qty,
      required this.category,
      required this.images,
      this.id,
      this.userId,
  });

  factory Product.getNewEmpty()
  {
    return Product(
      id: '',
      name: '',
      description: '',
      category: '',
      userId: '',
      qty: 0.00,
      price: 0.00,
      images: [],
    );
  }

  factory Product.fromMap(Map<String, dynamic> json)
  {
    return Product(
      id: json["_id"] ?? '',
      name: json["name"] ?? '',
      price: json["price"]?.toDouble() ?? 0.00,
      description: json["description"] ?? '',
      category: json["category"] ?? '',
      images:List<String>.from(json["images"]),
      userId: json["userId"] ?? '',
      qty: json["qty"]?.toDouble() ?? 0.00,

    );
  }
  Map<String, dynamic> toMap()
  {
    return {
      "id": id,
      "name": name,
      "price": price,
      "description": description,
      "category": category,
      "images": images,
      "userId":userId,
      "qty":qty,
    };
  }

  String toJson() => json.encode(toMap());
  factory Product.fromJson(String source) => Product.fromMap(json.decode(source));
}
