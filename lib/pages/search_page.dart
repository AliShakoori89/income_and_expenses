import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:income_and_expenses/const/app_colors.dart';
import 'package:income_and_expenses/const/expenses_icons.dart';
import 'package:income_and_expenses/utils/search_text_field.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    late TextEditingController searchController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width / 15,
            right: MediaQuery.of(context).size.width / 15,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // ArrowBackIcon(),
                  SearchTextField(searchController: searchController)
                ],
              ),
              const Divider(
                color: AppColors.labelColor,
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 30,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(ExpensesIcon.iconsPersianName.length, (index){
                    return Container(
                      margin: EdgeInsets.all(MediaQuery.of(context).size.width / 15,),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.iconUnSelectedBackGroundMainColor)
                      ),
                      child: Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 15,
                              right: MediaQuery.of(context).size.width / 15,),
                          child: Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 15/1.5,
                                height: MediaQuery.of(context).size.width / 15/1.5,
                                child: SvgPicture.asset(
                                    "assets/logos/${ExpensesIcon.iconsImage[index]}",
                                color: AppColors.labelColor,),
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width / 15 / 2,),
                              Text("${ExpensesIcon.iconsPersianName[index]}"),
                            ],
                          )),
                    );
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

