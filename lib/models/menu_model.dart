class MenuModel {
  final String id;
  final String name;
  final int price;
  final String image;

  MenuModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'price': price,
      'image': image,
    };
  }

  factory MenuModel.fromJson(Map<String, dynamic> map) {
    return MenuModel(
      id: map['id'] as String,
      name: map['name'] as String,
      price: map['price'] as int,
      image: map['image'] as String,
    );
  }
}
