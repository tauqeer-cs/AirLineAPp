import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/gradient_rect_slider_track_shape.dart';
import 'theme.dart';

class Styles {
  static Color get kPrimaryColor => const Color.fromRGBO(227, 30, 51, 1);

  static Color get kActiveColor => const Color.fromRGBO(227, 30, 51, 1);

  static Color get kDisabledButton => const Color(0xFF555555);

  static Color get kLightBgColor => const Color(0xFFFFFFFF);

  static Color get kDarkBgColor => const Color(0xFF3A3A3A);

  static Color get underlineColor => const Color(0xFFD8D8DE);

  static Color get kBorderColor => const Color(0xFF94959E);

  static Color get kContainerColor => const Color(0xC5EEEEEE);

  static Color get kTextLightThemeColor => const Color(0xFF4B4B4B);

  static Color get kDarkContainerColor => const Color(0xFF232F3D);

  static Color get kCanvasColor => const Color(0xFFF2F2F3);
  static Color get kTextColor => const Color(0xFF2b2d42);

  static LinearGradient get gradient => LinearGradient(colors: const <Color>[
        Color(0xFF02C2F3),
        Color(0xFF10C7E9),
        Color(0xFF2AD0D8),
        Color(0xFF3CD6CD),
        Color(0xFF53DFBD),
        Color(0xFF66E7B1),
        Color(0xFF74EAA8),
        Color(0xFF7BEDA2),
      ]);

  static ThemeData theme(bool isLight) {
    return ThemeData(
      colorSchemeSeed: kPrimaryColor,
      canvasColor: isLight ? Colors.white : kTextLightThemeColor,
      cardColor: isLight ? Colors.white : kTextLightThemeColor,
      appBarTheme: AppBarTheme(
        backgroundColor: isLight ? kLightBgColor : kDarkBgColor,
        elevation: 5,
        titleTextStyle: kHugeSemiBold.copyWith(
          color: isLight ? kTextColor : Colors.white,
        ),
        centerTitle: true,
        titleSpacing: 3,
        iconTheme: IconThemeData(
          color: isLight ? kTextColor : Colors.white,
        ),
      ),
      iconTheme: IconThemeData(
        color: isLight ? kTextColor : Colors.white,
        size: 20,
      ),
      listTileTheme: ListTileThemeData(
        iconColor: isLight ? kTextColor : Colors.white,
      ),
      scaffoldBackgroundColor: isLight ? Colors.white : kDarkBgColor,
      scrollbarTheme: ScrollbarThemeData(),
      sliderTheme: SliderThemeData(
        trackShape: GradientRectSliderTrackShape(
          gradient: gradient,
          darkenInactive: true,
        ),
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
        inactiveTrackColor: Colors.grey,
        thumbColor: kTextColor,
        trackHeight: 5,
        overlayShape: SliderComponentShape.noOverlay,
        disabledInactiveTrackColor: Colors.grey,
      ),
      toggleableActiveColor: kPrimaryColor,

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return kActiveColor.withOpacity(0.5);
              } else if (states.contains(MaterialState.disabled)) {
                return kActiveColor.withOpacity(0.7);
              }
              return kActiveColor; // Use the component's default./ Use the component's default.
            },
          ),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return isLight ? Colors.white : Colors.white;
              } else if (states.contains(MaterialState.disabled)) {
                return Colors.white.withOpacity(0.7);
              }
              return isLight
                  ? Colors.white
                  : Colors
                      .white; // Use the component's default./ Use the component's default.
            },
          ),
          minimumSize: MaterialStateProperty.all(Size(500.w, 45.h)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: BorderSide(color: kPrimaryColor)
            ),
          ),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          side: MaterialStateProperty.resolveWith<BorderSide>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return  BorderSide(
                  color: kPrimaryColor,
                  width: 1.0,
                  style: BorderStyle.solid,
                );
              } else if (states.contains(MaterialState.disabled)) {
                return const BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                  style: BorderStyle.solid,
                );
              }
              return BorderSide(
                color: kPrimaryColor,
                width: 1.0,
                style: BorderStyle.solid,
              ); // Use the component's default./ Use the component's default.
            },
          ),
          textStyle: MaterialStateProperty.all(kLargeSemiBold),
          minimumSize: MaterialStateProperty.all(Size(100, 48.h)),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return isLight ?kPrimaryColor : Colors.white;
              } else if (states.contains(MaterialState.disabled)) {
                return kPrimaryColor.withOpacity(0.5);
              }
              return isLight
                  ? kPrimaryColor
                  : Colors
                      .white; // Use the component's default./ Use the component's default.
            },
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: BorderSide(
                width: 1,
                color: kBorderColor,
              ),
            ),
          ),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          ),
          elevation: MaterialStateProperty.all(0),
        ),
      ),
      shadowColor: const Color(0xFF696868),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: kPrimaryColor,
        selectionColor: kPrimaryColor,
        selectionHandleColor: kPrimaryColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        isDense: false,
        errorMaxLines: 2,
        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        border: OutlineInputBorder(
          borderSide:  BorderSide(color: kDarkContainerColor),
          borderRadius: BorderRadius.circular(5),
        ),
        prefixIconColor: isLight ? kTextColor : Colors.white,
        suffixIconColor: isLight ? kTextColor : Colors.white,
        enabledBorder: OutlineInputBorder(
          borderSide:  BorderSide(color: kDarkContainerColor),
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:  BorderSide(color: kDarkContainerColor),
          borderRadius: BorderRadius.circular(5),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(5),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color:  kDarkContainerColor.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(5),
        ),
        filled: false,
        labelStyle: kSmallSemiBold.copyWith(
          color: isLight ?kTextColor : kLightBgColor,
        ),
        errorStyle: kSmallSemiBold.copyWith(
          color: isLight ? Colors.red : kLightBgColor,
        ),
        hintStyle: kSmallSemiBold.copyWith(
          color: isLight
              ? kTextColor.withOpacity(0.5)
              : kLightBgColor.withOpacity(0.5),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        materialTapTargetSize: MaterialTapTargetSize.padded,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(const Size(100, 50)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return kActiveColor.withOpacity(0.5);
              } else if (states.contains(MaterialState.disabled)) {
                return kDisabledButton;
              }
              return kPrimaryColor; // Use the component's default./ Use the component's default.
            },
          ),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: isLight ? Colors.white : kDarkBgColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(12),
          ),
        ),
        elevation: 3
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: isLight ? Colors.white : Colors.white,
        selectedItemColor: isLight ? kPrimaryColor : Colors.white,
        selectedLabelStyle: const TextStyle(
          color: Colors.red,
        ),
        unselectedLabelStyle: TextStyle(
          color: kBorderColor,
        ),
        unselectedItemColor: kBorderColor,
      ),
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0,
        padding: const EdgeInsets.all(5),
        labelPadding: const EdgeInsets.all(2),
        backgroundColor: kDisabledButton,
        shadowColor: kTextColor,
        labelStyle: kMediumSemiBold.copyWith(color: Colors.white),
      ),
      tabBarTheme: TabBarTheme(
        labelColor: kTextLightThemeColor,
        unselectedLabelColor: kTextLightThemeColor,
        labelStyle: kMediumHeavy.copyWith(
          color: kTextLightThemeColor,
        ),
        unselectedLabelStyle: kMediumHeavy.copyWith(
          color: kTextLightThemeColor,
        ),
      ),
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        color: isLight ? Colors.white : kTextColor.withOpacity(0.6),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.selected)) {
              return kPrimaryColor;
            }
            return kPrimaryColor;
          },
        ),
      ),
      textTheme: TextTheme(
        displayLarge: const TextStyle(
          fontSize: 80,
          color: Colors.white,
        ),
        titleMedium: kMediumMedium.copyWith(
          color: isLight ? kTextColor : kLightBgColor,
        ),
        bodyLarge: kHugeMedium.copyWith(
          color: isLight ? kTextColor : kLightBgColor,
        ),
        bodyMedium: kMediumMedium.copyWith(
          color: isLight ? kTextColor : kLightBgColor,
        ),
        bodySmall: kSmallMedium.copyWith(
          color: isLight ? kTextColor : kLightBgColor,
        ),
      ).apply(
        bodyColor: isLight ? kTextColor : kLightBgColor,
        displayColor: isLight ? kTextColor : kLightBgColor,
      ),
    );
  }
}
