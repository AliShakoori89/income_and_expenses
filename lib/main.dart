import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:income_and_expenses/bloc/expense_bloc/bloc.dart';
import 'package:income_and_expenses/bloc/set_date/bloc.dart';
import 'package:income_and_expenses/repository/date_time_repository.dart';
import 'package:income_and_expenses/repository/expense_repository.dart';
import 'package:income_and_expenses/routes/route_helper.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) =>
                ExpenseBloc(ExpenseRepository())),
        BlocProvider(
            create: (BuildContext context) =>
                SetDateBloc(SetDateRepository())),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Income and Expenses',
        initialRoute: RouteHelper.getInitial(),
        getPages: RouteHelper.routes,
      ),
    );
  }
}
