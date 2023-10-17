import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expenses/logic/bloc/them_bloc/bloc.dart';
import 'package:income_and_expenses/logic/bloc/them_bloc/state.dart';
import 'package:income_and_expenses/presentation/const/app_colors.dart';

class SettingItems extends StatelessWidget {

  final String imagePath;
  final String itemName;
  const SettingItems({Key? key,
    required this.imagePath,
  required this.itemName}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {

      var darkThemeBoolean = state.darkThemeBoolean;

      return Container(
        width: double.infinity / 1.35,
        height: MediaQuery.of(context).size.height / 10,
        margin: EdgeInsets.only(
          right: MediaQuery.of(context).size.width / 20,
          left: MediaQuery.of(context).size.width / 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width / 10,
                      child: Image.asset(imagePath)),
                  SizedBox(width: MediaQuery.of(context).size.width / 20,),
                  Flexible(
                    child: Text(
                      itemName,
                      textDirection: TextDirection.ltr,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: MediaQuery.of(context).size.width / 30,
                        color: darkThemeBoolean == "false"
                            ? AppColors.appBarProfileName
                            : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 5,
                    color: darkThemeBoolean == "false" ? Colors.black26 : Colors.white12,
                    blurRadius: 10.0,
                  )
                ],
                shape: BoxShape.circle,
                color: darkThemeBoolean == "false"
                    ? Colors.white
                    : AppColors.darkThemeColor,
              ),
              child: Container(
                margin: EdgeInsets.all(MediaQuery.of(context).size.width / 100),
                child: Icon(Icons.arrow_forward_ios,
                    color: darkThemeBoolean == "false"
                        ? AppColors.black
                        : Colors.white,
                    size:  MediaQuery.of(context).size.width / 30),
              ),
            )
          ],
        ),
      );

    });
  }
}
