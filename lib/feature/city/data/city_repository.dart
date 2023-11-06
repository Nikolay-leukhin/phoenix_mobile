import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:phoenix_mobile/feature/city/ui/pages/history_screen.dart';
import 'package:phoenix_mobile/models/city_history_item.dart';
import 'package:phoenix_mobile/services/remote/api/api_service.dart';

class CityRepository {
  final ApiService apiService;

  CityRepository({required this.apiService});

  String message = '';

  /// Для варианта со сканированием
  String scannedCode = '';

  List<XFile> images = [];
  List<Uint8List> imagesAsBytes = [];

  Future generateBytes() async {
    imagesAsBytes.clear();

    for (var i in images) {
      imagesAsBytes.add(await i.readAsBytes());
    }
  }

  Future<void> getImagesFromGallery() async {
    final newImages = await ImagePicker().pickMultiImage();
    images.addAll(newImages);
    await generateBytes();
  }

  Future<void> getImageFromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) images.add(image);
    await generateBytes();
  }

  CityHistoryItem getAppeal(String id) {
    return CityHistoryItem(
        message: 'Там ещё кажется, провода как-то свисают странно',
        images: imagesAsBytes,
        reward: 15,
        fulfilled: false,
        id: id);
  }
}
