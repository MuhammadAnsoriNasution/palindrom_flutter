import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:palindrome_flutter/models/user_model.dart';

class UserService {
  String baseUrl = 'https://reqres.in/api/users';

  Future<Map<String, dynamic>> getCoordinate() async {
    final String response =
        await rootBundle.loadString('assets/coordinate.json');
    final data = await json.decode(response);
    int randomNumber = Random().nextInt(100) + 1;
    return data[randomNumber];
  }

  Future<Map<String, dynamic>> getUsers({int page = 1}) async {
    var url = Uri.parse('$baseUrl?page=$page&per_page=6');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'];
      int totalPages = jsonDecode(response.body)['total_pages'];

      List<UserModel> users = [];
      for (var item in data) {
        Map<String, dynamic> modif = item;
        modif['coordinate'] = await getCoordinate();
        users.add(UserModel.fromJson(modif));
      }
      return {
        'users': users,
        'total_item': totalPages,
      };
    }
    throw Exception("Gagal mengambil data user");
  }
}
