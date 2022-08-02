import 'package:flutter/material.dart';
import 'package:get/get.dart';

pushNamed(context, String routeName) {
  // Navigator.of(context).pushNamed(routeName);
  Get.toNamed(routeName);
}

popUntil(context, String routeName) {
  Navigator.of(context).popUntil(ModalRoute.withName(routeName));
}

pushAndRemoveUntil(context, String routeName) {
  Navigator.of(context).pushNamedAndRemoveUntil(routeName, ModalRoute.withName(routeName));
}

pop(context, {data}) {
  data != null ? Navigator.of(context).pop(data) : Navigator.of(context).pop();
}
