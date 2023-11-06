import 'package:flutter_dotenv/flutter_dotenv.dart';

class BurseOrderModel {
  String id;
  // String userIdFrom;
  // String BurseCoinModel;
  // String monetTo;
  String amountFrom;
  String amountTo;
  DateTime createdAt;
  // String userIdBuy;
  String? closedAt;
  // String deletedAt;
  BurseCoinModel coinFrom;
  BurseCoinModel coinTo;

  BurseOrderModel({
    required this.id,
    // required this.userIdFrom,
    required this.coinFrom,
    // required this.monetTo,
    // required this.amountFrom,
    // required this.amountTo,
    required this.createdAt,
    required this.amountFrom,
    required this.amountTo,
    // this.userIdBuy,
    this.closedAt,
    // this.deletedAt,
    // required this.BurseCoinModel,
    required this.coinTo,
  });

  factory BurseOrderModel.fromJson(Map<String, dynamic> json) {
    return BurseOrderModel(
      id: json['id'] ?? "",
      // userIdFrom: json['user_id_from'] ?? "",
      // BurseCoinModel: json['monet_from'] ?? "",
      // monetTo: json['monet_to'] ?? "",
      amountFrom: double.parse(json['amount_to'] ?? "0").toStringAsFixed(2),
      amountTo: double.parse(json['amount_from'] ?? "0").toStringAsFixed(2),
      createdAt: DateTime.parse(json['created_at']),
      // userIdBuy: json['user_id_buy'],
      closedAt: json['closed_at'],
      // deletedAt: json['deleted_at'],
      coinFrom: BurseCoinModel.fromJson(json['monetto']),
      coinTo: BurseCoinModel.fromJson(json['monetfrom']),
    );
  }
}

class BurseCoinModel {
  String id;
  String partnerId;
  String type;
  String name;
  String codename;
  String emission;
  String logo;
  String createdAt;
  String kursRub;
  String description;
  String amountAr;
  String amountSoctsetPost;
  String amountSoctsetLike;
  String amountSoctsetShare;
  String amountDraft;
  String url;


  BurseCoinModel({
    required this.id,
    required this.partnerId,
    required this.type,
    required this.name,
    required this.codename,
    required this.emission,
    required this.logo,
    required this.createdAt,
    required this.kursRub,
    required this.description,
    required this.amountAr,
    required this.amountSoctsetPost,
    required this.amountSoctsetLike,
    required this.amountSoctsetShare,
    required this.amountDraft,
    required this.url,
  });

  factory BurseCoinModel.fromJson(Map<String, dynamic> json) {
    return BurseCoinModel(
      id: json['id'] ?? "",
      partnerId: json['partner_id'] ?? "",
      type: json['type'] ?? "",
      name: json['name'] ?? "",
      codename: json['codename'] ?? "",
      emission: json['emission'] ?? "",
      logo: ('${dotenv.get('BASE_SERVER_URL')}media/' + json['logo']) ?? "",
      createdAt: json['created_at'] ?? "",
      kursRub: json['kurs_rub'] ?? "",
      description: json['description'] ?? "",
      amountAr: json['amount_ar'] ?? "",
      amountSoctsetPost: json['amount_soctset_post'] ?? "",
      amountSoctsetLike: json['amount_soctset_like'] ?? "",
      amountSoctsetShare: json['amount_soctset_share'] ?? "",
      amountDraft: json['amount_draft'] ?? "",
      url: json['url'] ?? "",
    );
  }
}

