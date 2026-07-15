class ComicModel {
  final int id;
  final String name;
  final String issueNumber;
  final String description;
  final String image;
  final String volumeName;
  final int volumeId;
  final String coverDate;
  final String storeDate;
  final bool isFav;

  ComicModel({
    required this.id,
    required this.name,
    required this.issueNumber,
    required this.description,
    required this.image,
    required this.volumeName,
    this.isFav = false,
    required this.volumeId,
    required this.coverDate,
    required this.storeDate,
  });

  factory ComicModel.fromJson(Map<String, dynamic> json) {
    return ComicModel(
      id: json["id"] ?? 0,
      name: json["name"] ?? json["volume"]["name"] ?? "Unknown",
      issueNumber: json["issue_number"] ?? "0",
      description: json["description"] ?? "No discription",
      image: json["image"]?["medium_url"] ?? "",
      volumeName: json["volume"]?["name"] ?? "unknown",
      volumeId: json["volume"]?["id"] ?? 0,
      coverDate: json["cover_date"] ?? "no",
      storeDate: json["store_date"] ?? "no",
    );
  }

  ComicModel copyWithin({bool? isFav}) {
    return ComicModel(
      id: id,
      name: name,
      issueNumber: issueNumber,
      description: description,
      image: image,
      volumeName: volumeName,
      volumeId: volumeId,
      coverDate: coverDate,
      storeDate: storeDate,
      isFav: isFav ?? this.isFav,
    );
  }
}
