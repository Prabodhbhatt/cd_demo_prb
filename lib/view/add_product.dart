import 'package:cd_demo/const/color_conts.dart';
import 'package:cd_demo/const/custom_fonts.dart';
import 'package:cd_demo/model/product.dart';
import 'package:cd_demo/model/singleton_data_manager.dart';
import 'package:cd_demo/utils/star_rating.dart';
import 'package:cd_demo/utils/validation_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class AddProductScreen extends StatefulWidget {
  final Product? productData;

  const AddProductScreen({Key? key, this.productData}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final DateFormat dtFormat = DateFormat('dd-MM-yyyy');
  String toDate = ""; //DateTime.now().toString();
  bool isDateSelected = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController launchSiteController = TextEditingController();
  double rating = 0;

  @override
  void initState() {
    // TODO: implement initState
    if (widget.productData != null) {
      toDate = widget.productData!.launchedAt;
      nameController.text = widget.productData!.name;
      launchSiteController.text = widget.productData!.launchSite;
      rating = double.parse(widget.productData!.popularity);
    }
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    launchSiteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          (widget.productData == null) ? "Add Product" : "Edit Product",
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Enter Produc Details",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: CustomFonts.montserrat,
                    fontSize: 16)),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text("Date :",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: CustomFonts.montserrat,
                            fontSize: 14)),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                        onTap: () {
                          selectDate();
                        },
                        child: Icon(
                          Icons.date_range,
                          size: 25,
                          color: CustomColors.primaryColor,
                        )),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(toDate,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: CustomFonts.montserrat,
                            fontSize: 14)),
                  ],
                ),
                TextFormField(
                  controller: nameController,
                  style: const TextStyle(
                      color: Colors.black,
                      fontFamily: CustomFonts.montserrat,
                      fontSize: 14),
                  maxLength: 50,
                  decoration: const InputDecoration(
                      counterText: "",
                      hintText: "Enter Product Name",
                      alignLabelWithHint: true,
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontFamily: CustomFonts.montserrat,
                          fontSize: 14)),
                ),
                TextFormField(
                  controller: launchSiteController,
                  maxLength: 50,
                  style: const TextStyle(
                      color: Colors.black,
                      fontFamily: CustomFonts.montserrat,
                      fontSize: 14),
                  decoration: const InputDecoration(
                      counterText: "",
                      hintText: "Enter Launch Site",
                      alignLabelWithHint: true,
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontFamily: CustomFonts.montserrat,
                          fontSize: 14),

                  ),
                ),
                Row(
                  children: [
                    Text("Popularity : "),
                    StarRating(
                        color: Color.fromRGBO(206, 206, 206, 1),
                        size: 30,
                        rating: rating,
                        onRatingChanged: (rating) {
                          // print(rating);
                          setState(() {
                            this.rating = rating;
                          });
                        }),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      addProduct();
                    },
                    child: Text((widget.productData != null)
                        ? "Update Product"
                        : "Add Product",

                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily:
                            CustomFonts.montserrat,
                            fontSize: 15)
                    ),


                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void addProduct() {
    if (validateDate(toDate, "Date").isNotEmpty) {
      return;
    } else if (validateLength(nameController.text, "Product Name").isNotEmpty) {
      return;
    } else if (validateLength(launchSiteController.text, "Launch Site")
        .isNotEmpty) {
      return;
    } else if (validateRating(rating, "Popularity").isNotEmpty) {
      return;
    }

    bool duplicateName = false;
    SingletonDataManager.productList.every((Product element) {
      if (element.name.toLowerCase() == nameController.text.toLowerCase()) {
        duplicateName = true;
      }
      return duplicateName;
    });

    if (duplicateName) {
      Fluttertoast.showToast(
        msg: "Product available with same name.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }

    Product product = Product(
        name: nameController.text,
        launchedAt: toDate,
        launchSite: launchSiteController.text,
        popularity: rating.toString());

    if (widget.productData != null) {
      Fluttertoast.showToast(
        msg: "Product updated successfully.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
      SingletonDataManager.fnUpdateProduct!(product);
      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(
        msg: "Product added successfully.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
      SingletonDataManager.fnAddProduct!(product);
      Navigator.pop(context);
    }
  }

  Future<DateTime> selectDate() async {
    DateTime currentDate = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2030));
    if (pickedDate != null) {
      //updateState(() {
      setState(() {
        isDateSelected = true;
        toDate = dtFormat.format(pickedDate).toString();
      });
    }
    return currentDate;
  }
}
