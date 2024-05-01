import 'package:flutter/material.dart';
import '../core/app_export.dart';

class AppDecoration {
  // Black decorations
  static BoxDecoration get black => BoxDecoration(
        color: theme.colorScheme.onSecondaryContainer,
      );
  // static BoxDecoration get black => BoxDecoration(
  //       color: theme.colorScheme.onSecondaryContainer,
  //     );
  // static BoxDecoration get black => BoxDecoration(
  //       color: theme.colorScheme.onErrorContainer.withOpacity(1),
  //     );

// Fill decorations
  static BoxDecoration get fillPrimaryContainer => BoxDecoration(
        color: theme.colorScheme.primaryContainer,
      );
  static BoxDecoration get fillWhiteA => BoxDecoration(
        color: appTheme.whiteA700,
      );

  static BoxDecoration get fillBlueGray => BoxDecoration(
        color: appTheme.blueGray900,
      );
  static BoxDecoration get fillGray => BoxDecoration(
        color: appTheme.gray400,
      );
  static BoxDecoration get fillGreen => BoxDecoration(
        color: appTheme.green100,
      );
  static BoxDecoration get fillOnError => BoxDecoration(
        color: theme.colorScheme.onError,
      );
  static BoxDecoration get fillOnError1 => BoxDecoration(
        color: theme.colorScheme.onError.withOpacity(1),
      );
  static BoxDecoration get fillOnPrimary => BoxDecoration(
        color: theme.colorScheme.onPrimary,
      );
  static BoxDecoration get fillErrorContainer => BoxDecoration(
        color: theme.colorScheme.errorContainer,
      );
  static BoxDecoration get fillOnPrimaryContainer => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer,
      );
  static BoxDecoration get fillOnPrimaryContainer1 => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
      );
  static BoxDecoration get fillOnSecondaryContainer => BoxDecoration(
        color: theme.colorScheme.onSecondaryContainer,
      );
// White decorations
  static BoxDecoration get white => BoxDecoration(
        color: appTheme.blueGray50,
      );
// Gradient decorations
  static BoxDecoration get gradientGrayToOnPrimaryContainer => BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0.5, 0),
          end: const Alignment(0.5, 0.55),
          colors: [
            appTheme.gray900,
            theme.colorScheme.onPrimaryContainer.withOpacity(1)
          ],
        ),
      );
  static BoxDecoration get gradientOnPrimaryContainerToOnPrimaryContainer =>
      BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0.5, 0),
          end: const Alignment(0.5, 1),
          colors: [
            theme.colorScheme.onPrimaryContainer.withOpacity(0),
            theme.colorScheme.onPrimaryContainer,
            theme.colorScheme.onPrimaryContainer.withOpacity(1)
          ],
        ),
      );
  static BoxDecoration get gradientGrayToOnErrorContainer => BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0.5, 0),
          end: const Alignment(0.5, 0.55),
          colors: [
            appTheme.gray900,
            theme.colorScheme.onErrorContainer.withOpacity(1)
          ],
        ),
      );
  static BoxDecoration get gradientOnErrorContainerToOnErrorContainer =>
      BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0.5, 0),
          end: const Alignment(0.5, 1),
          colors: [
            theme.colorScheme.onErrorContainer.withOpacity(0),
            theme.colorScheme.onErrorContainer,
            theme.colorScheme.onErrorContainer.withOpacity(1)
          ],
        ),
      );
// Outline decorations
  static BoxDecoration get outlineOnPrimary => BoxDecoration(
        border: Border.all(
          color: theme.colorScheme.onPrimary.withOpacity(1),
          width: 1.h,
        ),
      );
}

class BorderRadiusStyle {
  // Circle borders
  static BorderRadius get circleBorder27 => BorderRadius.circular(
        27.h,
      );
  static BorderRadius get circleBorder35 => BorderRadius.circular(
        35.h,
      );
  static BorderRadius get circleBorder45 => BorderRadius.circular(
        45.h,
      );
  // Rounded borders
  static BorderRadius get roundedBorder12 => BorderRadius.circular(
        12.h,
      );
  static BorderRadius get roundedBorder52 => BorderRadius.circular(
        52.h,
      );
  static BorderRadius get roundedBorder8 => BorderRadius.circular(
        8.h,
      );
  static BorderRadius get roundedBorder20 => BorderRadius.circular(
        20.h,
      );
}
