
import 'package:cd_demo/const/color_conts.dart';
import 'package:cd_demo/const/route_const/app_routes.dart';
import 'package:cd_demo/utils/route_generator.dart';
import 'package:cd_demo/view/dashboard_screen.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      initialRoute: getInitialPage(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }

  String getInitialPage() {
    return AppRoutes.dashboard;
  }
}


