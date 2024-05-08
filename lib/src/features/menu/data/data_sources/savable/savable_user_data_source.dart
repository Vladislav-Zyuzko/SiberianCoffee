import 'dart:convert';

import 'package:siberian_coffee/src/features/menu/models/dto/user/user_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class ISavableUserDataSource {
  UserDto loadUser();
  Future<void> saveUser({required UserDto user});
}

class PreferencesUserDataSource implements ISavableUserDataSource {
  final SharedPreferences _prefs;

  const PreferencesUserDataSource({
    required SharedPreferences prefs,
  }) : _prefs = prefs;

  @override
  UserDto loadUser() {
    return UserDto.fromJson(json.decode(_prefs.getString('user_data') ?? ""));
  }

  @override
  Future<void> saveUser({required UserDto user}) async {
    await _prefs.setString('user_data', json.encode(user.toJson()));
  }
}
