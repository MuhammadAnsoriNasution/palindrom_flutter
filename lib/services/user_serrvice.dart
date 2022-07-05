import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:palindrome_flutter/models/user_model.dart';

class UserService {
  String baseUrl = 'https://reqres.in/api/users';

  Future<Map<String, dynamic>> getUsers({int page = 1}) async {
    var url = Uri.parse('$baseUrl?page=$page&per_page=6');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'];
      int totalPages = jsonDecode(response.body)['total_pages'];

      List<UserModel> users = [];
      for (var item in data) {
        users.add(UserModel.fromJson(item));
      }
      return {
        'users': users,
        'total_item': totalPages,
      };
    }
    throw Exception("Gagal mengambil data user");
  }
}
