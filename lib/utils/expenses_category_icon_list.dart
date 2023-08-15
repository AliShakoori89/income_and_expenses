import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:income_and_expenses/const/app_colors.dart';
import 'package:income_and_expenses/const/expenses_icons.dart';
import 'package:income_and_expenses/const/language.dart';
import '../bloc/change_language_bloc/bloc.dart';
import '../bloc/change_language_bloc/state.dart';

class ExpensesCategoryIconList extends StatelessWidget {

  TextEditingController controller;

  ExpensesCategoryIconList({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Icon(Icons.linear_scale,
          size: MediaQuery.of(context).size.width / 25,
          color: AppColors.appBarTitleColor,),
        ),
        Expanded(
          flex: 1,
          child: Text(AppLocale.grouping.getString(context),
            style: TextStyle(
                color: AppColors.appBarTitleColor,
                fontWeight: FontWeight.w500,
                fontSize: MediaQuery.of(context).size.width / 25
            ),),
        ),
        Expanded(
          flex: 8,
          child: SizedBox(
            child: GridView.count(
              // padding: EdgeInsets.all(MediaQuery.of(context).size.width / 30),
              scrollDirection: Axis.vertical,
              crossAxisCount: 3,
              shrinkWrap: true,
              children: List.generate(ExpensesIcon.iconsPersianName.length, (index) {
                var groupName = ExpensesIcon.iconsPersianName[index];

                return BlocBuilder<ChangeLanguageBloc, ChangeLanguageState>(
                    builder: (context, state) {
                  bool englishLanguageBoolean = state.englishLanguageBoolean;

                  return GestureDetector(
                    onTap: () {
                      controller.text = englishLanguageBoolean == false
                          ? ExpensesIcon.iconsPersianName[index]
                          : ExpensesIcon.iconsEnglishName[index];
                      Navigator.pop(context);
                    },
                    child: Column(
                      children: [
                        Expanded(
                          flex: 10,
                          child: Container(
                            // width: MediaQuery.of(context).size.width / 8,
                            // height: MediaQuery.of(context).size.width / 8,
                            margin: EdgeInsets.all(MediaQuery.of(context).size.width / 30),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.colorList[index]),
                            child: Container(
                              margin: EdgeInsets.all(MediaQuery.of(context).size.width / 60),
                              child: SvgPicture.asset(
                                  "assets/icons/expense_category_icons/${ExpensesIcon.iconsImage[index]}"),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Text(groupName == 'حمل و نقل'
                              ? AppLocale.transportation.getString(context)
                              : groupName == 'خوراکی'
                                  ? AppLocale.comestible.getString(context)
                                  : groupName == 'خرید اقلام'
                                      ? AppLocale.buyItems.getString(context)
                                      : groupName == 'اقساط و بدهی'
                                          ? AppLocale.installmentsAndDebt
                                              .getString(context)
                                          : groupName == 'درمانی'
                                              ? AppLocale.treatment
                                                  .getString(context)
                                              : groupName == 'هدایا'
                                                  ? AppLocale.gifts
                                                      .getString(context)
                                                  : groupName == 'تعمیرات'
                                                      ? AppLocale.renovation
                                                          .getString(context)
                                                      : groupName == 'تفریح'
                                                          ? AppLocale.pastime
                                                              .getString(context)
                                                          : AppLocale.other
                                                              .getString(
                                                                  context),
                            overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width / 25
                          )),
                        ),
                      ],
                    ),
                  );
                });
              }),
            ),
          ),
        ),
      ],
    );
  }
}
