import 'package:izobility_mobile/models/market_item.dart';

class UserProductModel {
  UserProductModel({
    required this.id,
    required this.productId,
    required this.createdAt,
    required this.token,
    required this.product,
  });

  late final String id;
  late final String productId;
  late final String createdAt;
  late final String token;
  late final UserMarketItemModel product;
  
  UserProductModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    productId = json['product_id'];
    createdAt = json['created_at'];
    token = json['token'];
    product = UserMarketItemModel.fromJson(json['product']);
  }

}


class UserMarketItemModel {
    final String id;
    final String name;
    final String description;
    final String quantity;
    final double price;
    final DateTime createdAt;
    final String category;
    final List<dynamic> images;

    UserMarketItemModel({
        required this.id,
        required this.name,
        required this.description,
        required this.quantity,
        required this.price,
        required this.createdAt,
        required this.category,
        required this.images,
    });

  factory UserMarketItemModel.fromJson(Map<String, dynamic> json) {
    return UserMarketItemModel(
      id: json['id'].toString(),
      name: json['name'],
      description: json['description'],
      quantity: json['quantity'].toString(),
      price: double.parse(json['price'].toString()),
      createdAt: DateTime.parse(json['created_at']),
      category: json['categ'].toString(),
      images: json['images'].map((e) => "https://api.z-boom.ru/media/" + e['path']).toList(),
    );
  }
}