import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import '../bloc/them_bloc/bloc.dart';
import '../bloc/them_bloc/state.dart';
import '../const/app_colors.dart';
import '../const/language.dart';

class NoDataPage extends StatelessWidget {
  const NoDataPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {

      var darkThemeBoolean = state.darkThemeBoolean;

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/No data.png",
              width: MediaQuery.of(context).size.width / 1.5),
          Text(
            AppLocale.notExpenses.getString(context),
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height / 50,
              color: darkThemeBoolean == "false"
                  ? AppColors.noDataTextColor
                  : Colors.white,
            ),
          )
        ],
      );
  });}
}
