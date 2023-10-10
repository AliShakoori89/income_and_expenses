import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../bloc/them_bloc/bloc.dart';
import '../bloc/them_bloc/state.dart';
import '../const/app_colors.dart';

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
              // width: MediaQuery.of(context).size.width / 1.5,
          scale: MediaQuery.of(context).size.width / 3000),
          Text(
            AppLocalizations.of(context)!.notExpenses,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height / 40,
              color: darkThemeBoolean == "false"
                  ? AppColors.noDataTextColor
                  : Colors.white,
            ),
          )
        ],
      );
  });}
}
