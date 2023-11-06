import 'package:izobility_mobile/models/games_details.dart';

class GamesRepository {
  var lastLoadedGameDetials = GamesDetailsModel(
      imagePath: 'https://i1.sndcdn.com/avatars-fjtJXHBHViuYaNzg-Zz82KA-t500x500.jpg',
      companyName: 'KOlya corp',
      description:
          "Ясность нашей позиции очевидна: убеждённость некоторых оппонентов позволяет оценить значение глубокомысленных рассуждений. Равным образом, убеждённость некоторых оппонентов выявляет срочную потребность приоретизации разума над эмоциями. Идейные соображения высшего порядка, а также новая модель организационной деятельности представляет собой интересный эксперимент проверки дальнейших направлений развития. В своём стремлении улучшить пользовательский опыт мы упускаем, что тщательные исследования конкурентов будут представлены в исключительно положительном свете.",
      downloadsQuantity: 123,
      grade: 4.3,
      gradesQuantity: 100,
      name: 'fuck my ass',
      weight: 102,
      gameId: 0,
      screenshotList: [
        "https://w-hatsapp.ru/wp-content/uploads/2017/05/screenshot-2017-05-19-001-3.png",
        "https://www.meme-arsenal.com/memes/27a806f3052a722004a4bce280b9e4fe.jpg",
        "https://otkritkis.com/wp-content/uploads/2022/06/perwh.jpg",
        "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/Wikipe-tan_full_length.svg/1200px-Wikipe-tan_full_length.svg.png",
        "https://waxaxablog.files.wordpress.com/2017/01/image297.jpg?w=500"
      ]);

  void loadLastGameDetails(int gameId) {}
}
