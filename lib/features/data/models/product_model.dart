class ProductModel {
  ProductModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.price,
    required this.description,
    required this.category,
    required this.images,
    required this.creationAt,
    required this.updatedAt,
    this.isSelected = false,
  });

  final int? id;
  final String? title;
  final String? slug;
  final int? price;
  final String? description;
  final Category? category;
  final List<String> images;
  final DateTime? creationAt;
  final DateTime? updatedAt;

  bool isSelected = false;

  ProductModel copyWith({
    int? id,
    String? title,
    String? slug,
    int? price,
    String? description,
    Category? category,
    List<String>? images,
    DateTime? creationAt,
    DateTime? updatedAt,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      slug: slug ?? this.slug,
      price: price ?? this.price,
      description: description ?? this.description,
      category: category ?? this.category,
      images: images ?? this.images,
      creationAt: creationAt ?? this.creationAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"],
      title: json["title"],
      slug: json["slug"],
      price: json["price"],
      description: json["description"],
      category: json["category"] == null
          ? null
          : Category.fromJson(json["category"]),
      images: json["images"] == null
          ? []
          : List<String>.from(json["images"]!.map((x) => x)),
      creationAt: DateTime.tryParse(json["creationAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "slug": slug,
    "price": price,
    "description": description,
    "category": category?.toJson(),
    "images": images.map((x) => x).toList(),
    "creationAt": creationAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class Category {
  Category({
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

  Category copyWith({
    int? id,
    String? name,
    String? slug,
    String? image,
    DateTime? creationAt,
    DateTime? updatedAt,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      image: image ?? this.image,
      creationAt: creationAt ?? this.creationAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
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
