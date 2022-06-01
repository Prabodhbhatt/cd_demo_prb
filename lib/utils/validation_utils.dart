import 'package:fluttertoast/fluttertoast.dart';

String validateLength(String value, String fieldName) {
  if (value.isEmpty) {

    Fluttertoast.showToast(
      msg: "Please enter $fieldName.",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,

    );
    return"$fieldName is Required";
  } else {
    return "";
  }
}

String validateDate(String value, String fieldName) {
  if (value.isEmpty) {

    Fluttertoast.showToast(
      msg: "Please select $fieldName.",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,

    );
    return"$fieldName is Required";
  } else {
    return "";
  }
}

String validateRating(double value, String fieldName) {
  if (value == 0) {

    Fluttertoast.showToast(
      msg: "Please select $fieldName.",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,

    );
    return"$fieldName is Required";
  } else {
    return "";
  }
}
