import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sheared;

  static init() async {
    sheared = await SharedPreferences.getInstance();
  }
  static Future<bool>  putData({required String key,required value})async{
 return await sheared!.setBool(key, value);

  }
  static bool?  getBoolData({ key}){
 return  sheared!.getBool(key);

  }
}
