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

  ComicModel({
    required this.id,
    required this.name,
    required this.issueNumber,
    required this.description,
    required this.image,
    required this.volumeName,
    required this.volumeId,
    required this.coverDate,
    required this.storeDate,
  });

  factory ComicModel.fromJson(Map<String, dynamic> json) {
    return ComicModel(
      id: json["id"] ?? 0,
      name: json["name"]??json["volume"]["name"] ?? "Unknown",
      issueNumber: json["issue_number"] ?? "0",
      description: json["description"] ?? "No discription",
      image: json["image"]?["medium_url"] ?? "",
      volumeName: json["volume"]?["name"] ?? "unknown",
      volumeId: json["volume"]?["id"] ?? 0,
      coverDate: json["cover_date"] ?? "no",
      storeDate: json["store_date"] ?? "no",
    );
  }
}