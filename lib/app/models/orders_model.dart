import 'dart:convert';
import 'package:my_souaq/app/models/product_model.dart';

class Orders {
  final String id;
  final List<Product> products;
  final String address;
  final String userId;
  final int orderedAt;
  final int status;
  final String paymentMethod;
  final double totalPrice;

  Orders({required this.id, required this.products, required this.address,
    required this.userId, required this.orderedAt,
    required this.status, required this.paymentMethod, required this.totalPrice});

  factory Orders.getNewEmpty() {
    return Orders(
        id:  '',
        products: [],
        address: '',
        userId:  '',
        orderedAt: 0,
        status: 0,
        paymentMethod: '',
        totalPrice: 0
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "products": products,
      "address": address,
      "userId": userId,
      "orderedAt": orderedAt,
      "status": status,
      "paymentMethod": paymentMethod,
      "totalPrice": totalPrice
    };
  }

  factory Orders.fromMap(Map<String, dynamic> json) {
    return Orders(
        id: json["_id"] ?? '',
        products: List<Product>.from(
          json['products']?.map(
                (x) {
              var product = Product.fromMap(x['product']);
              product.selQty = x['qty']?.toDouble() ?? 0;
              return product;
            },
          ),
        )	,
        address: json["address"] ?? '',
        userId: json["userId"]?? '' ,
        orderedAt: json["orderTime"] ?? 0,
        status: json["status"] ?? 0,
        paymentMethod: json["paymentMethod"] ?? '',
        totalPrice: json["totalPrice"]?.toDouble() ?? 0.0
    );
  }

  String toJson() => json.encode(toMap());

  factory Orders.fromJson(String source) => Orders.fromMap(json.decode(source));
}