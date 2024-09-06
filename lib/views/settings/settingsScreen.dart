import 'package:AstroGuru/controllers/history_controller.dart';
import 'package:AstroGuru/controllers/settings_controller.dart';
import 'package:AstroGuru/utils/global.dart';
import 'package:AstroGuru/utils/images.dart';
import 'package:AstroGuru/views/astrologerProfile/block_astrologer_screen.dart';
import 'package:AstroGuru/views/profile/editUserProfileScreen.dart';
import 'package:AstroGuru/views/settings/notificationScreen.dart';
import 'package:AstroGuru/views/settings/privacyPolicyScreen.dart';
import 'package:AstroGuru/views/settings/termsAndConditionScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';

import '../../widget/commonAppbar.dart';
import 'package:AstroGuru/utils/global.dart' as global;

class SettingListScreen extends StatelessWidget {
  const SettingListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Get.theme.cardColor,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(56),
            child: CommonAppBar(
              isLeading: true,
              title: 'Settings',
            )),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              GetBuilder<SettingsController>(builder: (settingsController) {
                return /*settingsController.blockedAstroloer.isEmpty
                    ? const SizedBox()
                    :*/
                    Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, left: 10, bottom: 0),
                  child: GestureDetector(
                    onTap: () async {
                      bool isLogin = await global.isLogin();
                      if (isLogin) {
                        global.showOnlyLoaderDialog(context);
                        await splashController.getCurrentUserData();
                        global.hideLoader();
                        Get.to(() => EditUserProfile());
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.white),
                          child: Container(
                            height: 140,
                            width: 140,
                            alignment: Alignment.center,
                            child: splashController.currentUser?.profile == ""
                                ? CircleAvatar(
                                    radius: 40,
                                    backgroundColor:
                                        Get.theme.primaryColorLight,
                                    child: Image.asset(
                                      Images.deafultUser,
                                      fit: BoxFit.fill,
                                      height: 50,
                                    ))
                                : CachedNetworkImage(
                                    imageUrl:
                                        "${global.imgBaseurl}${splashController.currentUser?.profile}",
                                    imageBuilder: (context, imageProvider) {
                                      return CircleAvatar(
                                        radius: 40,
                                        backgroundColor: Colors.white,
                                        backgroundImage: NetworkImage(
                                            "${global.imgBaseurl}${splashController.currentUser?.profile}"),
                                      );
                                    },
                                    placeholder: (context, url) => const Center(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) {
                                      return CircleAvatar(
                                          radius: 35,
                                          backgroundColor: Colors.white,
                                          child: Image.asset(
                                            Images.deafultUser,
                                            fit: BoxFit.fill,
                                            height: 50,
                                          ));
                                    },
                                  ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  splashController.currentUser == null
                                      ? "user"
                                      : splashController.currentUser!.name == ""
                                          ? "User"
                                          : "${splashController.currentUser!.name}",
                                  style: Get.textTheme.bodyLarge!
                                      .copyWith(fontSize: 18),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.edit,
                                  size: 15,
                                )
                              ],
                            ),
                            splashController.currentUser == null
                                ? const SizedBox()
                                : Text(
                                    '${splashController.currentUser!.countryCode}-${splashController.currentUser!.contactNo}')
                          ],
                        ),
                        IconButton(
                            onPressed:
                                null /*() {
                                  Get.back();
                                }*/
                            ,
                            icon: Icon(
                              Icons.close,
                              color: Colors.transparent,
                            ))
                      ],
                    ),
                  ),
                );
              }),
              Divider(
                color: Get.theme.primaryColorLight,
              ),
/*
              GetBuilder<SettingsController>(builder: (settingsController) {
                return settingsController.blockedAstroloer.isEmpty
                    ? const SizedBox()
                    : GestureDetector(
                        onTap: () async {
                          global.showOnlyLoaderDialog(context);
                          await settingsController.getBlockAstrologerList();
                          global.hideLoader();
                          Get.to(() => BlockAstrologerScreen());
                        },
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            elevation: 2,
                            child: Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                "Block Astrologer",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
              }),
*/
              GetBuilder<SettingsController>(builder: (settingsController) {
                return GestureDetector(
                  onTap: () async {
                    global.showOnlyLoaderDialog(context);
                    await settingsController.getNotification();
                    global.hideLoader();
                    Get.to(() => const NotificationScreen());
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      elevation: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(15.0),
                            child: SizedBox(
                              width: 150,
                              child: Text(
                                "Notifications",
                                style: Get.theme.primaryTextTheme.subtitle1,
                              ),
                            ),
                          ),
                          Icon(Icons.notifications_active_outlined)
                        ],
                      ),
                    ),
                  ),
                );
              }),
              Divider(
                color: Get.theme.primaryColorLight,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => TermAndConditionScreen());
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    elevation: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(15.0),
                          child: SizedBox(
                            width: 170,
                            child: Text(
                              "Terms and Condition",
                              style: Get.theme.primaryTextTheme.subtitle1,
                            ),
                          ),
                        ),
                        Icon(Icons.privacy_tip_outlined)
                      ],
                    ),
                  ),
                ),
              ),
              Divider(
                color: Get.theme.primaryColorLight,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => const PrivacyPolicyScreen());
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    elevation: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(15.0),
                          child: SizedBox(
                            width: 170,
                            child: Text(
                              "Privacy Policy",
                              style: Get.theme.primaryTextTheme.subtitle1,
                            ),
                          ),
                        ),
                        Icon(Icons.privacy_tip_outlined)
                      ],
                    ),
                  ),
                ),
              ),
              Divider(
                color: Get.theme.primaryColorLight,
              ),
              GestureDetector(
                onTap: () {
                  Get.dialog(
                    AlertDialog(
                      backgroundColor: Colors.white,
                      title: Text(
                        "Are you sure you want to logout?",
                        style: Get.textTheme.subtitle1,
                      ),
                      content: Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: ElevatedButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text('No'),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 4,
                            child: ElevatedButton(
                              onPressed: () {
                                HistoryController historyController =
                                    Get.find<HistoryController>();
                                historyController.chatHistoryList.clear();
                                historyController.astroMallHistoryList.clear();
                                historyController.reportHistoryList.clear();
                                historyController.callHistoryList.clear();
                                historyController.paymentLogsList.clear();
                                historyController.walletTransactionList.clear();
                                global.logoutUser();
                              },
                              child: Text('YES'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    elevation: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(15.0),
                          child: SizedBox(
                            width: 170,
                            child: Text(
                              "Logout My Account",
                              style: Get.theme.primaryTextTheme.subtitle1,
                            ),
                          ),
                        ),
                        Icon(Icons.logout)
                      ],
                    ),
                  ),
                ),
              ),
              Divider(
                color: Get.theme.primaryColorLight,
              ),
              GetBuilder<SettingsController>(builder: (settingsController) {
                return GestureDetector(
                  onTap: () async {
                    bool isLogin = await global.isLogin();
                    if (isLogin) {
                      Get.dialog(
                        AlertDialog(
                          backgroundColor: Colors.white,
                          title: Text(
                            "Are you sure you want to delete this Account?",
                            style: Get.textTheme.subtitle1,
                          ),
                          content: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text('No'),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 4,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    global.showOnlyLoaderDialog(context);
                                    settingsController.deleteAccount(
                                        global.sp!.getInt("currentUserId") ??
                                            0);
                                    global.logoutUser();
                                    global.hideLoader();
                                  },
                                  child: Text('YES'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      elevation: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(15.0),
                            child: SizedBox(
                              width: 170,
                              child: Text(
                                "Delete My Account",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          Icon(Icons.delete, color: Colors.red)
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
