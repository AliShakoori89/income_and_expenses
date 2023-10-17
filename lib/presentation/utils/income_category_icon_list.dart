import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:income_and_expenses/presentation/const/app_colors.dart';
import 'package:income_and_expenses/presentation/const/income_icons.dart';

class IncomeCategoryIconList extends StatelessWidget {

  TextEditingController controller;

  IncomeCategoryIconList({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: MediaQuery.of(context).size.height / 2.5,
      child: Column(
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
                  fontSize: MediaQuery.of(context).size.width / 25,
                  fontWeight: FontWeight.w500
              ),),
          ),
          Expanded(
            flex: 8,
            child: SizedBox(
              child: GridView.count(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width / 30),
                scrollDirection: Axis.vertical,
                crossAxisCount: 3,
                shrinkWrap: true,
                children:
                List.generate(IncomeIcons.iconsPersianName.length, (index) {
                  var groupName = IncomeIcons.iconsPersianName[index];

                  return GestureDetector(
                    onTap: () {
                      controller.text = IncomeIcons.iconsPersianName[index];
                      Navigator.pop(context);
                    },
                    child: Column(
                      children: [
                        Expanded(
                          flex: 10,
                          child: Container(
                            width: MediaQuery.of(context).size.width / 8,
                            height: MediaQuery.of(context).size.width / 8,
                            margin: EdgeInsets.all(MediaQuery.of(context).size.width / 30),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.colorList[index]),
                            child: Container(
                              margin: EdgeInsets.all(MediaQuery.of(context).size.width / 60),
                              child: SvgPicture.asset(
                                  "assets/icons/income_category_icons/${IncomeIcons.iconsImage[index]}"),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Text(groupName == 'حقوق'
                              ? AppLocalizations.of(context)!.stipend
                              : groupName == 'هدیه'
                              ? AppLocalizations.of(context)!.gifts
                              : groupName == 'جایزه'
                              ? AppLocalizations.of(context)!.reward
                              : groupName == 'فروش'
                              ? AppLocalizations.of(context)!.sale
                              : groupName == 'یارانه'
                              ? AppLocalizations.of(context)!.subsidy
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
      ),
    );
  }
}
