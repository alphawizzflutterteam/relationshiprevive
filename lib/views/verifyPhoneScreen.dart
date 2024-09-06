import 'dart:io';

import 'package:AstroGuru/constants/colors.dart';
import 'package:AstroGuru/controllers/loginController.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:AstroGuru/utils/global.dart' as global;
import 'package:google_translator/google_translator.dart';

class VerifyPhoneScreen extends StatelessWidget {
  final String phoneNumber;
  final String verificationId;
  final String otp;
  bool? fromSignup;
  VerifyPhoneScreen(
      {Key? key,
      required this.phoneNumber,
      required this.verificationId,
      required this.otp,
      this.fromSignup})
      : super(key: key);
  final LoginController loginController = Get.find<LoginController>();
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   elevation: 1,
        //   backgroundColor:  Color(0xFFB7D7CF),
        //   title: Text(
        //     'Verify It\'s You',
        //     style: Get.textTheme.subtitle1,
        //   ),
        //   leading: IconButton(
        //       onPressed: () {
        //         Get.delete<LoginController>(force: true);
        //         Get.back();
        //       },
        //       icon: Icon(
        //         Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
        //         color: Colors.black,
        //       )),
        // ),
        body: Container(
          height: double.maxFinite,
          decoration: BoxDecoration(
          gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [
          0.2,
          0.5,
          0.8,
          0.9
          ],
          colors: [
           colors.gradient1,
           colors.gradient2,
           colors.gradient3,
           colors.gradient4,
          //  Theme.of(context).primaryColor,
          // Theme.of(context).primaryColorLight,
          // Theme.of(context).primaryColor,
          // Theme.of(context).primaryColorLight
           ],
          )
          ),
          child: Center(
            child: SizedBox(
              width: Get.width - Get.width * 0.1,
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: Row(
                        children: [
                          GestureDetector(
                              onTap: (){
                                Get.delete<LoginController>(force: true);
                                Get.back();
                              },
                              child: Icon(Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,color: Colors.black,)),
                         SizedBox(width: 10,),
                          Text("Verify It\'s You",style: Get.textTheme.subtitle1,)
                        ],
                      ),
                    ),
                    Text(
                      'OTP Send to ${loginController.countryCode}-$phoneNumber',
                      style: TextStyle(color: Colors.green),
                    ),
                    Text(
                      'OTP: $otp',
                      style: TextStyle(color: Colors.green),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    OtpTextField(
                      numberOfFields: 4,
                      showFieldAsBox: true,
                      onCodeChanged: (value) {},
                      onSubmit: (value) {
                        loginController.smsCode = value;
                        loginController.update();
                        print('smscode from : ${loginController.smsCode}');
                      },
                      filled: true,
                      fillColor: Colors.white,
                      fieldWidth: 48,
                      borderColor: Colors.transparent,
                      enabledBorderColor: Colors.transparent,
                      focusedBorderColor: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      margin: EdgeInsets.only(right: 4),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            /* PhoneAuthCredential credential =
                              PhoneAuthProvider.credential(
                            verificationId: verificationId,
                            smsCode: loginController.smsCode,
                          );*/

                            if (loginController.smsCode == otp) {
                              global.showOnlyLoaderDialog(context);

                              if (fromSignup ?? false) {
                                loginController.userRegister();
                              } else {
                                await loginController
                                    .loginAndSignupUser(int.parse(phoneNumber));
                              }
                            } else {
                              global.showToast(
                                message: "OTP INVALID",
                                textColor: Colors.white,
                                bgColor: Colors.red,
                              );
                            }

                            /*print('validation id${loginController.verificationId}');
                          print('smscode ${loginController.smsCode}');
                          await auth.signInWithCredential(credential);
                          await loginController
                              .loginAndSignupUser(int.parse(phoneNumber));*/
                          } catch (e) {
                            global.hideLoader();

                            global.showToast(
                              message: "OTP INVALID",
                              textColor: Colors.white,
                              bgColor: Colors.red,
                            );
                            print("Exception " + e.toString());
                          }
                        },
                        child: Text(
                          'SUBMIT',
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                          backgroundColor:
                          MaterialStateProperty.all(Get.theme.primaryColor),
                          textStyle: MaterialStateProperty.all(
                              TextStyle(fontSize: 18, color: Colors.black)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GetBuilder<LoginController>(builder: (c) {
                      return SizedBox(
                          child: loginController.maxSecond != 0
                              ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                'Resend OTP Available in ${loginController.maxSecond} s',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          )
                              : Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Resend OTP Available',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.w500),
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        loginController.maxSecond = 60;
                                        loginController.second = 0;
                                        loginController.update();
                                        loginController.timer();
                                        loginController.phoneController.text =
                                            phoneNumber;
                                        loginController.sendOtp();
                                      },
                                      child: Text(
                                        'Resend OTP on SMS',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                          ),
                                        ),
                                        padding: MaterialStateProperty.all(
                                            EdgeInsets.only(
                                                left: 25, right: 25)),
                                        backgroundColor:
                                        MaterialStateProperty.all(
                                            Get.theme.primaryColor),
                                        textStyle: MaterialStateProperty.all(
                                            TextStyle(
                                                fontSize: 12,
                                                color: Colors.black)),
                                      ),
                                    ),
                                  ],
                                ),


                                
                              ]));
                    }),
                   Spacer(),
                    //SizedBox(height: 100,),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text("YOU’RE JUST A CLICK AWAY TO EXPLORE YOUR RELATIONSHIP JOURNEY",
                        style: Get.textTheme.headlineSmall,textAlign: TextAlign.center,),
                    ),
                  ],
                ),
              ),
            ),
          ),

        ),




      ),
    );
  }
}
