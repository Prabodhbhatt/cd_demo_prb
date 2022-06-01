import 'package:cd_demo/const/color_conts.dart';
import 'package:flutter/material.dart';
typedef void RatingChangeCallback(double rating);

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final RatingChangeCallback? onRatingChanged;
  final Color color;
  final double size;
  StarRating({this.starCount = 5, this.rating = .0, this.onRatingChanged, required this.color, required this.size});

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = Icon(
        //Icons.star,
        Icons.star_outline,
        color:  CustomColors.star,
        //color: color??CustomColors.disableStart,
        size: size,
      );
    }
    else if (index > rating - 1 && index < rating) {
      icon = Icon(
        Icons.star_half,
        color:  CustomColors.star,
        size: size,
      );
    } else {
      icon = Icon(
        Icons.star,
        color: CustomColors.star,
        size: size,
      );
    }
    return InkResponse(
      onTap: onRatingChanged == null ? null : () => onRatingChanged!(index + 1.0),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Row(children: new List.generate(starCount, (index) => buildStar(context, index)));
  }
}





// import 'package:flutter/material.dart';
// import 'package:tennishub/utils/custom_colors.dart';
//
// typedef void RatingChangeCallback(double rating);
//
// class StarRating extends StatelessWidget {
//   final int starCount;
//   final double rating;
//   final RatingChangeCallback onRatingChanged;
//   final Color color;
//   final double size;
//   final bool showDisableStarColor;
//
//   StarRating(
//       {this.starCount = 5,
//       this.rating = .0,
//       this.onRatingChanged,
//       this.color,
//       this.size,
//       this.showDisableStarColor = false
//       });
//
//   Widget buildStar(BuildContext context, int index) {
//     print(index);
//     print(rating);
//     Icon icon;
//     if (index >= rating) {
//       if(showDisableStarColor){
//         icon = new Icon(
//           Icons.star_outline_sharp,
//           color: color ?? CustomColors.star,
//           size: size,
//         );
//       }else{
//         icon = new Icon(
//           Icons.star,
//           color: color ?? CustomColors.disableStart,
//           size: size,
//         );
//       }
//
//     } else if (index > rating - 1 && index < rating) {
//       icon = new Icon(
//         Icons.star_half,
//         color: color ?? CustomColors.star,
//         size: size,
//       );
//     } else {
//       icon = new Icon(
//         Icons.star,
//         color: color ?? CustomColors.star,
//         size: size,
//       );
//     }
//     return new InkResponse(
//       onTap:
//           onRatingChanged == null ? null : () => onRatingChanged(index + 1.0),
//       child: icon,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return new Row(
//         children: new List.generate(starCount, (index) {
//       return buildStar(context, index);
//     }));
//   }
// }
