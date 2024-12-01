import 'package:shared_preferences/shared_preferences.dart';

class CashHelper{

  static late SharedPreferences _preferences;

  static Future<void> init() async {
    _preferences=await SharedPreferences.getInstance();
  }


  static saveLanguage(String language){
    _preferences.setString("language", language);
  }

  static String getLanguage(){
    return _preferences.getString("language")??"ar";
  }
}