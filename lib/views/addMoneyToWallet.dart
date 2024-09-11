import 'dart:io';

import 'package:AstroGuru/constants/colors.dart';
import 'package:AstroGuru/controllers/razorPayController.dart';
import 'package:AstroGuru/controllers/splashController.dart';
import 'package:AstroGuru/controllers/themeController.dart';
import 'package:AstroGuru/controllers/walletController.dart';
import 'package:AstroGuru/model/businessLayer/baseRoute.dart';
import 'package:AstroGuru/utils/global.dart';
import 'package:AstroGuru/views/paymentInformationScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:AstroGuru/utils/global.dart' as global;

import '../widget/commonAppbar.dart';

class AddmoneyToWallet extends BaseRoute {
  AddmoneyToWallet({a, o}) : super(a: a, o: o, r: 'AddMoneyToWallet');
  final WalletController walletController = Get.find<WalletController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: colors.gradient1,
      appBar: PreferredSize(
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                top: 15.0,
              ),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(
                      Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
                      color: Get.theme.iconTheme.color,
                    ),
                  ),
                  Text(
                    'Add money to wallet',
                    style: Get.theme.primaryTextTheme.headline6!
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(right: 10),
                  //   child:
                  //   global.splashController.currentUser?.walletAmount !=
                  //       null
                  //       ? Container(
                  //     padding: EdgeInsets.all(2),
                  //     margin: EdgeInsets.symmetric(
                  //         vertical: 17, horizontal: 20),
                  //     decoration: BoxDecoration(
                  //       border: Border.all(color: Colors.white),
                  //       borderRadius: BorderRadius.circular(5),
                  //     ),
                  //     alignment: Alignment.center,
                  //     child: Text(
                  //       '${global.getSystemFlagValueForLogin(global.systemFlagNameList.currency)}${global.splashController.currentUser?.walletAmount.toString()}',
                  //       style: Get.theme.primaryTextTheme.bodySmall
                  //           ?.copyWith(color: Colors.white),
                  //     ),
                  //   )
                  //       : SizedBox(),
                  // ),
                ],
              )),
          decoration: BoxDecoration(
            gradient: gradient.btnGradient,
          ),
        ),
        preferredSize: Size.fromHeight(70.0),
      ),
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(56),
      //   child: CommonAppBar(
      //     title: 'Add money to wallet',
      //   )),
      body: Container(
        height: double.maxFinite,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          // stops: [
          //   0.2,
          //   0.5,
          //   0.8,
          //   0.9
          // ],
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
        )),
        child: SingleChildScrollView(
          child: GetBuilder<SplashController>(builder: (splash) {
            return Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Available Balance',
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(
                      '${global.getSystemFlagValueForLogin(global.systemFlagNameList.currency)} ${splashController.currentUser!.walletAmount.toString()}',
                      style: Get.textTheme.subtitle1!
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 20)),
                  GetBuilder<WalletController>(builder: (c) {
                    return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 3 / 1.8,
                          crossAxisSpacing: 1,
                          mainAxisSpacing: 1,
                        ),
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.all(8),
                        shrinkWrap: true,
                        itemCount: walletController.paymentAmount.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              // Get.delete<RazorPayController>();
                              // Get.to(() => PaymentInformationScreen(
                              //       amount: double.parse(walletController
                              //           .paymentAmount[index].amount
                              //           .toString()),
                              //     ));
                            },
                            child: Container(
                              margin: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                    child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            walletController.subUpdateAmount(
                                                walletController
                                                        .paymentAmount[index]
                                                        .amount ??
                                                    0,
                                                index);
                                            // walletController.paymentAmount[index].amount=(walletController.paymentAmount[index].amount! + 50);
                                          },
                                          child: Icon(
                                            Icons.remove,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '${global.getSystemFlagValueForLogin(global.systemFlagNameList.currency)} ${walletController.paymentAmount[index].amount}',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        InkWell(
                                            onTap: () {
                                              walletController.addUpdateAmount(
                                                  walletController
                                                          .paymentAmount[index]
                                                          .amount ??
                                                      0,
                                                  index);
                                              // walletController.paymentAmount[index].amount=(walletController.paymentAmount[index].amount! + 50);
                                            },
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.black,
                                            )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    InkWell(
                                        onTap: () {
                                          Get.delete<RazorPayController>();
                                          Get.to(() => PaymentInformationScreen(
                                                amount: double.parse(
                                                    walletController
                                                        .paymentAmount[index]
                                                        .amount
                                                        .toString()),
                                              ));
                                        },
                                        child: Container(
                                            width: 50,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                    color: Colors.black)),
                                            child: Center(child: Text('Add'))))
                                  ],
                                )),
                              ),
                            ),
                          );
                        });
                  })
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
