import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:AstroGuru/utils/global.dart' as global;
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController implements GetxService {
  ThemeController() {
    _loadCurrentTheme();
  }

  bool _darkTheme = false;
  bool get darkTheme => _darkTheme;
  int pickColorInt = 0xff000000;

  // Color _pickColor = Color(0xffffc107);
  Color _pickColor = Color(0xff209A4B);
  Color get pickColor => _pickColor;

  Color _pickSecondaryColor = Color(0xff11A3C7);
  Color get pickSecondaryColor => _pickSecondaryColor;

  void _loadCurrentTheme() async {
    global.sp = await SharedPreferences.getInstance();
    if (global.sp!.getInt('primaryColor') != null) {
      int? colorVal = global.sp!.getInt('primaryColor');
      _pickColor = Color(colorVal!);
      pickColorInt = colorVal;
    } else {
      //_pickColor = Color(0xffffc107);
      _pickColor = Color(0xff209A4B);
      _pickSecondaryColor = Color(0xff11A3C7);
      pickColorInt = 0xffffc107;
    }

    update();
  }

  void setPickColor(Color color) async {
    _pickColor = color;
    global.sp!.setInt('primaryColor', _pickColor.value);

    String hexString = "0x${color.value.toRadixString(16).padLeft(8, '0')}";
    pickColorInt = int.parse(hexString);
    global.sp!.setInt('primaryColorInt', pickColorInt);
    update();
  }

  void setSecondaryPickColor(Color color) async {
    _pickSecondaryColor = color;
    global.sp!.setInt('secondaryColor', _pickSecondaryColor.value);

    update();
  }
}
class gradient {
  // static const Gradient btnGradient = LinearGradient(
  //   colors: [Color(0xff0c82df), Color(0xff3dc1fd)],
  //   begin: Alignment.bottomCenter,
  //   end: Alignment.topCenter,
  // );
  //Alignment.topLeft,end: Alignment.bottomRight
  static const Gradient btnGradient = LinearGradient(
    colors: [Color(0xff11A3C7),Color(0xff209A4B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const Gradient greenGradient = LinearGradient(
    colors: [Color(0xff5D8231), Color.fromARGB(255, 100, 199, 64)],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  static const Gradient lightGradient = LinearGradient(
    colors: [Color(0xffdaedfd), Color(0xffdaedfd)],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );
  static const Gradient transpharantGradient = LinearGradient(
    colors: [Colors.transparent, Colors.transparent],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );
  static const Color defoultColor = Color(0xFFBF2331);

  static const Gradient appbarGradient = LinearGradient(
    colors: [Color(0xff11A3C7),Color(0xff11A3C7)],
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
    stops: [0,1]
  );
}