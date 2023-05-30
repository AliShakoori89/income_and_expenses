import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:income_and_expenses/bloc/set_date_bloc/bloc.dart';
import 'package:income_and_expenses/bloc/set_date_bloc/state.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../bloc/change_language_bloc/bloc.dart';
import '../bloc/change_language_bloc/state.dart';
import '../bloc/set_date_bloc/event.dart';
import '../bloc/them_bloc/bloc.dart';
import '../bloc/them_bloc/state.dart';
import '../const/app_colors.dart';
import '../const/language.dart';
import '../utils/arrow_back_icon.dart';

class IncomeDetailsPage extends StatefulWidget {

  final String month;
  const IncomeDetailsPage({Key? key, required this.month}) : super(key: key);

  @override
  State<IncomeDetailsPage> createState() => _IncomeDetailsPageState(month);
}

class _IncomeDetailsPageState extends State<IncomeDetailsPage> {

  final String month;

  _IncomeDetailsPageState(this.month);

  @override
  void initState() {
    BlocProvider.of<SetDateBloc>(context).add(InitialDateEvent());
    BlocProvider.of<SetDateBloc>(context).add(
        FetchAllIncomeItemsEvent(month: month));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeLanguageBloc, ChangeLanguageState>(
        builder: (context, state) {
      bool englishLanguageBoolean = state.englishLanguageBoolean;

      return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {

        var darkThemeBoolean = state.darkThemeBoolean;

        return BlocBuilder<SetDateBloc, SetDateState>(builder: (context, state){

          var incomeList = state.incomeDetails;

          return Scaffold(
            appBar: AppBar(
              backgroundColor: darkThemeBoolean == "false"
                  ? Colors.white
                  : AppColors.darkThemeColor,
              shadowColor: Colors.white,
              elevation: 1,
              titleTextStyle: TextStyle(
                  color: darkThemeBoolean == "false"
                      ? AppColors.appBarTitleColor
                      : Colors.white,
                  fontSize: MediaQuery.of(context).size.width / 25,
                  fontWeight: FontWeight.w400),
              title: Align(
                  alignment: Alignment.centerRight,
                  child: Text(AppLocale.incomeDetail.getString(context))),
              leading: ArrowBackIcon(themeBoolean: darkThemeBoolean),
            ),
            body: Container(
                decoration: BoxDecoration(
                    color: AppColors.themContainer,
                    borderRadius: BorderRadius.circular(25)
                ),
                margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 30,
                  right: MediaQuery.of(context).size.width / 30,
                  top: MediaQuery.of(context).size.height / 60,
                  bottom: MediaQuery.of(context).size.height / 30,
                ),
                child: ListView.builder(
                  itemCount: incomeList.length,
                  itemBuilder: (BuildContext context, int index){
                    return Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 100,
                        left: MediaQuery.of(context).size.height / 100,
                        right: MediaQuery.of(context).size.height / 100,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 12,
                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 40,
                          right: MediaQuery.of(context).size.width / 40,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(child: Text("${incomeList[index].income}".toPersianDigit().seRagham())),
                            const Spacer(),
                            Padding(
                              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 100),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Flexible(
                                    child: Text(
                                      "${incomeList[index].incomeCategory}",
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context).size.width / 25),
                                    ),
                                  ),
                                  Flexible(child: SizedBox(
                                      width: MediaQuery.of(context).size.width / 2.5,
                                      child: Text("${incomeList[index].incomeDescription}",
                                        overflow: TextOverflow.clip,
                                        maxLines: 1,
                                        softWrap: true,
                                      style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.width / 30
                                      ),))),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 8,
                              height: MediaQuery.of(context).size.width / 8,
                              margin: EdgeInsets.all(MediaQuery.of(context).size.width / 30),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.colorList[index]),
                              child: Container(
                                margin: EdgeInsets.all(MediaQuery.of(context).size.width / 60),
                                child: SvgPicture.asset("${incomeList[index].incomeIconType}"),
                              ),
                            ),

                          ],
                        ),
                      ),
                    );
                  },)),
          );
        });
      });
    });
  }
}
