import 'package:get/get.dart';
import 'package:income_and_expenses/pages/add_expense_page.dart';
import 'package:income_and_expenses/pages/frequently_asked_questions.dart';
import 'package:income_and_expenses/pages/home_page.dart';
import 'package:income_and_expenses/pages/profile_page.dart';
import 'package:income_and_expenses/pages/search_page.dart';

class RouteHelper{

  static const String initial = "/";
  // static const String addPage = "/addPage";
  static const String searchPage = "/searchPage";
  static const String frequentlyAskedQuestions = "/frequentlyAskedQuestions";
  static const String profilePage = "/profilePage";


  static String getInitial()=> initial;
  // static String getAddPage()=> addPage;
  static String getSearchPage()=> searchPage;
  static String getFrequentlyAskedQuestions()=> frequentlyAskedQuestions;
  static String getProfilePage()=> profilePage;

  static List<GetPage> routes = [

    GetPage(name: initial , page: ()=> MyHomePage(),
        transition:  Transition.fadeIn),

    // GetPage(name: addPage , page: ()=> AddExpensePage(),
    //     transition:  Transition.fadeIn),

    GetPage(name: searchPage , page: ()=> const SearchPage(),
        transition:  Transition.fadeIn),

    GetPage(name: frequentlyAskedQuestions , page: ()=> const FrequentlyAskedQuestions(),
        transition:  Transition.fadeIn),

    GetPage(name: profilePage , page: ()=> const ProfilePage(),
        transition:  Transition.fadeIn),
  ];
}