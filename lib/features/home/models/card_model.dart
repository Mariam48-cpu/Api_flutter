class CartModel {
  final int id;
  final String title;
  final double price;
  final String image;
  final String description;
  int quantity;

  CartModel({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.description,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "price": price,
      "image": image,
      "description": description,
      "quantity": quantity,
    };
  }

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json["id"],
      title: json["title"],
      price: (json["price"] as num).toDouble(),
      image: json["image"] ?? "",
      description: json["description"],
      quantity: json["quantity"],
    );
  }
}
