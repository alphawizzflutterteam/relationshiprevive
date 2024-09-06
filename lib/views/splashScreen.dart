// ignore_for_file: must_be_immutable

import 'package:AstroGuru/controllers/splashController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/life_cycle_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);
  SplashController splashController =
      Get.put(SplashController()); //Get.find<SplashController>();
  HomeCheckController homeCheckController = Get.put(HomeCheckController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/splash.png',
              height: 200,
              width: 200,
            ),
            /*CircleAvatar(
              backgroundColor: Get.theme.primaryColor,
              radius: 100,
              backgroundImage: AssetImage('assets/images/splash.png'),
            ),*/
            const SizedBox(
              height: 30,
            ),
            GetBuilder<SplashController>(builder: (s) {
              return splashController.appName == ''
                  ? const CircularProgressIndicator()
                  : Text(
                      // splashController.appName,
                "Revive, Rekindle, Reconnect Nurturing Stronger Bonds, Together."
                ,
                      style: Get.textTheme.headlineSmall,textAlign: TextAlign.center,
                    );
            })
          ],
        ),
      ),
    );
  }
}
