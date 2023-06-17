import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:income_and_expenses/bloc/set_date_bloc/bloc.dart';
import 'package:income_and_expenses/bloc/set_date_bloc/state.dart';
import 'package:income_and_expenses/utils/no_data.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import '../bloc/change_language_bloc/bloc.dart';
import '../bloc/change_language_bloc/state.dart';
import '../bloc/set_date_bloc/event.dart';
import '../bloc/them_bloc/bloc.dart';
import '../bloc/them_bloc/state.dart';
import '../const/app_colors.dart';
import '../const/language.dart';
import '../utils/arrow_back_icon.dart';
import 'add_income_page.dart';

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
            floatingActionButton: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                backgroundColor: AppColors.mainColor,
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddIncomePage()),
                  );
                },
                child: Icon(Icons.add),
              ),
            ),
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
                child: incomeList.isNotEmpty
                    ? ListView.builder(
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
                        child: englishLanguageBoolean == false
                            ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(child: Text("${incomeList[index].income}".toPersianDigit().seRagham(), style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width / 20
                            ),)),
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
                                  Flexible(child: Text("${incomeList[index].incomeDescription}",
                                    overflow: TextOverflow.clip,
                                    maxLines: 1,
                                    softWrap: true,
                                    style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.width / 30
                                    ),
                                  )
                                  ),
                                ],
                              ),
                            ),
                            Stack(
                              alignment: Alignment.topRight,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    final incomeBloc = BlocProvider.of<SetDateBloc>(context);
                                    incomeBloc.add(DeleteIncomeEvent(incomeList[index].id!, incomeList[index].incomeDate!, incomeList[index].incomeMonth!));
                                    Navigator.pop(context);
                                  },
                                  child: Icon(
                                    Icons.close,
                                    size: MediaQuery.of(context).size.width / 20,
                                    color: Colors.black.withOpacity(0.4),
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
                          ],
                        )
                            : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Stack(
                              alignment: Alignment.topLeft,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    final incomeBloc = BlocProvider.of<SetDateBloc>(context);
                                    incomeBloc.add(DeleteIncomeEvent(incomeList[index].id!, incomeList[index].incomeDate!, incomeList[index].incomeMonth!));
                                    Navigator.pop(context);
                                  },
                                  child: Icon(
                                    Icons.close,
                                    size: MediaQuery.of(context).size.width / 20,
                                    color: Colors.black.withOpacity(0.4),
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
                            Padding(
                              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 100),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Text(
                                      incomeList[index].incomeCategory == "حقوق"
                                          ? "Stipend"
                                          : incomeList[index].incomeCategory == "جایزه"
                                          ? "Reward"
                                          : incomeList[index].incomeCategory == "هدایا"
                                          ? "gift"
                                          : incomeList[index].incomeCategory == "یارانه"
                                          ? "Subsidy"
                                          : incomeList[index].incomeCategory == "فروش"
                                          ? "Sale"
                                          : "Other",
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context).size.width / 25),
                                    ),
                                  ),
                                  Flexible(child: SizedBox(
                                      width: MediaQuery.of(context).size.width / 5,
                                      child: Text("${incomeList[index].incomeDescription}",
                                        overflow: TextOverflow.clip,
                                        maxLines: 1,
                                        softWrap: true,
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context).size.width / 30
                                        ),)
                                  )),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Expanded(child: Text("${incomeList[index].income}".seRagham(),
                                style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width / 27,
                                  fontWeight: FontWeight.w900
                            ))),
                          ],
                        ),
                      ),
                    );
                  },)
                    : const Center(child: NoDataPage())),
          );
        });
      });
    });
  }
}
