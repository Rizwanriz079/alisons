class Product {
  final String slug;
  final String name;
  final String store;
  final String manufacturer;
  final String symbolLeft;
  final String symbolRight;
  final String oldPrice;
  final String price;
  final String discount;
  final String image;
  final String? description;

  Product({
    required this.slug,
    required this.name,
    required this.store,
    required this.manufacturer,
    required this.symbolLeft,
    required this.symbolRight,
    required this.oldPrice,
    required this.price,
    required this.discount,
    required this.image,
    this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      slug: json['slug']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      store: json['store']?.toString() ?? '',
      manufacturer: json['manufacturer']?.toString() ?? '',
      symbolLeft: json['symbol_left']?.toString() ?? '',
      symbolRight: json['symbol_right']?.toString() ?? '',
      oldPrice: json['oldprice']?.toString() ?? '0.00',
      price: json['price']?.toString() ?? '0.00',
      discount: json['discount']?.toString() ?? '0|nil',
      image: json['image']?.toString() ?? '',
      description: json['description']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'slug': slug,
      'name': name,
      'store': store,
      'manufacturer': manufacturer,
      'symbol_left': symbolLeft,
      'symbol_right': symbolRight,
      'oldprice': oldPrice,
      'price': price,
      'discount': discount,
      'image': image,
      'description': description,
    };
  }

  bool get hasDiscount {
    return !discount.contains('nil') && discount != '0|nil';
  }

  String get formattedPrice {
    return '$symbolLeft$price$symbolRight';
  }

  String get formattedOldPrice {
    return '$symbolLeft$oldPrice$symbolRight';
  }
}
