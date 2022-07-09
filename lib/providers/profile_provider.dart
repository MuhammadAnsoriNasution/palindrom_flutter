import 'package:flutter/material.dart';
import 'package:palindrome_flutter/models/profile_model.dart';

class ProfileProvider with ChangeNotifier {
  ProfileModel _profile = ProfileModel(avatar: '', name: '', email: '');

  ProfileModel get profile => _profile;

  set profile(ProfileModel profile) {
    _profile = profile;
    notifyListeners();
  }
}
