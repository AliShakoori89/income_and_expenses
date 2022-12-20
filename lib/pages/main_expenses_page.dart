import 'package:flutter/material.dart';
import 'package:income_and_expenses/utils/app_colors.dart';
import 'package:income_and_expenses/utils/dimensions.dart';
import 'package:income_and_expenses/widgets/date_picker_calendar.dart';
import 'package:income_and_expenses/widgets/main_expenses_page_header.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

// class MainExpensesPage extends StatefulWidget {
//   const MainExpensesPage({super.key});
//
//   @override
//   State<MainExpensesPage> createState() => _MainExpensesPageState();
// }
//
// class _MainExpensesPageState extends State<MainExpensesPage> {
//
//   // List all_expenses = [,,,,,,,"","رفت و آمد","سرویس",
//   // "تعمیرات",
//   // "سفر",
//   // "تفریح",
//   // "خوراک",
//   // "پوشاک",
//   // "درمانی"];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backGroundColor,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               SizedBox(height: Dimensions.height10),
//               Container(
//                 margin: EdgeInsets.only(
//                     right: Dimensions.width20,
//                     left: Dimensions.width20
//                 ),
//                 height: Dimensions.screenHeight / 3,
//                 decoration: const BoxDecoration(
//                     color: Colors.white,
//                     image: DecorationImage(
//                         image: AssetImage(
//                             "assets/images/mainPic.png"
//                         ))
//                 ),
//                 // child: ListView.builder(
//                 //   itemCount: ,
//                 //   itemBuilder: ,
//                 // ),
//               ),
//               Stack(
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(
//                         top: Dimensions.width30,
//                         right: Dimensions.width10,
//                         left: Dimensions.width10
//                     ),
//                     height: Dimensions.screenHeight / 1.7,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.all(
//                             Radius.circular(Dimensions.radius1)),
//                         color: AppColors.backGroundMainColor
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment.bottomCenter,
//                     child: Container(
//                       margin: EdgeInsets.only(
//                           right: Dimensions.width20*3,
//                           left: Dimensions.width20*3
//                       ),
//                       height: Dimensions.screenHeight / 9,
//                       decoration: BoxDecoration(
//                           boxShadow: const[
//                             BoxShadow(
//                                 color: AppColors.mainColor,
//                                 blurRadius: 5.0,
//                                 offset: Offset(0,5)
//                             ),
//                             BoxShadow(
//                                 color: AppColors.mainColor,
//                                 offset: Offset(-5,0)
//                             ),
//                             BoxShadow(
//                                 color: AppColors.mainColor,
//                                 offset: Offset(5,0)
//                             )
//                           ],
//                           color: AppColors.mainColor,
//                           borderRadius: BorderRadius.all(
//                               Radius.circular(Dimensions.radius5))
//                       ),
//                       child: Container(
//                         margin: EdgeInsets.only(
//                           right: Dimensions.width10,
//                           left: Dimensions.width10,
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Expanded(
//                               child: Row(
//                                 children: [
//                                   Text("تومان", style: TextStyle(color: AppColors.backGroundColor,
//                                       fontSize: Dimensions.font16)),
//                                   SizedBox(width: Dimensions.width10/2),
//                                   Text("20000000".toPersianDigit().seRagham(),
//                                     style: TextStyle(color: AppColors.backGroundColor,
//                                         fontSize: Dimensions.font20),),
//                                 ],
//                               ),
//                             ),
//                             Text("مقدار کل حساب : ",
//                               textDirection: TextDirection.rtl,
//                               style: TextStyle(
//                                   color: AppColors.backGroundColor,
//                                   fontWeight: FontWeight.bold),)
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


class MainExpensesPage extends StatefulWidget {
  const MainExpensesPage({Key? key}) : super(key: key);

  @override
  State<MainExpensesPage> createState() => _MainExpensesPageState();
}

class _MainExpensesPageState extends State<MainExpensesPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(
            left: Dimensions.width20,
            right: Dimensions.width20,
          ),
          child: Column(
            children: [
              SizedBox(height: Dimensions.height10,),
              const MainExpensesPageHeader(),
              SizedBox(height: Dimensions.height20,),
              DatePickerCalendar(),
              SizedBox(height: Dimensions.height45*6,),
              Text("! اطلاعاتی برای نمایش وجود ندارد",
              style: TextStyle(
                fontSize: Dimensions.font20,
                color: Color.fromRGBO(117,117,117,1.00),),)
            ],
          ),
        ),
      ),
    );
  }
}
