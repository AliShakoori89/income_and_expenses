import 'package:shared_preferences/shared_preferences.dart';

class IncomeRepository {

  addIncome(String income, String month) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('income$month', income);
  }

  Future<String?> readIncome(String month) async {
    final prefs = await SharedPreferences.getInstance();
    String? income = prefs.getString('income$month');
    if(income == null){
      return '';
    }else{
      return income;
    }
  }
}