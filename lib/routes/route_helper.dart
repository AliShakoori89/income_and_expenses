import 'package:get/get.dart';
import 'package:income_and_expenses/pages/home_page.dart';

class RouteHelper{

  static const String initial = "/";


  static String getInitial()=> initial;

  static List<GetPage> routes = [

    GetPage(name: initial , page: ()=> MyHomePage(),
        transition:  Transition.fadeIn),
  ];
}