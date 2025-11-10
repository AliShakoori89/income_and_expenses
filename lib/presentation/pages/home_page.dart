import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expenses/logic/bloc/them_bloc/bloc.dart';
import 'package:income_and_expenses/logic/bloc/them_bloc/event.dart';
import 'package:income_and_expenses/logic/bloc/them_bloc/state.dart';
import 'package:income_and_expenses/presentation/const/app_colors.dart';
import 'package:income_and_expenses/presentation/pages/add_expense_page.dart';
import 'package:income_and_expenses/presentation/pages/main_expenses_page.dart';
import 'package:income_and_expenses/presentation/pages/setting_page.dart';
import 'package:income_and_expenses/presentation/pages/sfcartesian_chart_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'sf_circular_chart_page.dart';

class MyHomePage extends StatefulWidget {

  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {

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
        SFCartesianChartPage(),
        const SettingPage(),
      ];

  final iconList = <IconData>[
    Icons.home,
    Icons.pie_chart,
    Icons.bar_chart,
    Icons.settings,
  ];

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
        return true; // 🔥 اضافه کن
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
      ),);
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
      ),);
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
      ),);
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
      ),);
    return targets;
  }


  @override
  Widget build(BuildContext context) {

    checkFirstSeen();

    final List<Widget> pages = _pages();

    void _incrementTab(index) {
      setState(() {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddExpensePage()),
        );
      });
    }

    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {

      var darkThemeBoolean = state.darkThemeBoolean;

      return Scaffold(
      extendBody: true,
      body: Center(
        // child: _widgetOptions.elementAt(_selectedIndex),
        child: pages[state.pageNumber],
      ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: darkThemeBoolean == "false"
                    ? AppColors.mainColor
                    : AppColors.darkThemeColor,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: NavigationBarTheme(
                  data: NavigationBarThemeData(
                    iconTheme: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.selected)) {
                        return const IconThemeData(color: Colors.purple);
                      }
                      return const IconThemeData(color: Colors.white);
                    }),
                  ),
                  child: NavigationBar(
                    backgroundColor: Colors.transparent,
                    indicatorColor: Colors.transparent,
                    height: 50,
                    labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
                    selectedIndex: state.pageNumber,
                    onDestinationSelected: (index) {
                      BlocProvider.of<ThemeBloc>(context)
                          .add(ChangeIndexEvent(index: index));
                    },
                    destinations: const [
                      Padding(
                        padding: EdgeInsets.only(top: 15.0),
                        child: NavigationDestination(icon: Icon(Icons.home, size: 26), label: ''),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15.0),
                        child: NavigationDestination(icon: Icon(Icons.pie_chart, size: 26), label: ''),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15.0),
                        child: NavigationDestination(icon: Icon(Icons.bar_chart, size: 26), label: ''),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15.0),
                        child: NavigationDestination(icon: Icon(Icons.settings, size: 26), label: ''),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          _incrementTab(1);
        },
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
    );
    });}
}