class GamesDetailsModel {
  final int gameId;

  final String imagePath;

  final String name;

  final String companyName;

  final int gradesQuantity;

  final double grade;

  final int downloadsQuantity;

  final double weight;

  final String description;

  final List<String> screenshotList;

  GamesDetailsModel(
      {required this.imagePath,
      required this.name,
      required this.companyName,
      required this.gradesQuantity,
      required this.grade,
      required this.downloadsQuantity,
      required this.weight,
      required this.description,
      required this.gameId,
      required this.screenshotList});
}
