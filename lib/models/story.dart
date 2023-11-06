import 'package:flutter_dotenv/flutter_dotenv.dart';

class Story {
  final String title;
  final String subtitle;
  final String imageUrl;
  final String previewUrl;
  final Duration duration;
  final String? buttonUrl;
  final int index;
  final String id;

  Story(
      {required this.title,
      required this.subtitle,
      required this.imageUrl,
      required this.duration,
      required this.index,
      required this.id,
      required this.previewUrl,
      this.buttonUrl});

  Story.fromJson({required Map<String, dynamic> json, required this.index})
      : title = json['head'].substring(
            0, json['head'].length < 50 ? json['head'].length : 50),
        subtitle = json['message'].substring(
            0, json['message'].length < 150 ? json['message'].length : 150),
        imageUrl = dotenv.get('BASE_SERVER_URL') + '/media/' + json['logo'],
        previewUrl = dotenv.get('BASE_SERVER_URL') + '/media/' + json['logo'],
        duration = const Duration(seconds: 10),
        buttonUrl = json['link'],
        id = json['id'];
}
