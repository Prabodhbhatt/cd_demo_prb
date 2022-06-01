import 'package:cd_demo/model/product.dart';

class SingletonDataManager {
  static final SingletonDataManager _instance =
      SingletonDataManager._internal();

  factory SingletonDataManager() {
    return _instance;
  }

  SingletonDataManager._internal();

  static Function? fnUpdateProduct;
  static Function? fnAddProduct;
  static int selectedProductIndex = 0;
  static List<Product> productList = [
    Product(
        name: "product1",
        launchedAt: "01-01-2022",
        launchSite: "Ahmedabad",
        popularity: "4"),
    Product(
        name: "cproduct2",
        launchedAt: "05-01-2022",
        launchSite: "Ahmedabad",
        popularity: "3"),
    Product(
        name: "aproduct3",
        launchedAt: "07-01-2022",
        launchSite: "Ahmedabad",
        popularity: "2"),
    Product(
        name: "zproduct4",
        launchedAt: "02-01-2022",
        launchSite: "Ahmedabad",
        popularity: "5"),
    Product(
        name: "bproduct5",
        launchedAt: "03-01-2022",
        launchSite: "Ahmedabad",
        popularity: "1"),
  ];
}
