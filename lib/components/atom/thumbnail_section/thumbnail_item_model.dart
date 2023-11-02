class ThumbnailItemModel {
  final String? title;
  final double? price;
  final String image;
  final void Function()? onTap;

  ThumbnailItemModel({
    this.title,
    this.price,
    required this.image,
    this.onTap,
  });

  factory ThumbnailItemModel.fromJson(Map<String, dynamic> json) {
    return ThumbnailItemModel(
      title: json['title'],
      price: json['price'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'price': price,
        'image': image,
      };
}
