import 'package:flutter/material.dart';
import '../core/app_export.dart';

String _appTheme = "primary";
PrimaryColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();

/// Helper class for managing themes and colors.
// ignore_for_file: must_be_immutable

class ThemeHelper {
  // A map of custom color themes supported by the app
  final Map<String, PrimaryColors> _supportedCustomColor = {
    'primary': PrimaryColors()
  };

// A map of color schemes supported by the app
  final Map<String, ColorScheme> _supportedColorScheme = {
    'primary': ColorSchemes.primaryColorScheme
  };

  /// Changes the app theme to [newTheme].
  void changeTheme(String newTheme) {
    _appTheme = newTheme;
  }

  /// Returns the primary colors for the current theme.
  PrimaryColors _getThemeColors() {
    return _supportedCustomColor[_appTheme] ?? PrimaryColors();
  }

  /// Returns the current theme data.
  ThemeData _getThemeData() {
    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.primaryColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      textTheme: TextThemes.textTheme(colorScheme),
      scaffoldBackgroundColor: colorScheme.onSecondaryContainer,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      dividerTheme: DividerThemeData(
        thickness: 1,
        space: 1,
        color: colorScheme.primaryContainer.withOpacity(1),
      ),
    );
  }

  /// Returns the primary colors for the current theme.
  PrimaryColors themeColor() => _getThemeColors();

  /// Returns the current theme data.
  ThemeData themeData() => _getThemeData();
}

/// Class containing the supported text theme styles.
class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
        headlineLarge: TextStyle(
          color: appTheme.blueGray50,
          fontSize: 32.fSize,
          fontFamily: 'Abhaya Libre ExtraBold',
          fontWeight: FontWeight.w800,
        ),
        titleSmall: TextStyle(
          color: colorScheme.secondaryContainer,
          fontSize: 14.fSize,
          fontFamily: 'Abhaya Libre ExtraBold',
          fontWeight: FontWeight.w800,
        ),

        // headlineLarge: TextStyle(
        //   color: colorScheme.primary,
        //   fontSize: 32.fSize,
        //   fontFamily: 'Abhaya Libre ExtraBold',
        //   fontWeight: FontWeight.w800,
        // ),
        headlineSmall: TextStyle(
          color: colorScheme.onError.withOpacity(1),
          fontSize: 24.fSize,
          fontFamily: 'Abhaya Libre ExtraBold',
          fontWeight: FontWeight.w800,
        ),
        labelLarge: TextStyle(
          color: colorScheme.primary,
          fontSize: 12.fSize,
          fontFamily: 'Alegreya Sans',
          fontWeight: FontWeight.w500,
        ),
        labelMedium: TextStyle(
          color: appTheme.gray400,
          fontSize: 10.fSize,
          fontFamily: 'Abhaya Libre ExtraBold',
          fontWeight: FontWeight.w800,
        ),
        titleLarge: TextStyle(
          color: colorScheme.onError.withOpacity(1),
          fontSize: 20.fSize,
          fontFamily: 'Abhaya Libre ExtraBold',
          fontWeight: FontWeight.w800,
        ),
        titleMedium: TextStyle(
          color: colorScheme.onError.withOpacity(1),
          fontSize: 16.fSize,
          fontFamily: 'Abhaya Libre ExtraBold',
          fontWeight: FontWeight.w800,
        ),
        // titleSmall: TextStyle(
        //   color: colorScheme.primary,
        //   fontSize: 14.fSize,
        //   fontFamily: 'Abhaya Libre ExtraBold',
        //   fontWeight: FontWeight.w800,
        // ),

        // headlineSmall: TextStyle(
        //   color: appTheme.blueGray50,
        //   fontSize: 24.fSize,
        //   fontFamily: 'Alegreya Sans',
        //   fontWeight: FontWeight.w500,
        // ),
        // labelLarge: TextStyle(
        //   color: appTheme.blueGray50,
        //   fontSize: 12.fSize,
        //   fontFamily: 'Alegreya Sans',
        //   fontWeight: FontWeight.w500,
        // ),
        // labelMedium: TextStyle(
        //   color: colorScheme.secondaryContainer.withOpacity(1),
        //   fontSize: 10.fSize,
        //   fontFamily: 'Abhaya Libre ExtraBold',
        //   fontWeight: FontWeight.w800,
        // ),
        labelSmall: TextStyle(
          color: appTheme.blueGray50,
          fontSize: 8.fSize,
          fontFamily: 'Alegreya Sans',
          fontWeight: FontWeight.w500,
        ),
        // titleLarge: TextStyle(
        //   color: colorScheme.onPrimaryContainer.withOpacity(1),
        //   fontSize: 20.fSize,
        //   fontFamily: 'Abhaya Libre ExtraBold',
        //   fontWeight: FontWeight.w800,
        // ),
        // titleMedium: TextStyle(
        //   color: appTheme.blueGray50,
        //   fontSize: 16.fSize,
        //   fontFamily: 'Alegreya Sans',
        //   fontWeight: FontWeight.w500,
        // ),
        // titleSmall: TextStyle(
        //   color: appTheme.blueGray50,
        //   fontSize: 14.fSize,
        //   fontFamily: 'Abhaya Libre ExtraBold',
        //   fontWeight: FontWeight.w800,
        // ),
      );

  static TextTheme textTheme_1(ColorScheme colorScheme) => TextTheme(
        headlineLarge: TextStyle(
          color: colorScheme.primary,
          fontSize: 32.fSize,
          fontFamily: 'Abhaya Libre ExtraBold',
          fontWeight: FontWeight.w800,
        ),
        headlineSmall: TextStyle(
          color: colorScheme.onError.withOpacity(1),
          fontSize: 24.fSize,
          fontFamily: 'Abhaya Libre ExtraBold',
          fontWeight: FontWeight.w800,
        ),
        labelLarge: TextStyle(
          color: colorScheme.primary,
          fontSize: 12.fSize,
          fontFamily: 'Alegreya Sans',
          fontWeight: FontWeight.w500,
        ),
        labelMedium: TextStyle(
          color: appTheme.gray400,
          fontSize: 10.fSize,
          fontFamily: 'Abhaya Libre ExtraBold',
          fontWeight: FontWeight.w800,
        ),
        titleLarge: TextStyle(
          color: colorScheme.onError.withOpacity(1),
          fontSize: 20.fSize,
          fontFamily: 'Abhaya Libre ExtraBold',
          fontWeight: FontWeight.w800,
        ),
        titleMedium: TextStyle(
          color: colorScheme.onError.withOpacity(1),
          fontSize: 16.fSize,
          fontFamily: 'Abhaya Libre ExtraBold',
          fontWeight: FontWeight.w800,
        ),
        titleSmall: TextStyle(
          color: colorScheme.primary,
          fontSize: 14.fSize,
          fontFamily: 'Abhaya Libre ExtraBold',
          fontWeight: FontWeight.w800,
        ),
      );
}

/// Class containing the supported color schemes.
class ColorSchemes {
  static const primaryColorScheme = ColorScheme.light(
    primary: Color(0XFFCDE7BE),
    primaryContainer: Color(0X7F303333),
    secondaryContainer: Color(0XFF929999),
    onPrimary: Color(0XFF232538),
    onPrimaryContainer: Color(0XFF000000),
    onSecondaryContainer: Color(0XFF181919),
    //primaryContainer: Color(0XFF616666),
    onError: Color(0X1EFFFFFF),
    //onSecondaryContainer: Color(0XFF929999),
    errorContainer: Color(0XFF616666),
    onErrorContainer: Color(0X99181919),
    //onPrimaryContainer: Color(0X1EFFFFFF),
  );
}

class ColorSchemes1 {
  static const lightCodeColorScheme = ColorScheme.light(
    primary: Color(0XFFEAF4F4),
    primaryContainer: Color(0XFF616666),
    onError: Color(0X1EFFFFFF),
    onPrimary: Color(0X7F303333),
    onPrimaryContainer: Color(0X99181919),
    onSecondaryContainer: Color(0XFF929999),
  );
}

/// Class containing custom colors for a primary theme.
class PrimaryColors {
  // Black
  Color get black900 => const Color(0XFF000000);
  // Blue
  Color get blueA400 => const Color(0XFF1877F2);
// BlueGray
  Color get blueGray400 => const Color(0XFF888888);
  Color get blueGray50 => const Color(0XFFEAF4F4);
  Color get blueGray900 => const Color(0XFF232538);
// Gray
  Color get gray700 => const Color(0XFF616666);
  Color get gray400 => const Color(0XFFC3CCCC);
  Color get gray900 => const Color(0XFF1D201C);
// White
  Color get whiteA700 => const Color(0XFFFFFFFF);
  // Green
  Color get green100 => const Color(0XFFCDE7BE);
}
