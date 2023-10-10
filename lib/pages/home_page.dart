import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expenses/pages/main_expenses_page.dart';
import 'package:income_and_expenses/pages/setting_page.dart';
import 'package:income_and_expenses/pages/sfcartesian_chart_page.dart';
import 'package:income_and_expenses/const/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import '../bloc/them_bloc/bloc.dart';
import '../bloc/them_bloc/state.dart';
import 'add_expense_page.dart';
import 'sf_circular_chart_page.dart';

class MyHomePage extends StatefulWidget {

  // bool isViewed;

  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {

  var _bottomNavIndex = 0;//default index of a first screen

  GlobalKey keyButton = GlobalKey();
  GlobalKey keyButton1 = GlobalKey();
  GlobalKey keyButton2 = GlobalKey();
  GlobalKey keyButton3 = GlobalKey();
  GlobalKey keyButton4 = GlobalKey();

  GlobalKey keyBottomNavigation1 = GlobalKey();
  GlobalKey keyBottomNavigation2 = GlobalKey();
  GlobalKey keyBottomNavigation3 = GlobalKey();
  GlobalKey keyBottomNavigation4 = GlobalKey();

  late TutorialCoachMark tutorialCoachMark;

  List<Widget> _pages() =>
      [
        MainExpensesPage(keyBottomNavigation1: keyBottomNavigation1,
            keyBottomNavigation2: keyBottomNavigation2,
            keyBottomNavigation3: keyBottomNavigation3,
            keyBottomNavigation4: keyBottomNavigation4),
        const SfCircularChartPage(),
        const SFCartesianChartPage(),
        const SettingPage(),
      ];

  final iconList = <IconData>[
    Icons.home,
    Icons.pie_chart,
    Icons.bar_chart,
    Icons.settings,
  ];

  @override
  void initState() {
    checkFirstSeen();
    // createTutorial();
    // Future.delayed(Duration.zero, showTutorial);
    super.initState();
  }

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getBool('seen') == null || prefs.getBool('seen') == false
        ? await prefs.setBool('seen', false)
        : await prefs.setBool('seen', true);

    if (prefs.getBool('seen') == false) {
      await prefs.setBool('seen', true);
      createTutorial();
      Future.delayed(Duration.zero, showTutorial);
    }
  }

  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  void showTutorial() {
    tutorialCoachMark.show(context: context);
  }

  void createTutorial() {
    tutorialCoachMark = TutorialCoachMark(
      targets: _createTargets(),
      colorShadow: AppColors.mainColor,
      textSkip: "SKIP",
      paddingFocus: 10,
      opacityShadow: 0.8,
      onFinish: () {
        print("finish");
      },
      onClickTarget: (target) {
        print('onClickTarget: $target');
      },
      onClickTargetWithTapPosition: (target, tapDetails) {
        print("target: $target");
        print(
            "clicked at position local: ${tapDetails.localPosition} - global: ${tapDetails.globalPosition}");
      },
      onClickOverlay: (target) {
        print('onClickOverlay: $target');
      },
      onSkip: () {
        print("skip");
      },
    );
  }

  List<TargetFocus> _createTargets() {
    List<TargetFocus> targets = [];
    targets.add(
      TargetFocus(
      identify: "keyButton",
      keyTarget: keyButton,
      alignSkip: Alignment.topRight,
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) {
            return const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "صفحه اصلی",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    ),);
    targets.add(
      TargetFocus(
      identify: "keyButton1",
      keyTarget: keyButton1,
      alignSkip: Alignment.topRight,
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) {
            return const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "نمودار هزیته های مالانه",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    ),);
    targets.add(
      TargetFocus(
      identify: "keyButton2",
      keyTarget: keyButton2,
      alignSkip: Alignment.topRight,
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) {
            return const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "اضافه کردن هزینه ",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    ),);
    targets.add(
      TargetFocus(
      identify: "keyButton3",
      keyTarget: keyButton3,
      alignSkip: Alignment.topRight,
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) {
            return  const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  "نمودار هریبه های سالانه",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    ),);
    targets.add(
      TargetFocus(
      identify: "keyButton4",
      keyTarget: keyButton4,
      alignSkip: Alignment.topRight,
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) {
            return const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  "تنظیمات",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    ),);

    targets.add(
      TargetFocus(
        identify: "keyBottomNavigation1",
        keyTarget: keyBottomNavigation1,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "وارد کردن درآمد",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      ".با کلیک بر روی این آیکون می نوانید میزان درآمد خود را وارد کتید",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "keyBottomNavigation2",
        keyTarget: keyBottomNavigation2,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 30,
                  ),
                  const Text(
                    "رفتن به روز قبل",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "keyBottomNavigation3",
        keyTarget: keyBottomNavigation3,
        alignSkip: Alignment.bottomRight,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 30,
                  ),
                  const Text(
                    "انتخاب روز مورد نظر",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "keyBottomNavigation4",
        keyTarget: keyBottomNavigation4,
        alignSkip: Alignment.bottomRight,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 30,
                  ),
                  const Text(
                    "رفتن به روز بعد",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
    return targets;
  }

  void onTapNav(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    final List<Widget> pages = _pages();

    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {

      var darkThemeBoolean = state.darkThemeBoolean;

      return Scaffold(
      extendBody: true,
      body: Drawer(
       width: double.infinity,
          child: pages[_bottomNavIndex]),
      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.width / 6,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: darkThemeBoolean == "false"
              ? Colors.white
              : AppColors.darkThemeColor,
          selectedItemColor: AppColors.mainColor,
          unselectedItemColor: darkThemeBoolean == "false"
              ? Colors.grey
              : Colors.white,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          items:[
            BottomNavigationBarItem(
              label: '',
              icon: Icon(
                key: keyButton,
                Icons.home,
                size: MediaQuery.of(context).size.width / 15),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Icon(
                key: keyButton1,
                Icons.pie_chart,
                size: MediaQuery.of(context).size.width / 15),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Icon(
                key: keyButton3,
                Icons.bar_chart,
                size: MediaQuery.of(context).size.width / 15),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Icon(
                key: keyButton4,
                Icons.settings,
                size: MediaQuery.of(context).size.width / 15),
            ),
          ],
          currentIndex: _bottomNavIndex,
          onTap: onTapNav,
        ),
      ),
      floatingActionButton: SizedBox(
        height: MediaQuery.of(context).size.width / 9,
        width: MediaQuery.of(context).size.width / 9,
        child: FloatingActionButton(
          backgroundColor: AppColors.mainColor,
          child: Icon(
              key: keyButton2,
              Icons.add,
          size: MediaQuery.of(context).size.width / 15),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>
                  AddExpensePage()),
            );
          },
        ),
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.miniCenterDocked,
    );
    });}
}