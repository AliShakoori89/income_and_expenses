import 'package:shared_preferences/shared_preferences.dart';

class IncomeRepository {

  addIncome(String income, String month) async {
    final prefs = await SharedPreferences.getInstance();
    print("1111111111         "+ income);
    print("2222222222222         "+ month);
    await prefs.setString('income$month', income);
  }

  Future<String?> readIncome(String month) async {
    final prefs = await SharedPreferences.getInstance();
    String? income = prefs.getString('income$month');
    print("333333333333          "+income!);
    if(income.isEmpty){
      return '';
    }else{
      return income;
    }
  }
}