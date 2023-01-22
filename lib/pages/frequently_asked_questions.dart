import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expenses/const/dimensions.dart';

import '../bloc/them_bloc/bloc.dart';
import '../bloc/them_bloc/event.dart';
import '../bloc/them_bloc/state.dart';
import '../const/app_colors.dart';

class FrequentlyAskedQuestions extends StatelessWidget {
  const FrequentlyAskedQuestions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    BlocProvider.of<ThemeBloc>(context)
        .add(ReadThemeBooleanEvent());

    var allQuestion = [
      "نحوه استفاده از برنامه به چه گونه می باشد؟",
      "چگونه می توانم از برنامه خروجی بگیرم؟",
      "آیا هزینه ها به تفکیک ماه محاسبه میگردد؟",
      "آیا امکان اضافه کردن مبلغ به هزینه ورودی در هر کدام از روزهای ماه امکان پذبر است؟"
    ];

    var allAnswer = [
      "شما ابتدا قبل از هر چیز باید میزان ورودی که کل موجودی شما می_باشد را وارد نمایید سپس با استفاده از علامت + می توانید هزینه انجام شده را اضافه نمایید",
      "ابتدا به قسمت تنظیمات رفته سپس از گزینه مربوط به خروجی استفاده نمایید",
      "بله و گزارشات مربوط به هر ماه در صفحه گزارشات قابل بررسی می باشد",
      "بله شما می توانید با کلیک بر روی گزینه ورودی ، مبلغ مورد نظر را پس از محاسبه وارد نمایید"
    ];

    buildQuestion(double height, String question, String darkThemeBoolean) {
      return SizedBox(
          height: height,
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(question,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                  color: darkThemeBoolean == "false"
                      ? Colors.black
                      : Colors.white
                ),
                textDirection: TextDirection.rtl),
          ));
    }

    buildCollapsed1(String question, String answer, String darkThemeBoolean) {
      return Align(
        alignment: Alignment.centerRight,
        child: Column(
          children: [
            buildQuestion( Dimensions.height45, question, darkThemeBoolean),
            Text(answer,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: darkThemeBoolean == "false"
                        ? Colors.black
                        : Colors.white),
                textDirection: TextDirection.rtl,
            )
          ],
        ),
      );
    }

    buildExpanded1(String question, String darkThemeBoolean) {
      return buildQuestion(Dimensions.height45, question, darkThemeBoolean);
    }

    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
      return Scaffold(
      backgroundColor: state.darkThemeBoolean == "false"
          ? Colors.white
          : AppColors.darkThemeColor,
      body: SafeArea(
        child:  ListView.builder(
          itemCount: allQuestion.length,
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, index){
            return ExpandableNotifier(
                initialExpanded: true,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: ScrollOnExpand(
                    child: Card(
                      color: state.darkThemeBoolean == "false"
                          ? Colors.white
                          : AppColors.darkThemeColor,
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expandable(
                            collapsed: buildCollapsed1(allQuestion[index], allAnswer[index] , state.darkThemeBoolean),
                            expanded: buildExpanded1(allQuestion[index], state.darkThemeBoolean),
                          ),
                          // Divider(
                          //   height: 1,
                          //   color: state.darkThemeBoolean == "false"
                          //       ? Colors.grey
                          //       : Colors.white,
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Builder(
                                builder: (context) {
                                  var controller =
                                  ExpandableController.of(context, required: true)!;
                                  return IconButton(onPressed: () {
                                    controller.toggle();
                                  }, icon: Icon(Icons.arrow_drop_down_outlined,
                                  color: state.darkThemeBoolean == "false"
                                      ? Colors.black
                                      : Colors.white));
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ));
          },
        )
      ),
    );});
  }
}
