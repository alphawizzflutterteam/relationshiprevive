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
