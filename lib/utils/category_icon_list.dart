import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:income_and_expenses/const/app_colors.dart';
import 'package:income_and_expenses/const/app_const.dart';
import 'package:income_and_expenses/const/dimensions.dart';
import 'package:income_and_expenses/const/language.dart';
import '../bloc/change_language_bloc/bloc.dart';
import '../bloc/change_language_bloc/state.dart';

class CategoryIconList extends StatelessWidget {

  TextEditingController controller;

  CategoryIconList({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // BlocProvider.of<ChangeLanguageBloc>(context).add(ReadLanguageBooleanEvent());

    return Column(
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
            // width: Dimensions.width45*5,
            // height: Dimensions.height45*5,
            child: GridView.count(
              padding: EdgeInsets.all(Dimensions.width30),
              scrollDirection: Axis.vertical,
              crossAxisCount: 3,
              shrinkWrap: true,
              children:
                  List.generate(AppConst.iconsPersianName.length, (index) {
                var groupName = AppConst.iconsPersianName[index];

                return BlocBuilder<ChangeLanguageBloc, ChangeLanguageState>(
                    builder: (context, state) {
                  bool englishLanguageBoolean = state.englishLanguageBoolean;

                  return GestureDetector(
                    onTap: () {
                      controller.text = englishLanguageBoolean == false
                          ? AppConst.iconsPersianName[index]
                          : AppConst.iconsEnglishName[index];
                      Get.back();
                    },
                    child: Column(
                      children: [
                        Container(
                          width: Dimensions.width45,
                          height: Dimensions.width45,
                          margin: EdgeInsets.all(Dimensions.width10),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.colorList[index]),
                          child: Container(
                            margin: EdgeInsets.all(Dimensions.width10 / 1.4),
                            child: SvgPicture.asset(
                                "assets/logos/${AppConst.iconsImage[index]}"),
                          ),
                        ),
                        Text(groupName == 'حمل و نقل'
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
                                                        : AppLocale.etcetera
                                                            .getString(
                                                                context)),
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
