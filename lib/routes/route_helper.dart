import 'package:get/get.dart';
import 'package:income_and_expenses/pages/add_expense_page.dart';
import 'package:income_and_expenses/pages/home_page.dart';
import 'package:income_and_expenses/pages/search_page.dart';

class RouteHelper{

  static const String initial = "/";
  static const String addPage = "/addPage";
  static const String searchPage = "/searchPage";


  static String getInitial()=> initial;
  static String getAddPage()=> addPage;
  static String getSearchPage()=> searchPage;

  static List<GetPage> routes = [

    GetPage(name: initial , page: ()=> MyHomePage(),
        transition:  Transition.fadeIn),

    GetPage(name: addPage , page: ()=> const AddExpensePage(),
        transition:  Transition.fadeIn),

    GetPage(name: searchPage , page: ()=> const SearchPage(),
        transition:  Transition.fadeIn),
  ];
}