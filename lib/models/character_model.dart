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
  final bool isFav;
  CharacterModel({
    required this.id,
    required this.detailedImg,
    required this.name,
    required this.realName,
    required this.deck,
    required this.image,
    required this.publisher,
    required this.origin,
    this.isFav = false,
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
  CharacterModel copyWithin({bool? isFav}) {
    return CharacterModel(
      id: id,
      detailedImg: detailedImg,
      name: name,
      realName: realName,
      deck: deck,
      image: image,
      publisher: publisher,
      origin: origin,
      issueAppearances: issueAppearances,
      isFav: isFav??this.isFav
    );
  }
}
