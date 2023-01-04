import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expenses/bloc/cash_bloc/bloc.dart';
import 'package:income_and_expenses/bloc/cash_bloc/state.dart';
import 'package:income_and_expenses/bloc/expense_bloc/bloc.dart';
import 'package:income_and_expenses/bloc/expense_bloc/state.dart';
import 'package:income_and_expenses/utils/app_colors.dart';
import 'package:income_and_expenses/utils/dimensions.dart';
import 'package:income_and_expenses/utils/widget.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../bloc/cash_bloc/event.dart';

class CashContainer extends StatefulWidget {
  CashContainer({Key? key}) : super(key: key);

  @override
  State<CashContainer> createState() => _CashContainerState();
}

class _CashContainerState extends State<CashContainer> {

  @override
  void initState() {

    final cashBloc = BlocProvider.of<CashBloc>(context);
    cashBloc.add(FetchCashEvent());

    super.initState();
  }

  late TextEditingController cashController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: AppColors.mainPageCardBorderColor),
          borderRadius:
          BorderRadius.circular(Dimensions.radius8)),
      child: Container(
        margin: EdgeInsets.only(
            left: Dimensions.width30,
            right: Dimensions.width30,
            top: Dimensions.height10,
            bottom: Dimensions.height10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                    "assets/main_page_first_container_logo/expenses.png"),
                SizedBox(height: Dimensions.height10,),
                Text("-12،000".toPersianDigit(),
                    style: TextStyle(
                        color: AppColors.expensesDigitColor,
                        fontSize: Dimensions.font18)),
                Text("هزینه شده",
                    style: TextStyle(
                        color: AppColors
                            .mainPageFirstContainerFontColor,
                        fontSize: Dimensions.font16,
                        fontWeight: FontWeight.w400)),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                    "assets/main_page_first_container_logo/balance.png"),
                SizedBox(height: Dimensions.height10,),
                Text("48,000".toPersianDigit(),
                    style: TextStyle(
                        color: AppColors.balanceDigitColor,
                        fontSize: Dimensions.font18)),
                Text("موجودی",
                    style: TextStyle(
                        color: AppColors
                            .mainPageFirstContainerFontColor,
                        fontSize: Dimensions.font16,
                        fontWeight: FontWeight.w400)),
              ],
            ),
            GestureDetector(
              onTap: (){
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text("موجودی کل",
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontSize: Dimensions.font16
                    ),),
                    content: Text("لطفا میزان موجودی خود را وارد نمایید:",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            fontSize: Dimensions.font14
                        )),
                    actions: <Widget>[
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: SizedBox(
                          height: Dimensions.height45,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: cashController,
                            decoration: textInputDecoration.copyWith(
                                border: InputBorder.none,
                              suffixText: "تومان"
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          print(cashController.text);
                          BlocProvider.of<CashBloc>(context)
                              .add(AddCashEvent(cash: cashController.text,));
                          BlocProvider.of<CashBloc>(context)
                              .add(FetchCashEvent());
                          Navigator.of(ctx).pop();
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: Dimensions.width10),
                          child: const Align(
                              alignment: Alignment.centerLeft,
                              child: Text("ثبت")),
                        ),
                      ),
                    ],
                  ),
                );
              },
                child: BlocBuilder<CashBloc, CashState>(
                    builder: (context, state) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                              "assets/main_page_first_container_logo/income.png"),
                          SizedBox(height: Dimensions.height10,),
                          Text(state.cash == '' ? "0".toPersianDigit() : state.cash.toPersianDigit().seRagham(),
                              style: TextStyle(
                                  color: AppColors.appBarProfileName,
                                  fontSize: Dimensions.font18)),
                          Text("ورودی",
                              style: TextStyle(
                                  color: AppColors
                                      .mainPageFirstContainerFontColor,
                                  fontSize: Dimensions.font16,
                                  fontWeight: FontWeight.w400)),
                        ],
                      );
                    })

            ),
          ],
        ),
      ),
    );
  }
}
