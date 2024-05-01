import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_search_view.dart';
import 'widgets/chipviewpersona2_item_widget.dart';
import 'widgets/userprofile4_item_widget.dart';
import 'widgets/userprofile5_item_widget.dart';
import 'widgets/userprofile6_item_widget.dart';

// ignore_for_file: must_be_immutable
class ExploreScrolledScreen extends StatelessWidget {
  ExploreScrolledScreen({super.key});

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 12.v),
            child: Padding(
              padding: EdgeInsets.only(bottom: 5.v),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 15.h,
                      right: 16.h,
                    ),
                    child: CustomSearchView(
                      controller: searchController,
                      hintText: "Title, author or keyword",
                    ),
                  ),
                  SizedBox(height: 41.v),
                  _buildColumnTopics(context),
                  SizedBox(height: 38.v),
                  _buildColumnFiction(context),
                  SizedBox(height: 24.v),
                  _buildColumnCultureSociety(context),
                  SizedBox(height: 24.v),
                  _buildColumnLifestyle(context)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: Padding(
        padding: EdgeInsets.only(left: 16.h),
        child: Column(
          children: [
            AppbarTitle(
              text: "Explore",
            ),
            SizedBox(height: 2.v),
            SizedBox(
              width: 79.h,
              child: Divider(
                color: appTheme.green100,
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildColumnTopics(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Topics",
            style: theme.textTheme.titleLarge,
          ),
          SizedBox(height: 15.v),
          Wrap(
            runSpacing: 8.v,
            spacing: 8.h,
            children: List<Widget>.generate(
                11, (index) => const Chipviewpersona2ItemWidget()),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildColumnFiction(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.h),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 17.h),
            child: _buildRowCultureSociety(
              context,
              title: "Fiction",
              showAll: "Show all",
            ),
          ),
          SizedBox(height: 17.v),
          SizedBox(
            height: 251.v,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: 8.h,
                );
              },
              itemCount: 3,
              itemBuilder: (context, index) {
                return const Userprofile4ItemWidget();
              },
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildColumnCultureSociety(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.h),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 17.h),
            child: _buildRowCultureSociety(
              context,
              title: "Culture & Society",
              showAll: "Show all",
            ),
          ),
          SizedBox(height: 15.v),
          SizedBox(
            height: 251.v,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: 8.h,
                );
              },
              itemCount: 3,
              itemBuilder: (context, index) {
                return const Userprofile5ItemWidget();
              },
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildColumnLifestyle(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.h),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 17.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Life style",
                  style: theme.textTheme.titleLarge,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 3.v,
                    bottom: 4.v,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 1.v),
                        child: Text(
                          "Show all",
                          style: CustomTextStyles
                              .labelLargeAbhayaLibreExtraBoldGreen100,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 4.h),
                        child: CustomIconButton(
                          height: 16.adaptSize,
                          width: 16.adaptSize,
                          padding: EdgeInsets.all(1.h),
                          child: CustomImageView(
                            imagePath: ImageConstant.imgVector,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 15.v),
          SizedBox(
            height: 270.v,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: 8.h,
                );
              },
              itemCount: 3,
              itemBuilder: (context, index) {
                return const Userprofile6ItemWidget();
              },
            ),
          )
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildRowCultureSociety(
    BuildContext context, {
    required String title,
    required String showAll,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleLarge!.copyWith(
            color: theme.colorScheme.onError.withOpacity(1),
          ),
        ),
        const Spacer(),
        Padding(
          padding: EdgeInsets.only(
            top: 3.v,
            bottom: 5.v,
          ),
          child: Text(
            showAll,
            style: CustomTextStyles.labelLargeAbhayaLibreExtraBoldGreen100
                .copyWith(
              color: appTheme.green100,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 4.h,
            top: 3.v,
            bottom: 4.v,
          ),
          child: CustomIconButton(
            height: 16.adaptSize,
            width: 16.adaptSize,
            padding: EdgeInsets.all(1.h),
            child: CustomImageView(
              imagePath: ImageConstant.imgVector,
            ),
          ),
        )
      ],
    );
  }
}
