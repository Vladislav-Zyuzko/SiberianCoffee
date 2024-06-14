import 'package:shared_preferences/shared_preferences.dart';

abstract interface class ISavableTokenDataSource {
  String? loadFcmToken();
  Future<void> saveFcmToken({required String fcmToken});
}

class TokenDataSource implements ISavableTokenDataSource {
  final SharedPreferences _prefs;

  const TokenDataSource({required SharedPreferences prefs}) : _prefs = prefs;

  @override
  String? loadFcmToken() {
    String? fcmToken = _prefs.getString('fcmToken');
    return fcmToken;
  }

  @override
  Future<void> saveFcmToken({required String fcmToken}) async {
    await _prefs.setString(
      'fcmToken', 
      fcmToken,
    );
  }
}