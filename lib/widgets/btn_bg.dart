import 'package:cd_demo/const/color_conts.dart';
import 'package:flutter/material.dart';
class CustomBG extends StatelessWidget {
  final Widget child;
  final Color bgColor;
  final int height;
  final int width;

  const CustomBG({
    Key? key,
    required this.child,this.bgColor = CustomColors.bgColor,
    this.height=45, this.width = 50
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: bgColor,
        // boxShadow: [
        //   BoxShadow(color: Colors.green, spreadRadius: 3),
        // ],
      ),
      child: child,
      //height: 50,
    );
  }
}
