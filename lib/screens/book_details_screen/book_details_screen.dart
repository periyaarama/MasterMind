import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_icon_button.dart';
import 'widgets/chipviewpersona_item_widget.dart';
import 'widgets/userprofile3_item_widget.dart';

// ignore_for_file: must_be_immutable
class BookDetailsScreen extends StatelessWidget {
  BookDetailsScreen({super.key});

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          iconTheme: const IconThemeData(
            color: Colors.white, // Change this color to your preference
          ),
        ),
        extendBodyBehindAppBar: true,
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(bottom: 5.v),
              child: Column(
                children: [
                  _buildImageStack(context),
                  SizedBox(height: 23.v),
                  _buildProjectRow(context),
                  SizedBox(height: 21.v),
                  CustomElevatedButton(
                    height: 40.v,
                    text: "180 pages",
                    margin: EdgeInsets.symmetric(horizontal: 16.h),
                    leftIcon: Container(
                      margin: EdgeInsets.only(right: 9.h),
                      child: CustomImageView(
                        imagePath: ImageConstant.imgUilbook,
                        height: 24.adaptSize,
                        width: 24.adaptSize,
                      ),
                    ),
                    buttonStyle: CustomButtonStyles.fillBlueGray,
                    buttonTextStyle: theme.textTheme.titleSmall!,
                  ),
                  SizedBox(height: 27.v),
                  _buildAboutThisColumn(context),
                  SizedBox(height: 49.v),
                  _buildChaptersColumn(context),
                  SizedBox(height: 26.v),
                  _buildFinalSummaryColumn(context),
                  SizedBox(height: 30.v),
                  _buildSimilarBooksColumn(context)
                ],
              ),
            ),
          ),
        ),
        // bottomNavigationBar: _buildBottomBar(context),
      ),
    );
  }

  /// Section Widget
  Widget _buildImageStack(BuildContext context) {
    return SizedBox(
      height: 333.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgE50c016fB6a84184x128,
            height: 321.v,
            width: 390.h,
            alignment: Alignment.topCenter,
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 333.v,
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 16.h),
              decoration:
                  AppDecoration.gradientOnPrimaryContainerToOnPrimaryContainer,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgE50c016fB6a84184x128,
                    height: 220.v,
                    width: 153.h,
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.only(bottom: 6.v),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(top: 277.v),
                      padding: EdgeInsets.symmetric(
                        horizontal: 43.h,
                        vertical: 16.v,
                      ),
                      decoration: AppDecoration.fillBlueGray.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder8,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgBiPlayFill,
                            height: 16.adaptSize,
                            width: 16.adaptSize,
                            margin: EdgeInsets.only(
                              top: 2.v,
                              bottom: 5.v,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 9.h,
                              top: 1.v,
                              bottom: 5.v,
                            ),
                            child: Text(
                              "Read Nexus",
                              style: theme.textTheme.titleSmall,
                            ),
                          ),
                          Opacity(
                            opacity: 0.3,
                            child: Padding(
                              padding: EdgeInsets.only(left: 43.h),
                              child: SizedBox(
                                height: 24.v,
                                child: VerticalDivider(
                                  width: 1.h,
                                  thickness: 1.v,
                                  color: appTheme.gray400.withOpacity(0.46),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 55.h,
                              top: 2.v,
                              bottom: 3.v,
                            ),
                            child: Text(
                              "BUY 30 RM",
                              style: theme.textTheme.titleSmall,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildProjectRow(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 319.h,
                  child: Text(
                    "Project Management for the Unofficial Proect Manager",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleLarge,
                  ),
                ),
                SizedBox(height: 10.v),
                Text(
                  "Kory Kogon, Suzette Blakemore, and James wood",
                  style: theme.textTheme.titleSmall,
                ),
                SizedBox(height: 8.v),
                Text(
                  "A FanklinConvey Title",
                  style: theme.textTheme.titleSmall,
                )
              ],
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgUilBookmark,
            height: 20.adaptSize,
            width: 20.adaptSize,
            margin: EdgeInsets.only(
              left: 18.h,
              bottom: 82.v,
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildAboutThisColumn(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "About this Book",
            style: theme.textTheme.titleMedium,
          ),
          SizedBox(height: 8.v),
          Container(
            width: 351.h,
            margin: EdgeInsets.only(right: 6.h),
            child: Text(
              "Getting Along (2022) describes the importance of workplace interactions and their effecs on productivity and creaiviy.",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleSmall,
            ),
          ),
          SizedBox(height: 14.v),
          Wrap(
            runSpacing: 8.v,
            spacing: 8.h,
            children: List<Widget>.generate(
                4, (index) => const ChipviewpersonaItemWidget()),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildChaptersColumn(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "56 Chapters",
            style: theme.textTheme.titleLarge,
          ),
          SizedBox(height: 23.v),
          _buildRowtwo(
            context,
            textValue: "01",
            subTitle: "Introducion",
            bookTitle: "Subscribe to unlock all 2 key ideas from book ",
          ),
          SizedBox(height: 26.v),
          _buildRowtwo(
            context,
            textValue: "02",
            subTitle: "Creating the ",
            bookTitle: "Subscribe to unlock all 2 key ideas from book ",
          ),
          SizedBox(height: 26.v),
          _buildRowtwo(
            context,
            textValue: "03",
            subTitle: "Introducion",
            bookTitle: "Subscribe to unlock all 2 key ideas from book ",
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildFinalSummaryColumn(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 7.v,
                    bottom: 5.v,
                  ),
                  child: Text(
                    "Final Summary",
                    style: CustomTextStyles.titleMediumPrimary,
                  ),
                ),
                CustomIconButton(
                  height: 32.adaptSize,
                  width: 32.adaptSize,
                  padding: EdgeInsets.all(6.h),
                  child: CustomImageView(
                    imagePath: ImageConstant.imgUilLock,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 22.v),
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(AppRoutes.bookDetailsSellerScreen);
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12.h,
                vertical: 11.v,
              ),
              decoration: AppDecoration.fillBlueGray.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder12,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgEllipse1,
                    height: 54.adaptSize,
                    width: 54.adaptSize,
                    radius: BorderRadius.circular(
                      27.h,
                    ),
                    margin: EdgeInsets.only(bottom: 19.v),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 11.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "James wood",
                          style: theme.textTheme.titleMedium,
                        ),
                        SizedBox(height: 4.v),
                        Text(
                          "A FanklinConvey Title",
                          style:
                              CustomTextStyles.labelLargeAbhayaLibreExtraBold,
                        ),
                        SizedBox(height: 6.v),
                        SizedBox(
                          width: 216.h,
                          child: Text(
                            "Managers who want to create positive work enviroments",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style:
                                CustomTextStyles.labelLargeAbhayaLibreExtraBold,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildSimilarBooksColumn(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Similar Books",
                style: theme.textTheme.titleLarge,
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4.v),
                child: Text(
                  "Show all",
                  style:
                      CustomTextStyles.labelLargeAbhayaLibreExtraBoldGreen100,
                ),
              ),
              CustomImageView(
                imagePath: ImageConstant.imgArrowRight,
                height: 16.adaptSize,
                width: 16.adaptSize,
                margin: EdgeInsets.only(
                  left: 4.h,
                  top: 5.v,
                  bottom: 2.v,
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 17.v),
        // SizedBox(
        //   height: 270.v,
        //   child: ListView.separated(
        //     padding: EdgeInsets.only(left: 16.h),
        //     scrollDirection: Axis.horizontal,
        //     separatorBuilder: (context, index) {
        //       return SizedBox(
        //         width: 8.h,
        //       );
        //     },
        //     itemCount: 3,
        //     itemBuilder: (context, index) {
        //       return const Userprofile3ItemWidget(book: book,);
        //     },
        //   ),
        // )
      ],
    );
  }

  /// Section Widget
  // Widget _buildBottomBar(BuildContext context) {
  //   return CustomBottomBar(
  //     onChanged: (BottomBarEnum type) {
  //       Navigator.pushNamed(
  //           navigatorKey.currentContext!, getCurrentRoute(type));
  //     },
  //   );
  // }

  /// Common widget
  Widget _buildRowtwo(
    BuildContext context, {
    required String textValue,
    required String subTitle,
    required String bookTitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 22.v),
          child: Text(
            textValue,
            style: theme.textTheme.titleMedium!.copyWith(
              color: theme.colorScheme.onError.withOpacity(1),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subTitle,
                  style: theme.textTheme.titleMedium!.copyWith(
                    color: theme.colorScheme.onError.withOpacity(1),
                  ),
                ),
                SizedBox(height: 4.v),
                Text(
                  bookTitle,
                  style: theme.textTheme.titleSmall!.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 28.h,
            top: 5.v,
            bottom: 3.v,
          ),
          child: CustomIconButton(
            height: 32.adaptSize,
            width: 32.adaptSize,
            padding: EdgeInsets.all(6.h),
            child: CustomImageView(
              imagePath: ImageConstant.imgUilLock,
            ),
          ),
        )
      ],
    );
  }

  ///Handling route based on bottom click actions
  // String getCurrentRoute(BottomBarEnum type) {
  //   switch (type) {
  //     case BottomBarEnum.Home:
  //       return AppRoutes.homeScreenPage;
  //     case BottomBarEnum.Explore:
  //       return "/";
  //     case BottomBarEnum.Library:
  //       return AppRoutes.myLibraryPage;
  //     default:
  //       return "/";
  //   }
  // }

  ///Handling page based on route
  // Widget getCurrentPage(String currentRoute) {
  //   switch (currentRoute) {
  //     case AppRoutes.homeScreenPage:
  //       return const HomeScreenPage();
  //     case AppRoutes.myLibraryPage:
  //       return const MyLibraryPage();
  //     default:
  //       return const DefaultWidget();
  //   }
  // }
}
