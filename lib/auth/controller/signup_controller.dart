import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:histreet/utilities/logger.dart';
import 'package:histreet/utilities/shared_preferences.dart';
import 'package:histreet/widgets/custom_loader.dart';

class SignUpController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  RxBool isObscurePassword = true.obs;
  RxBool isObscureConfirmPassword = true.obs;
  final _auth = FirebaseAuth.instance;
  CustomLoader customLoader = CustomLoader();

  void updatePasswordStatus() {
    isObscurePassword.value = !isObscurePassword.value;
  }

  void updateConfirmPasswordStatus() {
    isObscureConfirmPassword.value = !isObscureConfirmPassword.value;
  }

  Future<dynamic> signUp(BuildContext context) async {
    customLoader.showLoader(context);
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      // Here you can store the user's additional information like username
      User? user = userCredential.user;
      if (user != null) {
        await user.updateProfile(displayName: name.text);
        await user.reload();
        user = _auth.currentUser;
        await saveUserId(user!.uid);
        customLoader.hideLoader();
        Get.offAllNamed('/home');
      }
      logger.i(user);
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
