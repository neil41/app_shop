// To parse this JSON data, do
//
//     final testjason = testjasonFromJson(jsonString);

import 'dart:convert';

List<Testjason> testjasonFromJson(String str) => List<Testjason>.from(json.decode(str).map((x) => Testjason.fromJson(x)));

String testjasonToJson(List<Testjason> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Testjason {
  int id;
  String uid;
  int idProduct;
  String nameProduct;
  int price;
  int sell;
  int buy;
  DateTime createAt;
  String updateAt;
  int amount;
  String imageProduct;

  Testjason({
    required this.id,
    required this.uid,
    required this.idProduct,
    required this.nameProduct,
    required this.price,
    required this.sell,
    required this.buy,
    required this.createAt,
    required this.updateAt,
    required this.amount,
    required this.imageProduct,
  });

  factory Testjason.fromJson(Map<String, dynamic> json) => Testjason(
    id: json["id"],
    uid: json["uid"],
    idProduct: json["id_product"],
    nameProduct: json["name_product"],
    price: json["price"],
    sell: json["sell"],
    buy: json["buy"],
    createAt: DateTime.parse(json["create_AT"]),
    updateAt: json["update_AT"],
    amount: json["amount"],
    imageProduct: json["image_product"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uid": uid,
    "id_product": idProduct,
    "name_product": nameProduct,
    "price": price,
    "sell": sell,
    "buy": buy,
    "create_AT": createAt.toIso8601String(),
    "update_AT": updateAt,
    "amount": amount,
    "image_product": imageProduct,
  };
}
