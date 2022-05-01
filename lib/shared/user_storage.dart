import 'package:framework/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserStorage {
  static const String _kFirebaseTokenKey = 'firebase_token_key';
  static const String _kLanguageCodeKey = 'language_code_key';

  static void setFirebaseToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(_kFirebaseTokenKey, token);
  }

  static Future<String?> getFirebaseToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(_kFirebaseTokenKey);
  }

  static void setLanguageCode(AvailableLanguages languageCode) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(_kLanguageCodeKey, languageCode.value);
  }

  static Future<String?> getLanguageCode() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(_kLanguageCodeKey);
  }
}
