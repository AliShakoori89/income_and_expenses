import 'package:shared_preferences/shared_preferences.dart';

class IncomeRepository {

  addIncome(String income) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('income', income);
  }

  Future<String?> readIncome() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('income');
  }
}