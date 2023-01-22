import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:income_and_expenses/bloc/change_language_bloc/bloc.dart';
import 'package:income_and_expenses/bloc/change_language_bloc/event.dart';
import 'package:income_and_expenses/bloc/change_language_bloc/state.dart';
import 'package:income_and_expenses/const/app_colors.dart';
import 'package:income_and_expenses/const/dimensions.dart';

import '../bloc/them_bloc/bloc.dart';
import '../bloc/them_bloc/event.dart';
import '../bloc/them_bloc/state.dart';

class SettingItems extends StatelessWidget {

  final String imagePath;
  final String itemName;
  const SettingItems({Key? key,
    required this.imagePath,
  required this.itemName}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    BlocProvider.of<ThemeBloc>(context).add(ReadThemeBooleanEvent());
    BlocProvider.of<ChangeLanguageBloc>(context).add(ReadLanguageBooleanEvent());

    return BlocBuilder<ChangeLanguageBloc, ChangeLanguageState>(builder: (context, state){

      bool lBool = state.readLanguageBoolean;

      return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {

        var darkThemeBoolean = state.themeBoolean;

        return lBool == true
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                      width: Dimensions.width20, child: Image.asset(imagePath)),
                  SizedBox(
                    width: Dimensions.width10,
                  ),
                  Container(
                    width: Dimensions.screenWidth / 1.35,
                    margin: EdgeInsets.only(
                      right: Dimensions.width20,
                      left: Dimensions.width10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          itemName.getString(context),
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: Dimensions.font16,
                            color: darkThemeBoolean == "false"
                                ? AppColors.appBarProfileName
                                : Colors.white,
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios,
                            color: darkThemeBoolean == "false"
                                ? AppColors.darkArrowButtonColor
                                : Colors.white,
                            size: Dimensions.iconSize16),
                      ],
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: Dimensions.screenWidth / 1.35,
                    margin: EdgeInsets.only(
                      right: Dimensions.width20,
                      left: Dimensions.width10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.arrow_back_ios,
                            color: darkThemeBoolean == "false"
                                ? AppColors.darkArrowButtonColor
                                : Colors.white,
                            size: Dimensions.iconSize16),
                        Text(
                          itemName.getString(context),
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: Dimensions.font16,
                            color: darkThemeBoolean == "false"
                                ? AppColors.appBarProfileName
                                : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: Dimensions.width10,
                  ),
                  SizedBox(
                      width: Dimensions.width20, child: Image.asset(imagePath)),
                ],
              );

      });
    });
  }
}
