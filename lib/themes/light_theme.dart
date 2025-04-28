import 'package:flutter/material.dart';

// 주요 색상 정의
const Color backgroundColor = Color(0xFFE5E5E5);
const Color textColor = Color(0xFF252424);
const Color primaryColor = Color(0xFF007AFF);
const Color secondPrimaryColor = Color(0xFFBCDCFF); // Second Primary Color
const Color accentColor1 = Color(0xFFFF6D00); // 따뜻한 오렌지 러닝 컬러
const Color accentColor2 = Color(0xFF00BFA6); // 맑은 민트 농구 컬러
const Color accentColor3 = Color(0xFF7557FB); // 맑은 보라색 풋살 컬러
const Color negativeColor = Color(0xFFFF3B30); // 부정적/삭제 버튼용 레드
const Color placeholderColor = Color(0xFFB0B0B0); // 입력 힌트/플레이스홀더용 그레이
const Color strokeColor = Color(0xFFCCCCCC); // 텍스트 필드 스트로크용 연한 그레이

// 테마 정의
final ThemeData appTheme = ThemeData(
  // 스캐폴드 배경 색상
  scaffoldBackgroundColor: backgroundColor,

  // 기본 색상
  primaryColor: primaryColor,

  // 입력 장식 테마
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(color: placeholderColor),
    labelStyle: TextStyle(color: textColor),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: strokeColor),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: primaryColor, width: 2.0),
    ),
    errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: negativeColor),
    ),
    focusedErrorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: negativeColor, width: 2.0),
    ),
  ),

  // 컬러 스킴 (background/onBackground deprecated)
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: primaryColor,
    onPrimary: Colors.white,
    secondary: accentColor1,
    onSecondary: Colors.white,
    surface: Colors.white,
    onSurface: textColor,
    error: negativeColor,
    onError: Colors.white,
    tertiary: secondPrimaryColor,
  ),

  // 텍스트 테마
  textTheme: TextTheme(
    displayLarge: TextStyle(color: textColor),
    titleLarge: TextStyle(color: textColor),
    bodyLarge: TextStyle(color: textColor),
    bodyMedium: TextStyle(color: textColor),
  ),

  // 버튼 테마
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
    ),
  ),
  iconTheme: IconThemeData(color: primaryColor),
);

// 부정적 액션 버튼 스타일
final ButtonStyle negativeButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: negativeColor,
  foregroundColor: Colors.white,
);
