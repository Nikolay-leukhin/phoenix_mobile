class CoinOperationModel {
  final String addressFrom;

  final String addressTo;

  CoinOperationModel({required this.addressFrom, required this.addressTo});

  factory CoinOperationModel.fromJson(Map<String, dynamic> json) {
    return CoinOperationModel(
      addressFrom: json[''],
      addressTo: json['']
    );
  }
}
