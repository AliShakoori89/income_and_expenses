import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:income_and_expenses/const/dimensions.dart';

class FrequentlyAskedQuestions extends StatelessWidget {
  const FrequentlyAskedQuestions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

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

    buildQuestion(double height, String question) {
      return SizedBox(
          height: height,
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(question,
                style: const TextStyle(
                    fontWeight: FontWeight.w600
                ),
                textDirection: TextDirection.rtl),
          ));
    }

    buildCollapsed1(String question, String answer) {
      return Align(
        alignment: Alignment.centerRight,
        child: Column(
          children: [
            buildQuestion( Dimensions.height45, question),
            Text(answer,
                style: const TextStyle(
                    fontWeight: FontWeight.w400),
                textDirection: TextDirection.rtl,
            )
          ],
        ),
      );
    }

    buildExpanded1(String question) {
      return buildQuestion(Dimensions.height45, question);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView.builder(
          itemCount: allQuestion.length,
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, index){
            return ExpandableNotifier(
                initialExpanded: true,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: ScrollOnExpand(
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expandable(
                            collapsed: buildCollapsed1(allQuestion[index], allAnswer[index]),
                            expanded: buildExpanded1(allQuestion[index]),
                          ),
                          const Divider(
                            height: 1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Builder(
                                builder: (context) {
                                  var controller =
                                  ExpandableController.of(context, required: true)!;
                                  return IconButton(onPressed: () {
                                    controller.toggle();
                                  }, icon: const Icon(Icons.arrow_drop_down_outlined));
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
        ),
      ),
    );
  }
}
