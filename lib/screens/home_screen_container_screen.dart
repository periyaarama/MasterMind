import 'package:flutter/material.dart';
import 'package:master_mind/screens/account_screen.dart';
import 'package:master_mind/screens/book_details_screen/book_details_screen.dart';
import 'package:master_mind/screens/book_details_seller_screen/book_details_seller_screen.dart';
import 'package:master_mind/screens/explore_scrolled_screen/explore_scrolled_screen.dart';
import 'package:master_mind/screens/profile_details_screen.dart';
import 'package:master_mind/screens/seller_details_screen/seller_details_screen.dart';
import '../core/app_export.dart';
import '../widgets/custom_bottom_bar.dart';
import 'home_screen_page/home_screen_page.dart';
import 'my_library_page.dart';

// ignore_for_file: must_be_immutable
class HomeScreenContainerScreen extends StatelessWidget {
  HomeScreenContainerScreen({super.key});

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Navigator(
          key: navigatorKey,
          initialRoute: AppRoutes.homeScreenPage,
          onGenerateRoute: (routeSetting) => PageRouteBuilder(
            pageBuilder: (ctx, ani, ani1) => getCurrentPage(routeSetting.name!),
            transitionDuration: const Duration(seconds: 0),
          ),
        ),
        bottomNavigationBar: _buildBottombar(context),
      ),
    );
  }

  /// Section Widget
  Widget _buildBottombar(BuildContext context) {
    return CustomBottomBar(
      onChanged: (BottomBarEnum type) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.signUpScreen);
      },
    );
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.homeScreenPage;
      case BottomBarEnum.Explore:
        return AppRoutes.exploreScrolledScreen;
      case BottomBarEnum.Library:
        return AppRoutes.myLibraryPage;
      case BottomBarEnum.bookDetailsScreen:
        return AppRoutes.bookDetailsScreen;
      case BottomBarEnum.accountScreen:
        return AppRoutes.accountScreen;
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.homeScreenPage:
        return const HomeScreenPage();
      case AppRoutes.exploreScrolledScreen:
        return ExploreScrolledScreen();
      case AppRoutes.myLibraryPage:
        return const MyLibraryPage();
      case AppRoutes.bookDetailsScreen:
        return BookDetailsScreen();
      case AppRoutes.accountScreen:
        return AccountScreen();
      case AppRoutes.profileDetailsScreen:
        return ProfileDetailsScreen();
      case AppRoutes.bookDetailsSellerScreen:
        return BookDetailsSellerScreen();
      case AppRoutes.sellerDetailsScreen:
        return SellerDetailsScreen();
      default:
        return const DefaultWidget();
    }
  }
}
