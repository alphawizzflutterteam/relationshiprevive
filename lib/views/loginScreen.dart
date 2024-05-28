import 'package:AstroGuru/controllers/bottomNavigationController.dart';
import 'package:AstroGuru/controllers/homeController.dart';
import 'package:AstroGuru/controllers/loginController.dart';
import 'package:AstroGuru/controllers/search_controller.dart';
import 'package:AstroGuru/controllers/themeController.dart';
import 'package:AstroGuru/views/bottomNavigationBarScreen.dart';
import 'package:AstroGuru/views/settings/privacyPolicyScreen.dart';
import 'package:AstroGuru/views/settings/termsAndConditionScreen.dart';
import 'package:AstroGuru/views/signup_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:AstroGuru/utils/global.dart' as global;
import 'package:google_translator/google_translator.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final LoginController loginController = Get.find<LoginController>();
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Get.back();
        Get.back();
        print('call on will pop');
        SystemNavigator.pop();
        //exit(0);
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            height: double.maxFinite,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [
                      0.2,
                      0.5,
                      0.8,
                      0.9
                    ],
                    colors: [Theme.of(context).primaryColor,  Theme.of(context).primaryColorLight, Theme.of(context).primaryColor,Theme.of(context).primaryColorLight
                    ])),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(height: 20,),
                      SizedBox(
                        height: 40,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {
                              Get.find<SearchController1>()
                                  .serachTextController
                                  .clear();
                              Get.find<SearchController1>().searchText = '';
                              homeController.myOrders.clear();
                              BottomNavigationController
                              bottomNavigationController =
                              Get.find<BottomNavigationController>();
                              bottomNavigationController.setIndex(0, 0);
                              Get.off(
                                      () => BottomNavigationBarScreen(index: 0));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                "Skip",
                                textAlign: TextAlign.end,
                                style: Get.textTheme.subtitle1!.copyWith(
                                    color: Colors.black,
                                    decoration: TextDecoration.underline),
                              ).translate(),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: Image.asset(
                          'assets/images/splash.png',
                          width: 100,
                          height: 100,
                        ),
                      ),
                      /*CircleAvatar(
                          backgroundColor: Get.theme.primaryColor,
                          radius: 60,
                          backgroundImage: AssetImage('assets/images/splash.png'),
                        ),*/
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        '${global.getSystemFlagValueForLogin(global.systemFlagNameList.appName)}',
                        style: Get.textTheme.headline5,
                      ).translate(),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                  SizedBox(height: Get.height * 0.02,),
                  GetBuilder<LoginController>(
                      builder: (loginController) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Card(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(8.0, 0, 8, 0),
                                  child: Container(
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                          child: FutureBuilder(
                                              future: global.translatedText(
                                                  "Phone Number"),
                                              builder: (context, snapshot) {
                                                return IntlPhoneField(
                                                  autovalidateMode: null,
                                                  showDropdownIcon: false,
                                                  controller: loginController
                                                      .phoneController,
                                                  decoration: InputDecoration(
                                                    //labelText: 'Phone Number',
                                                      contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          vertical: 5,
                                                          horizontal: 10),
                                                      hintText:
                                                      snapshot.data ??
                                                          'Phone Number',
                                                      border:
                                                      const OutlineInputBorder(
                                                        borderSide:
                                                        BorderSide.none,
                                                      ),
                                                      enabledBorder:
                                                      const OutlineInputBorder(
                                                        borderSide:
                                                        BorderSide.none,
                                                      ),
                                                      disabledBorder:
                                                      const OutlineInputBorder(
                                                        borderSide:
                                                        BorderSide.none,
                                                      ),
                                                      focusedBorder:
                                                      const OutlineInputBorder(
                                                        borderSide:
                                                        BorderSide.none,
                                                      ),
                                                      errorBorder:
                                                      const OutlineInputBorder(
                                                        borderSide:
                                                        BorderSide.none,
                                                      ),
                                                      errorText: null,
                                                      counterText: ''),
                                                  initialCountryCode: 'IN',
                                                  onChanged: (phone) {
                                                    //print(phone.completeNumber);
                                                    loginController
                                                        .updateCountryCode(
                                                        phone
                                                            .countryCode);
                                                  },
                                                );
                                              })),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      8.0, 0, 8, 0),
                                  child: Container(
                                    height: 45,
                                    width: double.infinity,
                                    margin: EdgeInsets.only(top: 20),
                                    decoration: BoxDecoration(
                                      gradient: gradient.btnGradient,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    child: TextButton(onPressed: () async{
                                      bool isValid =
                                      loginController.validedPhone();
                                      if (isValid) {
                                        global.showOnlyLoaderDialog(context);
                                        await loginController
                                            .loginAndSignupUser(int.parse(
                                            loginController
                                                .phoneController.text));
                                        //await loginController.verifyOTP();
                                      } else {
                                        global.showToast(
                                          message: loginController.errorText!,
                                          textColor: global.textColor,
                                          bgColor: global.toastBackGoundColor,
                                        );
                                      }

                                    },child: Row(
                                     // mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'SEND OTP',
                                          style: TextStyle(
                                              color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ).translate(),
                                        Image.asset(
                                          'assets/images/arrow_left.png',
                                          color: Colors.white,
                                          width: 20,
                                        )
                                      ],
                                    ),),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10,
                                      left: 10,
                                      right: 10,
                                      bottom: 5),
                                  child: SizedBox(
                                    child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'By signing up, you agree to our ',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 11),
                                          ).translate(),
                                        ]),
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(
                                                () => TermAndConditionScreen());
                                      },
                                      child: Text(
                                        'Terms of use',
                                        style: TextStyle(
                                            decoration:
                                            TextDecoration.underline,
                                            fontSize: 11,
                                            color: Colors.blue),
                                      ).translate(),
                                    ),
                                    Text(' and ',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 11))
                                        .translate(),
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(() => PrivacyPolicyScreen());
                                      },
                                      child: Text(
                                        ' Privacy',
                                        style: TextStyle(
                                            decoration:
                                            TextDecoration.underline,
                                            fontSize: 11,
                                            color: Colors.blue),
                                      ).translate(),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(() => PrivacyPolicyScreen());
                                      },
                                      child: Text(
                                        'Policy',
                                        style: TextStyle(
                                          decoration:
                                          TextDecoration.underline,
                                          fontSize: 11,
                                          color: Colors.blue,
                                        ),
                                      ).translate(),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                SizedBox(height: 50,),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10,
                                      left: 10,
                                      right: 10,
                                      bottom: 5),
                                  child: SizedBox(
                                    child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            " Don't have account ? ",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Get.to(
                                                      () => RegisterUserScreen());
                                            },
                                            child: Text(
                                              'Signup',
                                              style: TextStyle(
                                                  decoration:
                                                  TextDecoration.underline,
                                                  fontSize: 14,
                                                  color: Colors.blue),
                                            ),
                                          )
                                        ]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
