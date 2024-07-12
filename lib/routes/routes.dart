import 'package:get/get.dart';
import 'package:histreet/splash/splash_screen.dart';

import '../auth/view/login_screen.dart';
import '../auth/view/signup_screen.dart';
import '../home/view/home_screen.dart';

List<GetPage> get appRoutes => [
      GetPage(
        name: '/', // This will be the initial route
        page: () => const SplashScreen(),
      ),
      GetPage(
        name: '/login', // This will be the initial route
        page: () => const LoginScreen(),
      ),
      GetPage(
        name: '/signup',
        page: () => const SignUpScreen(),
      ),
      GetPage(
        name: '/home',
        page: () => const HomeScreen(),
      ),
    ];
