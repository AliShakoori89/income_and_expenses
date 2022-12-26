import 'package:shared_preferences/shared_preferences.dart';

class SetDateRepository {

  writeDate(String date) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('date', date);
  }

  Future<String> readDate() async{
    final prefs = await SharedPreferences.getInstance();
    final String? date = prefs.getString('date');
    return date!;
  }
}