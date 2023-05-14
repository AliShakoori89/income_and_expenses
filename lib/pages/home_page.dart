import 'package:flutter/material.dart';
import 'package:income_and_expenses/pages/main_expenses_page.dart';
import 'package:income_and_expenses/pages/setting_page.dart';
import 'package:income_and_expenses/pages/year_chart_page.dart';
import 'package:income_and_expenses/const/app_colors.dart';
import 'add_expense_page.dart';
import 'month_chart_page.dart';

class MyHomePage extends StatefulWidget {

  // bool isViewed;

  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {

  var _bottomNavIndex = 0; //default index of a first screen

  List<Widget> _pages() =>
      [
        MainExpensesPage(),
        const MonthChart(),
        const YearChartPage(),
        const SettingPage(),
      ];

  // late AnimationController _fabAnimationController;
  // late AnimationController _borderRadiusAnimationController;
  // late Animation<double> fabAnimation;
  // late Animation<double> borderRadiusAnimation;
  // late CurvedAnimation fabCurve;
  // late CurvedAnimation borderRadiusCurve;
  // late AnimationController _hideBottomBarAnimationController;

  final iconList = <IconData>[
    Icons.home,
    Icons.pie_chart,
    Icons.bar_chart,
    Icons.settings,
  ];

  // @override
  // void initState() {
  //
  //   super.initState();
  //   final systemTheme = SystemUiOverlayStyle.light.copyWith(
  //     systemNavigationBarIconBrightness: Brightness.light,
  //   );
  //   SystemChrome.setSystemUIOverlayStyle(systemTheme);
  //
  //   _fabAnimationController = AnimationController(
  //     duration: const Duration(milliseconds: 500),
  //     vsync: this,
  //   );
  //   _borderRadiusAnimationController = AnimationController(
  //     duration: const Duration(milliseconds: 500),
  //     vsync: this,
  //   );
  //   fabCurve = CurvedAnimation(
  //     parent: _fabAnimationController,
  //     curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
  //   );
  //   borderRadiusCurve = CurvedAnimation(
  //     parent: _borderRadiusAnimationController,
  //     curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
  //   );
  //
  //   fabAnimation = Tween<double>(begin: 0, end: 1).animate(fabCurve);
  //   borderRadiusAnimation = Tween<double>(begin: 0, end: 1).animate(
  //     borderRadiusCurve,
  //   );
  //
  //   _hideBottomBarAnimationController = AnimationController(
  //     duration: const Duration(milliseconds: 200),
  //     vsync: this,
  //   );
  //
  //   Future.delayed(
  //     const Duration(seconds: 1),
  //         () => _fabAnimationController.forward(),
  //   );
  //   Future.delayed(
  //     const Duration(seconds: 1),
  //         () => _borderRadiusAnimationController.forward(),
  //   );
  // }

  // bool onScrollNotification(ScrollNotification notification) {
  //   if (notification is UserScrollNotification &&
  //       notification.metrics.axis == Axis.vertical) {
  //     switch (notification.direction) {
  //       case ScrollDirection.forward:
  //         _hideBottomBarAnimationController.reverse();
  //         _fabAnimationController.forward(from: 0);
  //         break;
  //       case ScrollDirection.reverse:
  //         _hideBottomBarAnimationController.forward();
  //         _fabAnimationController.reverse(from: 1);
  //         break;
  //       case ScrollDirection.idle:
  //         break;
  //     }
  //   }
  //   return false;
  // }

  void onTapNav(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    final List<Widget> pages = _pages();

    return Scaffold(
      body: pages[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.calenderBoxColor,
        selectedItemColor: AppColors.mainColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label:'',
          ),
        ],
        currentIndex: _bottomNavIndex,
        onTap: onTapNav,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.mainColor,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddExpensePage()),
          );
        },
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}