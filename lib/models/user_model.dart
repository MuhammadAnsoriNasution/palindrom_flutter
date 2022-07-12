import 'package:palindrome_flutter/models/coordinate_model.dart';

class UserModel {
  late int id;
  late String email;
  late String firstName;
  late String lastName;
  late String avatar;
  late CoordinateModel coordinate;

  UserModel(
      {required this.id,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.avatar,
      required this.coordinate});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatar = json['avatar'];
    coordinate = CoordinateModel.fromJson(json['coordinate']);
  }
}
