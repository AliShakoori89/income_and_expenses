import 'package:flutter/material.dart';
import 'package:income_and_expenses/const/dimensions.dart';
import 'package:income_and_expenses/utils/widget.dart';

class SearchTextField extends StatelessWidget {

  TextEditingController searchController = TextEditingController();

  SearchTextField({Key? key, required this.searchController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Dimensions.width45*7,
      child: TextField(
        controller: searchController,
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl,
        decoration: textInputDecoration.copyWith(
          hintText: "جست و جو",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
        ),
      ),
    );
  }
}
