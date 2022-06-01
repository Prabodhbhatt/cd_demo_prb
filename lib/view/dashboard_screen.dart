import 'package:cd_demo/const/color_conts.dart';
import 'package:cd_demo/const/custom_fonts.dart';
import 'package:cd_demo/const/route_const/app_routes.dart';
import 'package:cd_demo/model/product.dart';
import 'package:cd_demo/model/singleton_data_manager.dart';
import 'package:cd_demo/utils/star_rating.dart';
import 'package:cd_demo/widgets/btn_bg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    // TODO: implement initState
    SingletonDataManager.fnUpdateProduct = editProduct;
    SingletonDataManager.fnAddProduct = addProduct;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
        title: const Text("Dashboard"),
        actions: [
          Padding(
            padding:
                const EdgeInsets.only(bottom: 5, left: 0, top: 5, right: 10),
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                showSortFilter(context);
              },
              child: const Icon(
                Icons.filter_alt,
                size: 20,
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(bottom: 5, left: 0, top: 5, right: 10),
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.product);
              },
              child: const Icon(
                Icons.add_box,
                size: 20,
              ),
            ),
          ),
        ],
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: (SingletonDataManager.productList.isNotEmpty)
                    ? ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: SingletonDataManager.productList.length, //
                        //groupByDate[index],
                        itemBuilder: (context, int index) {
                          return Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                child: Row(
                                  //mainAxisAlignment: MainAxisAlignment.start,
                                  //crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CustomBG(
                                      child: Image.asset(
                                        'assets/images/product_logo.png',
                                        height: 100,
                                        width: 100,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 6),
                                                child: Text(
                                                  SingletonDataManager
                                                      .productList[index].name,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontFamily:
                                                          CustomFonts.montserratBold,
                                                      fontSize: 15),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 6),
                                                child: Text(
                                                  SingletonDataManager
                                                      .productList[index]
                                                      .launchedAt,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontFamily:
                                                          CustomFonts.montserrat,
                                                      fontSize: 13),
                                                ),
                                              ),
                                              Text(
                                                SingletonDataManager
                                                    .productList[index]
                                                    .launchSite,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontFamily:
                                                        CustomFonts.montserrat,
                                                    fontSize: 13),
                                              ),
                                              StarRating(
                                                  rating: double.parse(
                                                      SingletonDataManager
                                                          .productList[index]
                                                          .popularity),
                                                  onRatingChanged: null,
                                                  color: CustomColors.star,
                                                  size: 15),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  SingletonDataManager
                                                          .selectedProductIndex =
                                                      index;
                                                  Navigator.pushNamed(
                                                    context,
                                                    AppRoutes.product,
                                                    arguments:
                                                        SingletonDataManager
                                                            .productList[index],
                                                  );
                                                },
                                                child: const CustomBG(
                                                  child: Padding(
                                                    padding: EdgeInsets.all(3.0),
                                                    child: Icon(
                                                      Icons.edit,
                                                      size: 20,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  deleteProduct(context, index);
                                                },
                                                child: const CustomBG(
                                                  child: Padding(
                                                    padding: EdgeInsets.all(3.0),
                                                    child: Icon(
                                                      Icons.delete,
                                                      size: 20,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        })
                    : const Text("No Data Available"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showSortFilter(
    BuildContext context,
  ) {
    return showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Color.fromRGBO(248, 248, 248, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30.0), topLeft: Radius.circular(30.0)),
        ),
        context: context,
        builder: (BuildContext c) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setBottomSheetState /*You can rename this!*/) {
            return NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowGlow();
                return true;
              },
              child: Wrap(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 15)
                            .copyWith(top: 15),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Text(
                            "Sort by :",
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: CustomFonts.montserrat,
                                color: Colors.black),
                          ),
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        applySorting(sortOn: "name",);
                                        // setBottomSheetState(() {
                                        //   // set variable here
                                        // });
                                      },
                                      child: const Text("By Name",style: TextStyle(
                                          color: Colors.white,
                                          fontFamily:
                                          CustomFonts.montserrat,
                                          fontSize: 15))),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        applySorting(sortOn: "date");
                                      },
                                      child: const Text("By Date",style: TextStyle(
                                          color: Colors.white,
                                          fontFamily:
                                          CustomFonts.montserrat,
                                          fontSize: 15))),
                                ],
                              ),
                              Row(
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        applySorting(sortOn: "popularity");
                                      },
                                      child: const Text("By Popularity",style: TextStyle(
                                          color: Colors.white,
                                          fontFamily:
                                          CustomFonts.montserrat,
                                          fontSize: 15))),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        applySorting(sortOn: "location");
                                      },
                                      child: const Text("By Location",style: TextStyle(
                                          color: Colors.white,
                                          fontFamily:
                                          CustomFonts.montserrat,
                                          fontSize: 15))),
                                ],
                              ),
                            ]),
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
        }).whenComplete(() {});
  }

  String sortBy = "";
  String sortD = "";
  final DateFormat dtFormat = DateFormat('yyyy-MM-dd');
  applySorting({String sortOn = ""}) {
    Navigator.of(context).pop();

    if (sortBy == sortOn) {
      sortD = (sortD == "1")
          ? "0"
          : (sortD == "0")
              ? "1"
              : "0";
    } else {
      sortD = "1";
      sortBy = sortOn;
    }

    switch (sortOn) {
      case "name":
        if (sortD == "1") {
          SingletonDataManager.productList.sort(
            (a, b) {
              return a.name.toLowerCase().compareTo(b.name.toLowerCase());
            },
          );
        } else {
          SingletonDataManager.productList.sort(
            (b, a) {
              return a.name.toLowerCase().compareTo(b.name.toLowerCase());
            },
          );
        }
        break;
      case "date":
        if (sortD == "1") {
          SingletonDataManager.productList.sort((a, b){
            return DateTime.parse(a.launchedAt.split("").reversed.join("")+" 00:00:00").compareTo(DateTime.parse(b.launchedAt.split("").reversed.join("")+" 00:00:00"));
          });
        } else {
          SingletonDataManager.productList.sort((b, a){
            return DateTime.parse(a.launchedAt.split("").reversed.join("")+" 00:00:00").compareTo(DateTime.parse(b.launchedAt.split("").reversed.join("")+" 00:00:00"));
          });
        }
        break;
      case "popularity":
        if (sortD == "1") {
          SingletonDataManager.productList.sort(
                (a, b) {
              return double.parse(a.popularity).compareTo(double.parse(b.popularity));
            },
          );
        } else {
          SingletonDataManager.productList.sort(
                (b, a) {
              return double.parse(a.popularity).compareTo(double.parse(b.popularity));
            },
          );
        }
        break;
      case "location":
        if (sortD == "1") {
          SingletonDataManager.productList.sort(
                (a, b) {
              return a.launchSite.toLowerCase().compareTo(b.launchSite.toLowerCase());
            },
          );
        } else {
          SingletonDataManager.productList.sort(
                (b, a) {
              return a.launchSite.toLowerCase().compareTo(b.launchSite.toLowerCase());
            },
          );
        }
        break;
    }

    setState(() {
      SingletonDataManager.productList;
    });
  }

  editProduct(Product product) {
    setState(() {
      SingletonDataManager.productList
          .elementAt(SingletonDataManager.selectedProductIndex)
          .launchedAt = product.launchedAt;
      SingletonDataManager.productList
          .elementAt(SingletonDataManager.selectedProductIndex)
          .name = product.name;
      SingletonDataManager.productList
          .elementAt(SingletonDataManager.selectedProductIndex)
          .launchSite = product.launchSite;
      SingletonDataManager.productList
          .elementAt(SingletonDataManager.selectedProductIndex)
          .popularity = product.popularity;
    });
  }

  addProduct(Product product) {
    setState(() {
      SingletonDataManager.productList.add(product);
    });
  }

  deleteProduct(BuildContext context, int index) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("No"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Yes"),
      onPressed: () {
        Navigator.pop(context);
        setState(() {
          SingletonDataManager.productList.removeAt(index);
        });
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text("Do you really want to delete?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }



}
