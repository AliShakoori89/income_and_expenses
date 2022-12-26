import 'package:shared_preferences/shared_preferences.dart';

class SetDateRepository {

  writeDate(String date) async{
    final prefs = await SharedPreferences.getInstance();
    print("44444   ;;; "+date.toString());
    await prefs.setString('date', date);
  }

  Future<String> readDate() async{
    final prefs = await SharedPreferences.getInstance();
    final String? date = prefs.getString('date');
    print("33333   ;;; "+date.toString());
    return date!;
  }
}