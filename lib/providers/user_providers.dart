import 'package:flutter/material.dart';
import 'package:palindrome_flutter/models/user_model.dart';
import 'package:palindrome_flutter/services/user_serrvice.dart';

class UserProvider with ChangeNotifier {
  List<UserModel> _users = [];
  int _totalPage = 0;
  bool _loading = true;

  List<UserModel> get users => _users;
  bool get loading => _loading;
  int get totalPage => _totalPage;

  set users(List<UserModel> users) {
    _users = users;
    notifyListeners();
  }

  set totalPage(int totalPage) {
    _totalPage = totalPage;
    notifyListeners();
  }

  set loading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  Future<void> getusers({int page = 1}) async {
    try {
      Map<String, dynamic> data = await UserService().getUsers(page: page);
      loading = false;

      if (page > 1) {
        users = [..._users, ...data['users']];
      } else {
        users = data['users'];
      }
      totalPage = data['total_item'];
    } catch (e) {
      loading = false;
      print(e);
    }
  }
}
