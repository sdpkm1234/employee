import 'package:flutter/material.dart';

class AppFontFamily {
  AppFontFamily._();

  static const primary = 'Poppins';
}

class AppTextThemes {
  AppTextThemes._();

  static final primary = const TextTheme(
    bodyLarge: TextStyle(),
    bodyMedium: TextStyle(),
  ).apply(
    bodyColor: AppColors.textPrimary,
    displayColor: AppColors.textPrimary,
    fontFamily: AppFontFamily.primary,
  );
}

class AppTextStyles {
  AppTextStyles._();

  static const splashTextStyle = TextStyle(
    color: AppColors.textSecondary,
    fontSize: AppFontSizes.x48,
    fontWeight: FontWeight.w700,
    height: 0,
  );

  static const appBarTitleStyle = TextStyle(
    color: AppColors.textPrimary,
    fontSize: AppFontSizes.x24,
    fontWeight: FontWeight.w400,
    height: 0,
  );

  static const textFieldInputStyle = TextStyle(
    color: AppColors.blue1,
    fontSize: AppFontSizes.x16,
    fontWeight: FontWeight.w400,
  );

  static const textFieldLabelStyle = TextStyle(
    fontSize: AppFontSizes.x14,
    fontWeight: FontWeight.w400,
    color: AppColors.grey2,
  );

  static const textFieldErrorStyle = TextStyle(
    fontSize: AppFontSizes.x14,
    fontWeight: FontWeight.w400,
    color: AppColors.red,
  );

  static const subTitleStyle = TextStyle(
    color: AppColors.textPrimary,
    fontSize: AppFontSizes.x20,
    fontFamily: AppFontFamily.primary,
    fontWeight: FontWeight.w500,
    height: 0,
  );

  static const dialogTitleStyle = TextStyle(
    color: AppColors.blue1,
    fontSize: AppFontSizes.x14,
    fontFamily: AppFontFamily.primary,
    fontWeight: FontWeight.w600,
    height: 0,
  );

  static const dialogSubTitleStyle = TextStyle(
    color: AppColors.blue1,
    fontSize: AppFontSizes.x14,
    fontFamily: AppFontFamily.primary,
    fontWeight: FontWeight.w400,
    height: 0,
  );

  static const tabBarUnSelectedTextStyle = TextStyle(
    fontSize: AppFontSizes.x16,
    fontFamily: AppFontFamily.primary,
    fontWeight: FontWeight.w500,
  );

  static const tabBarSelectedTextStyle = TextStyle(
    fontSize: AppFontSizes.x16,
    fontFamily: AppFontFamily.primary,
    fontWeight: FontWeight.w600,
  );

  static const pickerTextStyle = TextStyle(
    color: AppColors.black,
    fontSize: AppFontSizes.x14,
    fontWeight: FontWeight.w400,
    fontFamily: AppFontFamily.primary,
    height: 0,
  );
}

class AppBarThemes {
  AppBarThemes._();

  static const primary = AppBarTheme(
      //backgroundColor: AppColors.textSecondary,
      titleTextStyle: AppTextStyles.appBarTitleStyle);
}

class AppThemes {
  AppThemes._();

  static final theme = ThemeData(
    primaryColor: AppColors.primaryBlue,
    fontFamily: AppFontFamily.primary,
    scaffoldBackgroundColor: AppColors.primaryBlue,
    textTheme: AppTextThemes.primary,
    appBarTheme: AppBarThemes.primary,
  );
}

class AppColors {
  AppColors._();

  static const textPrimary = Color(0xFF0B2A3D);

  static const black = Colors.black;

  static const white = Colors.white;

  static const textSecondary = Colors.white;

  static const grey = Colors.grey;

  static const int blackPrimaryValue = 0xFF000000;

  static const MaterialColor primaryBlack = MaterialColor(
    blackPrimaryValue,
    <int, Color>{
      50: Color(0xFF000000),
      100: Color(0xFF000000),
      200: Color(0xFF000000),
      300: Color(0xFF000000),
      400: Color(0xFF000000),
      500: Color(blackPrimaryValue),
      600: Color(0xFF000000),
      700: Color(0xFF000000),
      800: Color(0xFF000000),
      900: Color(0xFF000000),
    },
  );

  static const gradientColor1 = Color(0xFF54B0E4);

  static const gradientColor2 = Color(0xFF0E5D8E);

  static const primaryBlue = Color(0xFF1982C4);

  static const primaryGrey = Color(0xFFA1A1A1);

  static const appBarBlue = Color(0xFF0097DC);

  static const blue1 = Color(0xFF365467);

  static const green = Color(0xFF27A213);

  static const red = Color(0xFFD71D1D);

  static const yellow = Color(0xFFFFAC0A);

  static const grey1 = Color(0xFFD4D4D4);

  static const grey2 = Color(0xFF595959);

  static const blue2 = Color(0xFF0076AE);

  static const blue3 = Color(0xFFE4F6FF);

  static const grey3 = Color(0xFFF0F0F0);

  static const lightWhite = Color(0xFFF3F3F3);

  static const grey4 = Color(0xFFF0F0F0);

  static const grey5 = Color(0xFFD4DBE3);

  static const black2 = Color(0xFF3F3F3F);

  static const blue4 = Color(0xFFBBCBD8);

  static const blue5 = Color(0xFF1982C4);

  static const green1 = Color(0xFFE8FFE4);

  static const white1 = Color(0xFFFFFFff);

  static const orange = Color(0xFFFFF2DA);

  static const red1 = Color(0xFFFFE5E5);

  static const green2 = Color(0xFF31CFAB);

  static const grey6 = Color(0xFFe0e6eb);

  static const grey7 = Color(0xFF949494);

  static const grey8 = Color(0xFFF1F1F1);

  static const blue6 = Color(0xFFD9EEFB);

  static const yellow1 = Color(0xFFF89C5D);

  static const bgBlue = Color(0xFFE4F5FF);

  static const bgCancel = Color(0xFFEDF8FF);

  static const bgSave = Color(0xFF1DA1F2);
}

class AppFontSizes {
  AppFontSizes._();

  static const x8 = 8.0;

  static const x12 = 12.0;

  static const x13 = 13.0;

  static const x14 = 14.0;

  static const x15 = 15.0;

  static const x16 = 16.0;

  static const x17 = 17.0;

  static const x18 = 18.0;

  static const x20 = 20.0;

  static const x24 = 24.0;

  static const x32 = 32.0;

  static const x48 = 48.0;
}

class AppPaddings {
  AppPaddings._();

  // TODO

  static const p2 = 2.0;

  static const p4 = 4.0;

  static const p6 = 6.0;

  static const p8 = 8.0;

  static const p10 = 10.0;

  static const p12 = 12.0;

  static const p14 = 14.0;

  static const p16 = 16.0;

  static const p20 = 20.0;

  static const p24 = 24.0;

  static const p32 = 32.0;

  static const p48 = 48.0;

  static const p94 = 94.0;

  static const p200 = 200.0;
}

class AppRadii {
  AppRadii._();

  static const xxxSmall = 2.0;

  static const r16 = 16.0;

  static const r32 = 32.0;

  static const r38 = 38.0;
}

class AppHeight {
  AppHeight._();

  static const x8 = 8.0;

  static const x16 = 16.0;

  static const x20 = 20.0;

  static const x24 = 24.0;

  static const x30 = 30.0;

  static const x38 = 38.0;

  static const x45 = 45.0;

  static const x50 = 50.0;

  static const x200 = 250.0;

  static const x400 = 415.0;
}

class AppShadows {
  AppShadows._();
}

class AppThickness {
  AppThickness._();

  static const thickness = .9;
}

class AppGradient {
  AppGradient._();

  static const gradient1 = LinearGradient(
    colors: [AppColors.gradientColor1, AppColors.gradientColor2],
    begin: Alignment(0.00, -1.00),
    end: Alignment(0, 1),
  );

  static const gradient2 = LinearGradient(
    colors: [AppColors.gradientColor1, AppColors.gradientColor1],
    begin: Alignment(0.00, -1.00),
    end: Alignment(0, 1),
  );
}

class AppDecorations {
  AppDecorations._();

  static ShapeDecoration containerDecoration = ShapeDecoration(
    color: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18),
    ),
    shadows: const [
      BoxShadow(
        color: Color(0x3F000000),
        blurRadius: 30,
        offset: Offset(0, 4),
        spreadRadius: 0,
      ),
    ],
  );
}
