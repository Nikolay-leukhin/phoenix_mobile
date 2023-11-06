import 'dart:typed_data';

class CityHistoryItem {
  final String id;
  final String message;
  final List<Uint8List> images;
  final double reward;
  final bool fulfilled;

  CityHistoryItem(
      {required this.message,
      required this.images,
      required this.reward,
      required this.fulfilled,
      required this.id});
}
