import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:income_and_expenses/presentation/const/app_colors.dart';
import 'package:income_and_expenses/presentation/const/expenses_icons.dart';

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
          child: Text(AppLocalizations.of(context)!.grouping,
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

                return GestureDetector(
                  onTap: () {
                    controller.text = ExpensesIcon.iconsPersianName[index];
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
                            ? AppLocalizations.of(context)!.transportation
                            : groupName == 'خوراکی'
                            ? AppLocalizations.of(context)!.comestible
                            : groupName == 'خرید اقلام'
                            ? AppLocalizations.of(context)!.buyItems
                            : groupName == 'اقساط و بدهی'
                            ? AppLocalizations.of(context)!.installmentsAndDebt
                            : groupName == 'درمانی'
                            ? AppLocalizations.of(context)!.treatment
                            : groupName == 'هدایا'
                            ? AppLocalizations.of(context)!.gifts
                            : groupName == 'تعمیرات'
                            ? AppLocalizations.of(context)!.renovation
                            : groupName == 'تفریح'
                            ? AppLocalizations.of(context)!.pastime
                            : AppLocalizations.of(context)!.other,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width / 25
                            )),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
