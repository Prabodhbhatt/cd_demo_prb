import 'package:cd_demo/const/route_const/app_routes.dart';
import 'package:cd_demo/model/product.dart';
import 'package:cd_demo/view/dashboard_screen.dart';
import 'package:cd_demo/view/add_product.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.dashboard:
        return buildRoute(const DashboardScreen(), settings: settings);
      case AppRoutes.product:
        if (settings.arguments != null) {
          final product = settings.arguments as Product;
          return buildRoute(AddProductScreen(productData: product),
              settings: settings);
        } else {
          return buildRoute(const AddProductScreen(), settings: settings);
        }

      default:
        return buildRoute(const DashboardScreen(), settings: settings);
    }
  }

  static MaterialPageRoute buildRoute(Widget child,
      {required RouteSettings settings}) {
    return MaterialPageRoute(
        settings: settings, builder: (BuildContext context) => child);
  }

}
