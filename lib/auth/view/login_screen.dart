import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController loginController = Get.put(LoginController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                        top: 15.0,
                        left: 10.0,
                        right: 10.0,
                        bottom: 20.0,
                      ),
                      child: Text(
                        'Log in to your account',
                        style: GoogleFonts.poppins(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
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
                        'Welcome Back! Please enter your details.',
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
                              bottom: 20.0,
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
                                controller: loginController.email,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'This can not be empty';
                                  }
                                  return null;
                                },
                                onSaved: (value) {},
                                decoration: InputDecoration(
                                  icon: const Icon(Icons.email_outlined),
                                  iconColor:
                                      const Color.fromRGBO(133, 133, 133, 1.0),
                                  hintText: "Enter your email",
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
                                  controller: loginController.password,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'This can not be empty';
                                    }
                                    return null;
                                  },
                                  obscureText: loginController.isObscure.value,
                                  onSaved: (value) {},
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      icon: Icon(loginController.isObscure.value
                                          ? Icons.visibility_off
                                          : Icons.visibility),
                                      onPressed: () {
                                        loginController.updatePasswordStatus();
                                      },
                                    ),
                                    suffixIconColor: const Color.fromRGBO(
                                        133, 133, 133, 1.0),
                                    icon:
                                        const Icon(Icons.lock_outline_rounded),
                                    iconColor: const Color.fromRGBO(
                                        133, 133, 133, 1.0),
                                    hintText: "Enter your password",
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
                                  bool res = _formKey.currentState!.validate();
                                  if (!res) {
                                    return;
                                  }
                                  loginController.login(context);
                                },
                                child: Text(
                                  'Log In',
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: TextButton(
                          onPressed: () {
                            Get.offAllNamed('/signup');
                          },
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Don't have an account? ",
                                  style: GoogleFonts.poppins(
                                    color: const Color.fromRGBO(
                                        133, 133, 133, 1.0),
                                  ),
                                ),
                                TextSpan(
                                  text: 'Sign up',
                                  style:
                                      GoogleFonts.poppins(color: Colors.white),
                                ),
                              ],
                            ),
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
