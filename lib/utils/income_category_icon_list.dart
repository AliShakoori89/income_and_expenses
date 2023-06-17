import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:income_and_expenses/const/app_colors.dart';
import 'package:income_and_expenses/const/income_icons.dart';
import 'package:income_and_expenses/const/language.dart';
import '../bloc/change_language_bloc/bloc.dart';
import '../bloc/change_language_bloc/state.dart';

class IncomeCategoryIconList extends StatelessWidget {

  TextEditingController controller;

  IncomeCategoryIconList({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: MediaQuery.of(context).size.height / 2.5,
      child: Column(
        children: [
          const Icon(Icons.linear_scale,
            color: AppColors.appBarTitleColor,),
          Text(AppLocale.grouping.getString(context),
            style: const TextStyle(
                color: AppColors.appBarTitleColor,
                fontWeight: FontWeight.w500
            ),),
          Expanded(
            child: SizedBox(
              child: GridView.count(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width / 30),
                scrollDirection: Axis.vertical,
                crossAxisCount: 3,
                shrinkWrap: true,
                children:
                List.generate(IncomeIcons.iconsPersianName.length, (index) {
                  var groupName = IncomeIcons.iconsPersianName[index];

                  return BlocBuilder<ChangeLanguageBloc, ChangeLanguageState>(
                      builder: (context, state) {
                        bool englishLanguageBoolean = state.englishLanguageBoolean;

                        return GestureDetector(
                          onTap: () {
                            controller.text = englishLanguageBoolean == false
                                ? IncomeIcons.iconsPersianName[index]
                                : IncomeIcons.iconsEnglishName[index];
                            Navigator.pop(context);
                          },
                          child: Column(
                            children: [
                              Container(
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
                              Text(groupName == 'حقوق'
                                  ? AppLocale.stipend.getString(context)
                                  : groupName == 'هدیه'
                                  ? AppLocale.gifts.getString(context)
                                  : groupName == 'جایزه'
                                  ? AppLocale.reward.getString(context)
                                  : groupName == 'فروش'
                                  ? AppLocale.sale.getString(context)
                                  : groupName == 'یارانه'
                                  ? AppLocale.subsidy.getString(context)
                                  : AppLocale.other.getString(context),
                                overflow: TextOverflow.ellipsis,),
                            ],
                          ),
                        );
                      });
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
