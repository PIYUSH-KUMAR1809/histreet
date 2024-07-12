import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomLoader {
  bool _isShowing = false;

  Future<dynamic> showLoader(BuildContext context) async {
    if (!_isShowing) {
      _isShowing = true;
      return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.red,
            ),
          );
        },
      );
    }
  }

  void hideLoader() {
    if (_isShowing) {
      _isShowing = false;
      Get.back();
    }
  }
}
