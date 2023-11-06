import 'package:izobility_mobile/models/api/token_data.dart';

class MarketItemModel {
  final String id;
  final String name;
  final String description;
  final String quantity;
  final double price;
  final DateTime createdAt;
  final String category;
  final List<dynamic> images;
  final TokenData coin;

  MarketItemModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.quantity,
      required this.price,
      required this.createdAt,
      required this.category,
      required this.images,
      required this.coin,
      });

  factory MarketItemModel.fromJson(Map<String, dynamic> json) {
    return MarketItemModel(
      id: json['id'].toString(),
      name: json['name'],
      description: json['description'],
      quantity: json['quantity'].toString(),
      price: double.parse(json['price'].toString()),
      createdAt: DateTime.parse(json['created_at']),
      category: json['categ'].toString(),
      images: json['images']
          .map((e) => "https://api.z-boom.ru/media/" + e['path'])
          .toList(),
      coin: TokenData.fromJson(json['moneta']),
    );
  }
}
