class CharacterModel {
  final int id;
  final String detailedImg;
  final String name;
  final String realName;
  final String deck;
  final String image;
  final String publisher;
  final String origin;
  final int issueAppearances;

  CharacterModel({
    required this.id,
    required this.detailedImg,
    required this.name,
    required this.realName,
    required this.deck,
    required this.image,
    required this.publisher,
    required this.origin,
    required this.issueAppearances,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json["id"] ?? 0,
      detailedImg:
          json["image"]?["original_url"] ?? json["image"]?["super_url"] ?? "",
      name: json["name"] ?? "",
      realName: json["real_name"] ?? "",
      deck: json["deck"] ?? "",
      image: json["image"]?["medium_url"] ?? "",
      publisher: json["publisher"]?["name"] ?? "",
      origin: json["origin"]?["name"] ?? "",
      issueAppearances: json["count_of_issue_appearances"] ?? 0,
    );
  }
}
