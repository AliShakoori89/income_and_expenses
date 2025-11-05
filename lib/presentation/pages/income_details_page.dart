import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:income_and_expenses/logic/bloc/set_date_bloc/bloc.dart';
import 'package:income_and_expenses/logic/bloc/set_date_bloc/event.dart';
import 'package:income_and_expenses/logic/bloc/set_date_bloc/state.dart';
import 'package:income_and_expenses/logic/bloc/them_bloc/bloc.dart';
import 'package:income_and_expenses/logic/bloc/them_bloc/state.dart';
import 'package:income_and_expenses/presentation/pages/add_income_page.dart';
import 'package:income_and_expenses/presentation/utils/no_data.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import '../../l10n/app_localizations.dart';
import '../const/app_colors.dart';
import '../utils/arrow_back_icon.dart';

class IncomeDetailsPage extends StatelessWidget {

  final String month;
  const IncomeDetailsPage({Key? key, required this.month}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    BlocProvider.of<SetDateBloc>(context).add(InitialDateEvent());
    BlocProvider.of<SetDateBloc>(context).add(
        FetchAllIncomeItemsEvent(month: month));

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {

      var darkThemeBoolean = state.darkThemeBoolean;

      return BlocBuilder<SetDateBloc, SetDateState>(builder: (context, state){

        var incomeList = state.incomeDetails;

        return Scaffold(
          backgroundColor: darkThemeBoolean == "false"
              ? Colors.white
              : AppColors.darkThemeColor,
          floatingActionButton: Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              backgroundColor: AppColors.mainColor,
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddIncomePage()),
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
                fontSize: width / 25,
                fontWeight: FontWeight.w400),
            title: Align(
                alignment: Alignment.centerRight,
                child: Text(AppLocalizations.of(context)!.incomeDetail)),
            leading: ArrowBackIcon(themeBoolean: darkThemeBoolean),
          ),
          body: Container(
              decoration: BoxDecoration(
                  color: AppColors.themContainer,
                  borderRadius: BorderRadius.circular(25)
              ),
              margin: EdgeInsets.only(
                left: width / 30,
                right: width / 30,
                top: height / 60,
                bottom: height / 30,
              ),
              child: incomeList.isNotEmpty
                  ? ListView.builder(
                itemCount: incomeList.length,
                itemBuilder: (BuildContext context, int index){
                  return Container(
                    margin: EdgeInsets.only(
                      top: height / 100,
                      left: height / 100,
                      right: height / 100,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Container(
                      height: height / 12,
                      margin: EdgeInsets.only(
                        left: width / 40,
                        right: width / 40,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(child: Text("${incomeList[index].income}".toPersianDigit().seRagham(), style: TextStyle(
                              fontSize: width / 20
                          ),)),
                          const Spacer(),
                          Padding(
                            padding: EdgeInsets.only(top: height / 100),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Flexible(
                                  child: Text(
                                    "${incomeList[index].incomeCategory}",
                                    style: TextStyle(
                                        fontSize: width / 25),
                                  ),
                                ),
                                Flexible(child: Text("${incomeList[index].incomeDescription}",
                                  overflow: TextOverflow.clip,
                                  maxLines: 1,
                                  softWrap: true,
                                  style: TextStyle(
                                      fontSize: width / 30
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
                                  size: width / 20,
                                  color: Colors.black.withOpacity(0.4),
                                ),
                              ),
                              Container(
                                width: width / 8,
                                height: width / 8,
                                margin: EdgeInsets.all(width / 30),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.colorList[index]),
                                child: Container(
                                  margin: EdgeInsets.all(width / 60),
                                  child: SvgPicture.asset("${incomeList[index].incomeIconType}"),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },)
                  : const Center(child: NoDataPage())),
        );
      });
    });
  }
}
