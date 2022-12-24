import 'package:flutter/material.dart';
import 'package:income_and_expenses/utils/profile_page_header.dart';
import 'package:income_and_expenses/utils/setting_item_list.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ProfilePageHeader(),
            SettingItemList()
          ],
        ),
      ),
    );
  }
}
