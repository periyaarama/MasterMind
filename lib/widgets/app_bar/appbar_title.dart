import 'package:flutter/material.dart';
import '../../core/app_export.dart';

// ignore_for_file: must_be_immutable
class AppbarTitle extends StatelessWidget {
  AppbarTitle({super.key, required this.text, this.margin, this.onTap});

  String text;

  EdgeInsetsGeometry? margin;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: Text(
          text,
          style: theme.textTheme.headlineLarge!.copyWith(
            color: appTheme.blueGray50,
          ),
          // style: theme.textTheme.headlineSmall!.copyWith(
          //   color: theme.colorScheme.onError.withOpacity(1),
          // ),
        ),
      ),
    );
  }
}
