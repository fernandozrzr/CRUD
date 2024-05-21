import 'dart:convert';
import 'package:http/http.dart' as http;
import '/model/product_model.dart';

class Api {
  static const baseUrl = "http://192.168.18.17:2000/api/";

  // Post method
  static Future<void> addProduct(Map<String, String> pdata) async {
    var url = Uri.parse("${baseUrl}add_product");

    try {
      final response = await http.post(url, body: pdata);

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        print(result);
      } else {
        print("Failed to add product, status code: ${response.statusCode}");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // Get method
  static Future<List<Product>> getProduct() async {
    List<Product> products = [];

    var url = Uri.parse("${baseUrl}get_product");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        for (var value in data) {
          products.add(
            Product(
              pname: value['pname'] ?? 'No name',
              pdescription: value['pdescription'] ?? 'No description',
              pprice: value['pprice'] != null
                  ? double.parse(value['pprice'].toString())
                  : 0.0,
              id: value['_id'].toString(),
            ),
          );
        }
        return products;
      } else {
        print("Failed to get products, status code: ${response.statusCode}");
        return products; // Return an empty list in case of a failure
      }
    } catch (e) {
      throw Exception("Error fetching products: $e");
    }
  }

  // Update method
  static updateProduct(id, body) async {
    var url = Uri.parse("${baseUrl}update_product/$id");

    try {
      final response = await http.put(url, body: body);

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        print(result);
      } else {
        print("Failed to update product, status code: ${response.statusCode}");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // Delete method
  static deleteProduct(id) async {
    var url = Uri.parse("${baseUrl}delete_product/$id");

    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        print(result);
      } else {
        print("Failed to delete product, status code: ${response.statusCode}");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
