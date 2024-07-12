import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:histreet/utilities/shared_preferences.dart';
import 'package:histreet/widgets/custom_loader.dart';

import '../../utilities/logger.dart';

class LoginController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  RxBool isObscure = true.obs;
  CustomLoader customLoader = CustomLoader();
  final _auth = FirebaseAuth.instance;

  void updatePasswordStatus() {
    isObscure.value = !isObscure.value;
  }

  Future<dynamic> login(BuildContext context) async {
    customLoader.showLoader(context);
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      logger.i(credential);
      await saveUserId(credential.user!.uid);
      customLoader.hideLoader();
      Get.offAllNamed('/home');
    } on FirebaseAuthException catch (e) {
      customLoader.hideLoader();
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to sign up: ${e.code}'),
          duration: const Duration(seconds: 1),
        ),
      );
      logger.e(e);
      return e;
    } catch (e) {
      customLoader.hideLoader();
      logger.e(e);
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to sign up'),
          duration: Duration(seconds: 1),
        ),
      );
      return e;
    }
  }
}
