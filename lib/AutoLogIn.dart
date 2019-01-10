
import 'package:shared_preferences/shared_preferences.dart';
class AutoLogIn{

   static final String _logged_in = 'loggedin';
  static final String _id = 'id';
  static final String _name = 'name';
  static final String _username = 'username';
  static final String _level = 'level';
  static final String _status = 'status';

  static Future<bool> get_logged_in() async{
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    return preferences.getBool(_logged_in) ?? false;
  }

  static Future<bool> set_logged_in(bool value) async{
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setBool(_logged_in, value);
  }

  static Future<String> get_id() async{
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    return preferences.getString(_id) ?? 'name';
  }

  static Future<bool> set_id(String value) async{
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(_id, value);
  }

}