class CategoryModel {
  CategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    required this.creationAt,
    required this.updatedAt,
  });

  final int? id;
  final String? name;
  final String? slug;
  final String? image;
  final DateTime? creationAt;
  final DateTime? updatedAt;

  CategoryModel copyWith({
    int? id,
    String? name,
    String? slug,
    String? image,
    DateTime? creationAt,
    DateTime? updatedAt,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      image: image ?? this.image,
      creationAt: creationAt ?? this.creationAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json["id"],
      name: json["name"],
      slug: json["slug"],
      image: json["image"],
      creationAt: DateTime.tryParse(json["creationAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "image": image,
    "creationAt": creationAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
