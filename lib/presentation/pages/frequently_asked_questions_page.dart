import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expenses/logic/bloc/them_bloc/bloc.dart';
import 'package:income_and_expenses/logic/bloc/them_bloc/event.dart';
import 'package:income_and_expenses/logic/bloc/them_bloc/state.dart';
import '../const/app_colors.dart';

class FrequentlyAskedQuestions extends StatelessWidget {
  const FrequentlyAskedQuestions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ThemeBloc>(context).add(ReadThemeBooleanEvent());

    final allQuestion = [
      "نحوه استفاده از برنامه به چه گونه می باشد؟",
      "چگونه می توانم از برنامه خروجی بگیرم؟",
      "آیا هزینه ها به تفکیک ماه محاسبه میگردد؟",
      "آیا امکان اضافه کردن مبلغ به هزینه ورودی در هر کدام از روزهای ماه امکان‌پذیر است؟"
    ];

    final allAnswer = [
      "شما ابتدا باید میزان ورودی که کل موجودی شما می‌باشد را وارد نمایید سپس با استفاده از علامت + می‌توانید هزینه انجام‌شده را اضافه نمایید.",
      "ابتدا به قسمت تنظیمات بروید سپس از گزینه مربوط به خروجی استفاده نمایید.",
      "بله، گزارشات مربوط به هر ماه در صفحه گزارشات قابل بررسی است.",
      "بله، شما می‌توانید با کلیک بر روی گزینه ورودی، مبلغ مورد نظر را وارد نمایید."
    ];

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final darkTheme = state.darkThemeBoolean == "true";
        return Scaffold(
          backgroundColor:
          darkTheme ? AppColors.darkThemeColor : Colors.white,
          body: SafeArea(
            child: ListView.builder(
              itemCount: allQuestion.length,
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                return ExpandableNotifier(
                  child: Padding(
                    padding:
                    const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Card(
                      color: darkTheme
                          ? AppColors.darkThemeColor
                          : Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ScrollOnExpand(
                        child: ExpandablePanel(
                          theme: const ExpandableThemeData(
                            iconColor: Colors.blueGrey,
                            headerAlignment:
                            ExpandablePanelHeaderAlignment.center,
                            tapHeaderToExpand: true,
                            hasIcon: true,
                          ),
                          header: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              allQuestion[index],
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: darkTheme ? Colors.white : Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          collapsed: const SizedBox.shrink(),
                          expanded: Padding(
                            padding: const EdgeInsets.only(
                                right: 12, left: 12, bottom: 12),
                            child: Text(
                              allAnswer[index],
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                color: darkTheme ? Colors.white70 : Colors.black87,
                                fontSize: 15,
                                height: 1.6,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
