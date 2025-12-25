class Category {
  final int id;
  final String slug;
  final String name;
  final String description;
  final String image;
  final int subcategoryCount;

  Category({
    required this.id,
    required this.slug,
    required this.name,
    required this.description,
    required this.image,
    this.subcategoryCount = 0,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    final categoryData = json['category'] ?? json;
    
    int parseSubcategoryCount(dynamic value) {
      if (value == null) return 0;
      if (value is int) return value;
      if (value is String) return int.tryParse(value) ?? 0;
      if (value is List) return value.length;
      return 0;
    }
    
    return Category(
      id: categoryData['id'] ?? 0,
      slug: categoryData['slug']?.toString() ?? '',
      name: categoryData['name']?.toString() ?? '',
      description: categoryData['description']?.toString() ?? '',
      image: categoryData['image']?.toString() ?? '',
      subcategoryCount: parseSubcategoryCount(json['subcategory']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'slug': slug,
      'name': name,
      'description': description,
      'image': image,
      'subcategory': subcategoryCount,
    };
  }
}
