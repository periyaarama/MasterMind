import 'package:flutter/material.dart';
import 'package:master_mind/screens/account_screen.dart';
import 'package:master_mind/screens/login_signup/auth_page.dart';
import 'package:master_mind/screens/book_details_screen/book_details_screen.dart';
import 'package:master_mind/screens/book_details_seller_screen/book_details_seller_screen.dart';
import 'package:master_mind/screens/explore_scrolled_screen/explore_scrolled_screen.dart';
import 'package:master_mind/screens/login_signup/forgot_password_screen.dart';
import 'package:master_mind/screens/home_screen_container_screen.dart';
import 'package:master_mind/screens/profile_details_screen.dart';
import 'package:master_mind/screens/seller_details_screen/seller_details_screen.dart';
import '../screens/app_navigation_screen/app_navigation_screen.dart';
import '../screens/login_signup/log_in_email_one_screen.dart';
import '../screens/login_signup/log_in_email_screen.dart';
import '../screens/login_signup/sign_up_screen.dart';

// ignore_for_file: must_be_immutable
class AppRoutes {
  static const String authPage = '/auth_page';

  static const String signUpScreen = '/sign_up_screen';

  static const String logInEmailScreen = '/log_in_email_screen';

  static const String logInEmailOneScreen = '/log_in_email_one_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String initialRoute = '/initialRoute';

  static const String forgotPasswordScreen = '/forgot_password_screen';

  static const String homeScreenContainerScreen =
      '/home_screen_container_screen';

  static const String homeScreenPage = '/home_screen_page';

  static const String bookDetailsScreen = '/book_details_screen';

  static const String exploreScrolledScreen = '/explore_scrolled_screen';

  static const String myLibraryPage = '/my_library_page';

  static const String sellerDetailsScreen = '/seller_details_screen';

  static const String bookDetailsSellerScreen = '/book_details_seller_screen';

  static const String accountScreen = '/account_screen';

  static const String profileDetailsScreen = '/profile_details_screen';

  static Map<String, WidgetBuilder> routes = {
    initialRoute: (context) => const AuthPage(),
    authPage: (context) => const AuthPage(),
    signUpScreen: (context) => const SignUpScreen(),
    logInEmailScreen: (context) => const LogInEmailScreen(),
    logInEmailOneScreen: (context) => const LogInEmailOneScreen(),
    appNavigationScreen: (context) => const AppNavigationScreen(),
    homeScreenContainerScreen: (context) => HomeScreenContainerScreen(),
    bookDetailsScreen: (context) => BookDetailsScreen(),
    exploreScrolledScreen: (context) => ExploreScrolledScreen(),
    sellerDetailsScreen: (context) => SellerDetailsScreen(),
    bookDetailsSellerScreen: (context) => BookDetailsSellerScreen(),
    accountScreen: (context) => const AccountScreen(),
    profileDetailsScreen: (context) => const ProfileDetailsScreen(),
    forgotPasswordScreen: (context) => const ForgotPasswordScreen(),
  };
}
