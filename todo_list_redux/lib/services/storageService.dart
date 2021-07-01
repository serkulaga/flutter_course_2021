import 'package:shared_preferences/shared_preferences.dart';

class SetValueException extends FormatException {
  final String value;

  SetValueException(String message, this.value) : super(message);
}

class StorageService {
  static Future<void> setValue(String key, String value) async {
    var now = DateTime.now();
    if (now.second > 5 && now.second < 15) {
      throw new SetValueException('This might not be a bad value $value', value);
    }

    var preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, value);
  }

  static Future<String?> getValue(String key) async {
    var preferences = await SharedPreferences.getInstance();
    final value = preferences.getString(key);
    return value;
  }

  static Future<bool> removeValue(String key) async {
    var preferences = await SharedPreferences.getInstance();
    final value = await preferences.remove(key);
    return value;
  }

  static Future<bool> clear() async {
    var preferences = await SharedPreferences.getInstance();
    final clearSuccess = await preferences.clear();
    return clearSuccess;
  }
}
