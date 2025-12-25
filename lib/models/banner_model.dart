class Banner {
  final int id;
  final String title;
  final String subTitle;
  final String buttonText;
  final String image;
  final String mobileImage;
  final int linkType;
  final String linkValue;

  Banner({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.buttonText,
    required this.image,
    required this.mobileImage,
    required this.linkType,
    required this.linkValue,
  });

  factory Banner.fromJson(Map<String, dynamic> json) {
    return Banner(
      id: json['id'] ?? 0,
      title: json['title']?.toString() ?? '',
      subTitle: json['sub_title']?.toString() ?? '',
      buttonText: json['button_text']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      mobileImage: json['mobile_image']?.toString() ?? '',
      linkType: json['link_type'] ?? 0,
      linkValue: json['link_value']?.toString() ?? '#',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'sub_title': subTitle,
      'button_text': buttonText,
      'image': image,
      'mobile_image': mobileImage,
      'link_type': linkType,
      'link_value': linkValue,
    };
  }
}
