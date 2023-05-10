import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:appshop/model/json_model.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ConnecNetwork {
  ConnecNetwork._internal();

  static final ConnecNetwork _instance = ConnecNetwork._internal();

  factory ConnecNetwork() {
    return _instance;
  }

  static final _dio = Dio();

  Future<List<Testjason>> getproductAll_forSell() async {
    const uri = 'https://59b9-2001-fb1-11a-2205-fd7f-9dcd-1a62-505c.ngrok-free.app/users/single/1';
    final Response response = await _dio.get(uri);
    if (response.statusCode == 200) {
      log("${testjasonFromJson(jsonEncode(response.data))}");
      return testjasonFromJson(jsonEncode(response.data));
    }
    throw Exception("แตก function get");
  }

  Future<List<Testjason>> getproduct_forSell(String uid ) async {
    final uri = 'https://59b9-2001-fb1-11a-2205-fd7f-9dcd-1a62-505c.ngrok-free.app/users_sell/$uid/1';
    final Response response = await _dio.get(uri);
    if (response.statusCode == 200) {
      log("${testjasonFromJson(jsonEncode(response.data))}");
      return testjasonFromJson(jsonEncode(response.data));
    }
    throw Exception("แตก function get");
  }

  Future<List<Testjason>> getproduct_forBuy(String uid ) async {
    final uri = 'https://59b9-2001-fb1-11a-2205-fd7f-9dcd-1a62-505c.ngrok-free.app/users_buy/$uid/1';
    final Response response = await _dio.get(uri);
    if (response.statusCode == 200) {
      log("${testjasonFromJson(jsonEncode(response.data))}");
      return testjasonFromJson(jsonEncode(response.data));
    }
    throw Exception("แตก function get");
  }

  Future<String> createProduct(
    final Map<String, dynamic> dataUser,
    String name_product,
    File image_product,
    int price,
    int amount, {
    int? sell,
    int? buy,
  }) async {

    log("111111111111${name_product}");

    final uri = 'https://59b9-2001-fb1-11a-2205-fd7f-9dcd-1a62-505c.ngrok-free.app/users';
    log("11111 ${image_product}");
    log("aaaaaaaaaa ${price}");
    log("bbbbbbbbbb ${amount}");
    final ref = FirebaseStorage.instance.ref().child("product/").child(
        "${sell == 1 ? "ขาย  ${dataUser['email']} ${DateTime.now()}" : "ซื้อ  ${dataUser['email']}"}");
    // "${sell == 1 ? "ขาย  ${dataUser['email']} ${DateTime.now()}" : "ซื้อ  ${dataUser['email']}"}"
    await ref.putFile(image_product);
    String imageURL = await ref.getDownloadURL();
    // FormData formData =FormData.fromMap({
    // });
    final Response response = await _dio.post(uri, data: {
      "uid":    "${dataUser['uid']}",
      "name_product":  name_product,
      "price":  price,
      "amount":  amount,
      "sell":  sell == null? 0: sell,
      "buy":  buy == null? 0:buy,
      "image_product":  imageURL,

    });
    log("$response");
    if (response.statusCode == 201) {
      // log("${testjasonFromJson(jsonEncode(response.data))}");
      return "Add successfully";
    }
    throw Exception("แตก function post");
  }

  Future<String> buyProduct(
      final Map<String, dynamic> dataUser,
      String name_product,
      String image_product,
      int price,
      int amount, {
        int? sell,
        int? buy,
      }) async {

    log("111111111111${name_product}");

    final uri = 'https://59b9-2001-fb1-11a-2205-fd7f-9dcd-1a62-505c.ngrok-free.app/users';
    log("11111 ${image_product}");
    log("aaaaaaaaaa ${price}");
    log("bbbbbbbbbb ${amount}");

    // FormData formData =FormData.fromMap({
    // });
    final Response response = await _dio.post(uri, data: {
      "uid":    "${dataUser['uid']}",
      "name_product":  name_product,
      "price":  price,
      "amount":  amount,
      "sell":  sell == null? 0: sell,
      "buy":  buy == null? 0:buy,
      "image_product":  image_product,

    });
    log("$response");
    if (response.statusCode == 201) {
      // log("${testjasonFromJson(jsonEncode(response.data))}");
      return "Add successfully";
    }
    throw Exception("แตก function post");
  }


  Future<String> updateProduct(String name_product, int price,int amount ,int id) async {
    final uri = 'https://59b9-2001-fb1-11a-2205-fd7f-9dcd-1a62-505c.ngrok-free.app/update/$id';

    // FormData formData =FormData.fromMap({
    // });
    final Response response = await _dio.patch(uri, data: {
      "name_product": name_product,
      "price": price,
      "amount":amount,
      "update_At": "${DateTime.now()}"
    });
    log("$response");
    if (response.statusCode == 200) {
      // log("${testjasonFromJson(jsonEncode(response.data))}");
      return "UpDate successfully";
    }
    throw Exception("แตก function phat");
  }

  Future<String> delete(int id) async {
    final uri = 'https://59b9-2001-fb1-11a-2205-fd7f-9dcd-1a62-505c.ngrok-free.app/delete/$id';

    // FormData formData =FormData.fromMap({
    // });
    final Response response = await _dio.delete(uri

        // data: {
        //   "num1": "aa",
        //   "num2": "33333",
        // }
        );
    log("$response");
    if (response.statusCode == 200) {
      return "delete successfully";
    }
    throw Exception("แตก function delete");
  }


  // Future<List<Testjason>> getlogin() async {
  //   const uri =
  //       'https://ec86-2001-fb1-118-cfd4-b90b-c51b-30d1-dda0.ngrok-free.app/users/single/24';
  //   final Response response = await _dio.get(uri);
  //   log("1     ${response}");
  //   if (response.statusCode == 200) {
  //     log("2 ${response.data["status"]}");
  //     return response.data;
  //   }
  //   throw Exception("แตก function get");
  // }
  //
  // dynamic getapi() async {
  //   const uri = 'https://fc1c-49-237-14-83.ngrok-free.app/users/single/s';
  //   var res = await _dio.get(uri);
  //   log("111     ${res.data[0]['status']}");
  //
  //   if (res.data == 0) {
  //     log("ค่าว่างงงงงงงงงงงงงงงงงงงงงงงงงงงงงงงงงงงงงงงงงงงง");
  //   }
  //   return res.data;
  // }
  //
  // Future<String> post(Testjason testjason) async {
  //   final uri =
  //       'https://61bc-2001-fb1-11a-73b6-6d86-88fc-9463-45ed.ap.ngrok.io/users';
  //
  //   // FormData formData =FormData.fromMap({
  //   // });
  //   final Response response = await _dio.post(uri, data: {
  //     // "status": "0",
  //     // "num2": testjason.num2,
  //     // "num3": testjason.num3,
  //     // "num4": testjason.num4
  //   });
  //   log("$response");
  //   if (response.statusCode == 201) {
  //     log("${testjasonFromJson(jsonEncode(response.data))}");
  //     return "Add successfully";
  //   }
  //   throw Exception("แตก function post");
  // }

}
