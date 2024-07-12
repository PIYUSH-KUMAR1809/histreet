import 'dart:core';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:histreet/auth/controller/signup_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

//TODO: Icons for form fields
class _SignUpScreenState extends State<SignUpScreen> {
  SignUpController signUpController = Get.put(SignUpController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();
  final FocusNode _focusNode5 = FocusNode();

  @override
  void dispose() {
    // Dispose FocusNodes
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    _focusNode4.dispose();
    _focusNode5.dispose();
    super.dispose();
  }

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(21, 21, 21, 1.0),
        body: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 15.0,
                        left: 10.0,
                        right: 10.0,
                        bottom: 20.0,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Image.asset(
                              "assets/images/star.png",
                              height: 40.0,
                              width: 40.0,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(),
                          ),
                          const Expanded(
                            flex: 6,
                            child: Divider(
                              color: Color.fromRGBO(71, 71, 71, 1.0),
                              thickness: 2.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10.0,
                        right: 10.0,
                        bottom: 20.0,
                      ),
                      child: Text(
                        'Create an account',
                        style: GoogleFonts.poppins(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10.0,
                        right: 10.0,
                        bottom: 20.0,
                      ),
                      child: Text(
                        'Welcome! Please enter your details.',
                        style: GoogleFonts.poppins(
                          fontSize: 14.0,
                          color: const Color.fromRGBO(133, 133, 133, 1.0),
                        ),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10.0,
                              right: 10.0,
                              bottom: 10.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Name',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10.0,
                              right: 10.0,
                              bottom: 10.0,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(38, 39, 40, 1.0),
                                border:
                                    Border.all(width: 1.0, color: Colors.black),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(
                                    10.0,
                                  ),
                                  topRight: Radius.circular(
                                    10.0,
                                  ),
                                  bottomLeft: Radius.circular(
                                    10.0,
                                  ),
                                  bottomRight: Radius.circular(
                                    10.0,
                                  ),
                                ),
                              ),
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: signUpController.name,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Name can not be empty';
                                  }
                                  return null;
                                },
                                focusNode: _focusNode1,
                                onFieldSubmitted: (_) {
                                  _fieldFocusChange(
                                      context, _focusNode1, _focusNode3);
                                },
                                onSaved: (value) {},
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[a-zA-Z.]')),
                                ],
                                decoration: InputDecoration(
                                  icon: const Icon(Icons.person),
                                  iconColor:
                                      const Color.fromRGBO(133, 133, 133, 1.0),
                                  hintText: "Name",
                                  hintStyle: GoogleFonts.poppins(
                                    color: const Color.fromRGBO(
                                        133, 133, 133, 1.0),
                                  ),
                                  filled: true,
                                  border: InputBorder.none,
                                  fillColor:
                                      const Color.fromRGBO(38, 39, 40, 1.0),
                                ),
                                style: GoogleFonts.poppins(
                                  color:
                                      const Color.fromRGBO(133, 133, 133, 1.0),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10.0,
                              right: 10.0,
                              bottom: 10.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Email',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10.0,
                              right: 10.0,
                              bottom: 10.0,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(38, 39, 40, 1.0),
                                border:
                                    Border.all(width: 1.0, color: Colors.black),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(
                                    10.0,
                                  ),
                                  topRight: Radius.circular(
                                    10.0,
                                  ),
                                  bottomLeft: Radius.circular(
                                    10.0,
                                  ),
                                  bottomRight: Radius.circular(
                                    10.0,
                                  ),
                                ),
                              ),
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: signUpController.email,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Email can not be empty';
                                  }
                                  if (!EmailValidator.validate(
                                      signUpController.email.text)) {
                                    return 'Invalid email';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.emailAddress,
                                onSaved: (value) {},
                                focusNode: _focusNode3,
                                onFieldSubmitted: (_) {
                                  _fieldFocusChange(
                                      context, _focusNode3, _focusNode4);
                                },
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r"\s")),
                                ],
                                decoration: InputDecoration(
                                  icon: const Icon(Icons.email_outlined),
                                  hintText: "Email",
                                  filled: true,
                                  border: InputBorder.none,
                                  fillColor:
                                      const Color.fromRGBO(38, 39, 40, 1.0),
                                  iconColor:
                                      const Color.fromRGBO(133, 133, 133, 1.0),
                                  hintStyle: GoogleFonts.poppins(
                                    color: const Color.fromRGBO(
                                        133, 133, 133, 1.0),
                                  ),
                                ),
                                style: GoogleFonts.poppins(
                                  color:
                                      const Color.fromRGBO(133, 133, 133, 1.0),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10.0,
                              right: 10.0,
                              bottom: 10.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Password',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10.0,
                              right: 10.0,
                              bottom: 10.0,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(38, 39, 40, 1.0),
                                border:
                                    Border.all(width: 1.0, color: Colors.black),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(
                                    10.0,
                                  ),
                                  topRight: Radius.circular(
                                    10.0,
                                  ),
                                  bottomLeft: Radius.circular(
                                    10.0,
                                  ),
                                  bottomRight: Radius.circular(
                                    10.0,
                                  ),
                                ),
                              ),
                              padding: const EdgeInsets.all(8.0),
                              child: Obx(
                                () => TextFormField(
                                  controller: signUpController.password,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Password can not be empty';
                                    }
                                    if (value.length < 8) {
                                      return 'Password should be of minimum length 8';
                                    }
                                    return null;
                                  },
                                  obscureText:
                                      signUpController.isObscurePassword.value,
                                  onSaved: (value) {},
                                  focusNode: _focusNode4,
                                  onFieldSubmitted: (_) {
                                    _fieldFocusChange(
                                        context, _focusNode4, _focusNode5);
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.deny(
                                        RegExp(r"\s")),
                                  ],
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      icon: Icon(signUpController
                                              .isObscurePassword.value
                                          ? Icons.visibility_off
                                          : Icons.visibility),
                                      onPressed: () {
                                        signUpController.updatePasswordStatus();
                                      },
                                    ),
                                    suffixIconColor: const Color.fromRGBO(
                                        133, 133, 133, 1.0),
                                    icon:
                                        const Icon(Icons.lock_outline_rounded),
                                    hintText: "Password",
                                    filled: true,
                                    border: InputBorder.none,
                                    fillColor:
                                        const Color.fromRGBO(38, 39, 40, 1.0),
                                    iconColor: const Color.fromRGBO(
                                        133, 133, 133, 1.0),
                                    hintStyle: GoogleFonts.poppins(
                                      color: const Color.fromRGBO(
                                          133, 133, 133, 1.0),
                                    ),
                                  ),
                                  style: GoogleFonts.poppins(
                                    color: const Color.fromRGBO(
                                        133, 133, 133, 1.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10.0,
                              right: 10.0,
                              bottom: 10.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Confirm Password',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10.0,
                              right: 10.0,
                              bottom: 10.0,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(38, 39, 40, 1.0),
                                border:
                                    Border.all(width: 1.0, color: Colors.black),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(
                                    10.0,
                                  ),
                                  topRight: Radius.circular(
                                    10.0,
                                  ),
                                  bottomLeft: Radius.circular(
                                    10.0,
                                  ),
                                  bottomRight: Radius.circular(
                                    10.0,
                                  ),
                                ),
                              ),
                              padding: const EdgeInsets.all(8.0),
                              child: Obx(
                                () => TextFormField(
                                  controller: signUpController.confirmPassword,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Confirm Password can not be empty';
                                    }
                                    if (value.length < 8) {
                                      return 'Password should be of minimum length 8';
                                    }
                                    return null;
                                  },
                                  obscureText: signUpController
                                      .isObscureConfirmPassword.value,
                                  onSaved: (value) {},
                                  focusNode: _focusNode5,
                                  onFieldSubmitted: (_) {
                                    _focusNode5.unfocus();
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.deny(
                                        RegExp(r"\s")),
                                  ],
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        signUpController
                                                .isObscureConfirmPassword.value
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                      onPressed: () {
                                        signUpController
                                            .updateConfirmPasswordStatus();
                                      },
                                    ),
                                    suffixIconColor: const Color.fromRGBO(
                                        133, 133, 133, 1.0),
                                    icon:
                                        const Icon(Icons.lock_outline_rounded),
                                    iconColor: const Color.fromRGBO(
                                        133, 133, 133, 1.0),
                                    hintText: "Confirm Password",
                                    hintStyle: GoogleFonts.poppins(
                                      color: const Color.fromRGBO(
                                          133, 133, 133, 1.0),
                                    ),
                                    filled: true,
                                    border: InputBorder.none,
                                    fillColor:
                                        const Color.fromRGBO(38, 39, 40, 1.0),
                                  ),
                                  style: GoogleFonts.poppins(
                                    color: const Color.fromRGBO(
                                        133, 133, 133, 1.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10.0,
                              right: 10.0,
                              bottom: 20.0,
                            ),
                            child: Container(
                              width: double.maxFinite,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromRGBO(206, 76, 66, 1.0),
                                    Color.fromRGBO(123, 62, 134, 1.0),
                                  ],
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                    10.0,
                                  ),
                                  topRight: Radius.circular(
                                    10.0,
                                  ),
                                  bottomLeft: Radius.circular(
                                    10.0,
                                  ),
                                  bottomRight: Radius.circular(
                                    10.0,
                                  ),
                                ),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  bool validate =
                                      _formKey.currentState!.validate();
                                  if (!validate) {
                                    return;
                                  }
                                  if (signUpController.password.text !=
                                      signUpController.confirmPassword.text) {
                                    ScaffoldMessenger.of(context)
                                        .clearSnackBars();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Password does not match',
                                          style: GoogleFonts.poppins(),
                                        ),
                                        duration: const Duration(seconds: 1),
                                      ),
                                    );
                                    return;
                                  }
                                  _formKey.currentState!.save();
                                  signUpController.signUp(context);
                                },
                                child: Text(
                                  'Register',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Get.offAllNamed('/login');
                        },
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Already have an account? ",
                                style: GoogleFonts.poppins(
                                  color:
                                      const Color.fromRGBO(133, 133, 133, 1.0),
                                ),
                              ),
                              TextSpan(
                                text: 'Log In',
                                style: GoogleFonts.poppins(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
