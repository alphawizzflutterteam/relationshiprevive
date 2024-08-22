// ignore_for_file: must_be_immutable

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:AstroGuru/controllers/bottomNavigationController.dart';
import 'package:AstroGuru/controllers/callController.dart';
import 'package:AstroGuru/controllers/IntakeController.dart';
import 'package:AstroGuru/controllers/chatController.dart';
import 'package:AstroGuru/controllers/razorPayController.dart';
import 'package:AstroGuru/controllers/splashController.dart';
import 'package:AstroGuru/controllers/themeController.dart';
import 'package:AstroGuru/utils/images.dart';
import 'package:AstroGuru/views/placeOfBrithSearchScreen.dart';
import 'package:AstroGuru/widget/customBottomButton.dart';
import 'package:AstroGuru/widget/textFieldLabelWidget.dart';
import 'package:AstroGuru/widget/textFieldWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:AstroGuru/utils/global.dart' as global;
import 'package:google_translator/google_translator.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../controllers/dropDownController.dart';
import '../utils/date_converter.dart';
import '../widget/drodownWidget.dart';
import 'call/incoming_call_request.dart';

class CallIntakeFormScreen extends StatefulWidget {
  final reportType;
  final String astrologerName;
  final int astrologerId;
  final String type;
  final String astrologerProfile;
  final bool? isFreeAvailable;

  CallIntakeFormScreen(
      {Key? key,
      this.reportType,
      this.isFreeAvailable = false,
      required this.astrologerName,
      required this.astrologerId,
      required this.type,
      required this.astrologerProfile})
      : super(key: key);

  @override
  State<CallIntakeFormScreen> createState() => _CallIntakeFormScreenState();
}

class _CallIntakeFormScreenState extends State<CallIntakeFormScreen> {
  RazorPayController razorPay = Get.find<RazorPayController>();

  SplashController splashController = Get.find<SplashController>();

  BottomNavigationController bottomNavigationController =
      Get.find<BottomNavigationController>();

  IntakeController callIntakeController = Get.find<IntakeController>();

  CallController callController = Get.find<CallController>();

  ChatController chatController = Get.find<ChatController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  bool ispop = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                top: 15.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(
                      Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
                      color: Get.theme.iconTheme.color,
                    ),
                  ),
                  Text(
                    '${widget.type} Intake Form',
                    style: Get.theme.primaryTextTheme.headline6!
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: InkWell(
                      onTap: () async {
                        /*bool isLogin = await global.isLogin();
                        global.showOnlyLoaderDialog(context);
                        await walletController.getAmount();
                        global.hideLoader();
                        if (isLogin) {
                          Get.to(() => AddmoneyToWallet());
                        }*/
                      },
                      child: Image.asset(
                        Images.wallet,
                        height: 25,
                        width: 25,
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ],
              )),
          decoration: BoxDecoration(
            gradient: gradient.btnGradient,
          ),
        ),
        preferredSize: Size.fromHeight(70.0),
      ) /*AppBar(
        backgroundColor:
            Get.theme.appBarTheme.systemOverlayStyle!.statusBarColor,
        title: Text(
          '${widget.type} Intake Form',
          style: Get.theme.primaryTextTheme.headline6!
              .copyWith(fontSize: 15, fontWeight: FontWeight.normal),
        ) */ /**/ /*,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
            color: Get.theme.iconTheme.color,
          ),
        ),
      )*/
      ,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GetBuilder<IntakeController>(builder: (c) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15),
                TextFieldWidget(
                  controller: callIntakeController.nameController,
                  focusNode: callIntakeController.namefocus,
                  inputFormatter: [
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]"))
                  ],
                  labelText: 'Name',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                            child: FutureBuilder(
                                future: global.translatedText('Phone Number'),
                                builder: (context, snapshot) {
                                  return IntlPhoneField(
                                    autovalidateMode: null,
                                    showDropdownIcon: false,
                                    onCountryChanged: (value) {
                                      callIntakeController.namefocus.unfocus();
                                      callIntakeController.phonefocus.unfocus();
                                      callIntakeController
                                          .updateCountryCode(value.code);
                                    },
                                    focusNode: callIntakeController.phonefocus,
                                    controller:
                                        callIntakeController.phoneController,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    keyboardType: TextInputType.phone,
                                    cursorColor: global.coursorColor,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                      hintText: snapshot.data,
                                      errorText: null,
                                      counterText: '',
                                    ),
                                    initialCountryCode:
                                        callIntakeController.countryCode ??
                                            'IN',
                                    onChanged: (phone) {
                                      print('length ${phone.number}');

                                      callIntakeController
                                          .checkContact(phone.number);
                                    },
                                  );
                                })),
                      ),
                    ),
                    !callIntakeController.isVarified
                        ? GetBuilder<IntakeController>(builder: (c) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 30,
                                child: TextButton(
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.all(4)),
                                    fixedSize: MaterialStateProperty.all(
                                        Size.fromWidth(90)),
                                    backgroundColor: MaterialStateProperty.all(
                                        Get.theme.primaryColor),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(
                                          color: Color.fromARGB(
                                              255, 189, 189, 189),
                                        ),
                                      ),
                                    ),
                                  ),
                                  onPressed: () async {
                                    if (callIntakeController
                                            .intakeContact!.length ==
                                        10) {
                                      global.showOnlyLoaderDialog(context);
                                      await callIntakeController.verifyOTP();
                                    }
                                  },
                                  child: Text(
                                    'Verify',
                                    style: Get.theme.primaryTextTheme.subtitle2,
                                    textAlign: TextAlign.center,
                                  ) /**/,
                                ),
                              ),
                            );
                          })
                        : const SizedBox(),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFieldLabelWidget(
                        label: 'Gender',
                      ),
                      Flexible(
                        flex: 1,
                        child: RadioListTile(
                          title: Text("Male") /**/,
                          value: "male",
                          groupValue: callIntakeController.gender,
                          dense: true,
                          activeColor: Get.theme.primaryColor,
                          contentPadding: EdgeInsets.all(0.0),
                          onChanged: (value) {
                            callIntakeController.updateGeneder(value);
                          },
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: RadioListTile(
                          title: Text("Female") /**/,
                          value: "female",
                          groupValue: callIntakeController.gender,
                          activeColor: Get.theme.primaryColor,
                          contentPadding: EdgeInsets.all(0.0),
                          dense: true,
                          onChanged: (value) {
                            callIntakeController.updateGeneder(value);
                          },
                        ),
                      ),
                      SizedBox(
                        width: 78,
                      )
                    ]),
                InkWell(
                  onTap: () async {
                    callIntakeController.namefocus.unfocus();
                    callIntakeController.phonefocus.unfocus();
                    var datePicked = await DatePicker.showSimpleDatePicker(
                      context,
                      initialDate: DateTime(1994),
                      firstDate: DateTime(1960),
                      lastDate: DateTime.now(),
                      dateFormat: "dd-MM-yyyy",
                      itemTextStyle: Get.theme.textTheme.subtitle1!.copyWith(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0,
                      ),
                      titleText: 'Select Birth Date',
                      textColor: Get.theme.primaryColor,
                    );
                    if (datePicked != null) {
                      callIntakeController.dobController.text =
                          DateConverter.isoStringToLocalDateOnly(
                              datePicked.toIso8601String());
                      callIntakeController.selctedDate = datePicked;
                      callIntakeController.update();
                    } else {
                      callIntakeController.dobController.text =
                          DateConverter.isoStringToLocalDateOnly(
                              DateTime(1994).toIso8601String());
                      callIntakeController.selctedDate = DateTime(1994);
                      callIntakeController.update();
                    }
                  },
                  child: IgnorePointer(
                    child: TextFieldWidget(
                      controller: callIntakeController.dobController,
                      labelText: 'Date of Birth',
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    callIntakeController.namefocus.unfocus();
                    callIntakeController.phonefocus.unfocus();
                    final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay(hour: 12, minute: 30),
                        builder: (context, child) {
                          return Theme(
                            data: ThemeData(
                              colorScheme: ColorScheme.light(
                                primary: Get.theme.primaryColor,
                                onBackground: Colors.white,
                              ),
                            ),
                            child: child ?? SizedBox(),
                          );
                        });
                    String formatTimeOfDay(TimeOfDay tod) {
                      final now = new DateTime.now();
                      final dt = DateTime(
                          now.year, now.month, now.day, tod.hour, tod.minute);
                      final format = DateFormat.jm(); //"6:00 AM"
                      return format.format(dt);
                    }

                    if (time != null) {
                      callIntakeController.birthTimeController.text =
                          formatTimeOfDay(time);
                    }
                  },
                  child: IgnorePointer(
                    child: TextFieldWidget(
                      controller: callIntakeController.birthTimeController,
                      labelText: 'Time of Birth',
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    callIntakeController.namefocus.unfocus();
                    callIntakeController.phonefocus.unfocus();
                    Get.to(() => PlaceOfBirthSearchScreen(
                          flagId: 5,
                        ));
                  },
                  child: IgnorePointer(
                    child: TextFieldWidget(
                      controller: callIntakeController.placeController,
                      labelText: 'Place of Birth',
                    ),
                  ),
                ),
                TextFieldLabelWidget(
                  label: 'Marital Status',
                ),
                DropDownWidget(
                  item: [
                    'single',
                    'Married',
                    'Divorced',
                    'Separated',
                    'Widowed'
                  ],
                  hint: 'Select Marital Status',
                  callId: 1,
                ),
                const SizedBox(
                  height: 6,
                ),
                TextFieldWidget(
                  controller: callIntakeController.ocupationController,
                  focusNode: callIntakeController.occupationfocus,
                  labelText: 'Occupation',
                  inputFormatter: [
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]"))
                  ],
                ),
                TextFieldLabelWidget(
                  label: 'Topic of Concern',
                ),
                DropDownWidget(
                  item: ['Study', 'Future', 'Past'],
                  hint: 'Select Topic of Concern',
                  callId: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                        value: callIntakeController.isEnterPartnerDetails,
                        activeColor: Get.theme.primaryColor,
                        onChanged: (bool? value) {
                          callIntakeController.partnerDetails(value!);
                        }),
                    Text("Enter Partner's Details",
                        style: Get.textTheme.subtitle1!.copyWith(
                          fontSize: 12,
                          decoration: TextDecoration.underline,
                        )) /**/
                  ],
                ),
                if (callIntakeController.isEnterPartnerDetails)
                  if (callIntakeController.isEnterPartnerDetails)
                    TextFieldWidget(
                      controller: callIntakeController.partnerNameController,
                      labelText: "Partner's Name",
                      focusNode: callIntakeController.partnerNamefocus,
                      inputFormatter: [
                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]"))
                      ],
                    ),
                if (callIntakeController.isEnterPartnerDetails)
                  if (callIntakeController.isEnterPartnerDetails)
                    InkWell(
                      onTap: () async {
                        callIntakeController.occupationfocus.unfocus();
                        callIntakeController.partnerNamefocus.unfocus();
                        var datePicked = await DatePicker.showSimpleDatePicker(
                          context,
                          initialDate: DateTime(1994),
                          firstDate: DateTime(1960),
                          lastDate: DateTime.now(),
                          dateFormat: "dd-MM-yyyy",
                          itemTextStyle:
                              Get.theme.textTheme.subtitle1!.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0,
                          ),
                          titleText: "Select Partner's Birth Date",
                        );
                        if (datePicked != null) {
                          callIntakeController.partnerDobController.text =
                              DateConverter.isoStringToLocalDateOnly(
                                  datePicked.toIso8601String());
                          callIntakeController.selctedPartnerDate = datePicked;
                          callIntakeController.update();
                        } else {
                          callIntakeController.partnerDobController.text =
                              DateConverter.isoStringToLocalDateOnly(
                                  DateTime(1994).toIso8601String());
                          callIntakeController.selctedPartnerDate =
                              DateTime(1994);
                          callIntakeController.update();
                        }
                      },
                      child: IgnorePointer(
                        child: TextFieldWidget(
                          controller: callIntakeController.partnerDobController,
                          labelText: "Partner's DOB",
                        ),
                      ),
                    ),
                if (callIntakeController.isEnterPartnerDetails)
                  if (callIntakeController.isEnterPartnerDetails)
                    InkWell(
                      onTap: () async {
                        callIntakeController.occupationfocus.unfocus();
                        callIntakeController.partnerNamefocus.unfocus();

                        final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay(hour: 12, minute: 30));
                        String formatTimeOfDay(TimeOfDay tod) {
                          final now = new DateTime.now();
                          final dt = DateTime(now.year, now.month, now.day,
                              tod.hour, tod.minute);
                          final format = DateFormat.jm(); //"6:00 AM"
                          return format.format(dt);
                        }

                        if (time != null) {
                          callIntakeController.partnerBirthController.text =
                              formatTimeOfDay(time);
                        }
                      },
                      child: IgnorePointer(
                        child: TextFieldWidget(
                          controller:
                              callIntakeController.partnerBirthController,
                          labelText: "Partner's Time of Birth",
                        ),
                      ),
                    ),
                if (callIntakeController.isEnterPartnerDetails)
                  if (callIntakeController.isEnterPartnerDetails)
                    InkWell(
                      onTap: () {
                        callIntakeController.occupationfocus.unfocus();
                        callIntakeController.partnerNamefocus.unfocus();
                        Get.to(() => PlaceOfBirthSearchScreen(
                              flagId: 6,
                            ));
                      },
                      child: IgnorePointer(
                        child: TextFieldWidget(
                          controller:
                              callIntakeController.partnerPlaceController,
                          labelText: 'Place of Birth',
                        ),
                      ),
                    ),
                const SizedBox(
                  height: 60,
                ),
              ],
            );
          }),
        ),
      ),
      bottomSheet: GetBuilder<IntakeController>(builder: (intakeController) {
        return CustomBottomButton(
          onTap: () async {
            bool isvalid = intakeController.isValidData();
            print(isvalid);
            if (!isvalid) {
              global.showToast(
                message: intakeController.errorText,
                textColor: global.textColor,
                bgColor: global.toastBackGoundColor,
              );
            } else {
              if (intakeController.isVarified) {
                global.showOnlyLoaderDialog(context);
                await callIntakeController.addCallIntakeFormData();
                print(
                    'firebase ${widget.astrologerId}_${global.currentUserId}');
                if (widget.isFreeAvailable == true) {
                  //await intakeController.checkFreeSessionAvailable();
                  if (intakeController.isAddNewRequestByFreeuser == true) {
                    if (widget.type == "Call") {
                      print('hsdkjfhkjfkfhffkfkkjshdf');
                      await callController.sendCallRequest(
                          widget.astrologerId, true);
                    } else {
                      ChatController chatController =
                          Get.find<ChatController>();
                      DropDownController dropDownController =
                          Get.find<DropDownController>();
                      await chatController.sendMessage(
                          'hi ${widget.astrologerName} ',
                          '${widget.astrologerId}_${global.currentUserId}',
                          widget.astrologerId,
                          false);
                      await chatController.sendMessage(
                          'Below are my details:',
                          '${widget.astrologerId}_${global.currentUserId}',
                          widget.astrologerId,
                          false);
                      await chatController.sendMessage(
                          'Name: ${intakeController.nameController.text},Gender: ${intakeController.gender},DOB: ${intakeController.dobController.text},TOB: ${intakeController.birthTimeController.text},POB: ${intakeController.placeController.text},Marital status: ${dropDownController.maritalStatus ?? "Single"},TOPIC: ${dropDownController.topic ?? 'Study'}',
                          '${widget.astrologerId}_${global.currentUserId}',
                          widget.astrologerId,
                          false);

                      if (callIntakeController.isEnterPartnerDetails) {
                        await chatController.sendMessage(
                            'Below are my partner details:',
                            '${widget.astrologerId}_${global.currentUserId}',
                            widget.astrologerId,
                            false);
                        await chatController.sendMessage(
                            'Name: ${intakeController.partnerNameController.text},DOB: ${intakeController.partnerDobController.text},TOB: ${intakeController.partnerBirthController.text},POB: ${intakeController.partnerPlaceController.text}',
                            '${widget.astrologerId}_${global.currentUserId}',
                            widget.astrologerId,
                            false);
                        await chatController.sendMessage(
                            'This is automated message to confirm that chat has started.',
                            '${widget.astrologerId}_${global.currentUserId}',
                            widget.astrologerId,
                            false);
                      } else {
                        await chatController.sendMessage(
                            'This is automated message to confirm that chat has started.',
                            '${widget.astrologerId}_${global.currentUserId}',
                            widget.astrologerId,
                            false);
                      }
                      await chatController.sendChatRequest(
                          widget.astrologerId, true);
                    }
                  } else {
                    global.showToast(
                        message:
                            'You can not join multiple offers at same time',
                        textColor: global.textColor,
                        bgColor: global.toastBackGoundColor);
                  }
                } else {
                  if (widget.type == "Call") {
                    await callController.sendCallRequest(
                        widget.astrologerId, false);
                  } else {
                    ChatController chatController = Get.find<ChatController>();
                    DropDownController dropDownController =
                        Get.find<DropDownController>();
                    await chatController.sendMessage(
                        'hi ${widget.astrologerName} ',
                        '${widget.astrologerId}_${global.currentUserId}',
                        widget.astrologerId,
                        false);
                    await chatController.sendMessage(
                        'Below are my details:',
                        '${widget.astrologerId}_${global.currentUserId}',
                        widget.astrologerId,
                        false);
                    await chatController.sendMessage(
                        'Name: ${intakeController.nameController.text},Gender: ${intakeController.gender},DOB: ${intakeController.dobController.text},TOB: ${intakeController.birthTimeController.text},POB: ${intakeController.placeController.text},Marital status: ${dropDownController.maritalStatus ?? "Single"},TOPIC: ${dropDownController.topic ?? 'Study'}',
                        '${widget.astrologerId}_${global.currentUserId}',
                        widget.astrologerId,
                        false);

                    if (callIntakeController.isEnterPartnerDetails) {
                      await chatController.sendMessage(
                          'Below are my partner details:',
                          '${widget.astrologerId}_${global.currentUserId}',
                          widget.astrologerId,
                          false);
                      await chatController.sendMessage(
                          'Name: ${intakeController.partnerNameController.text},DOB: ${intakeController.partnerDobController.text},TOB: ${intakeController.partnerBirthController.text},POB: ${intakeController.partnerPlaceController.text}',
                          '${widget.astrologerId}_${global.currentUserId}',
                          widget.astrologerId,
                          false);
                      await chatController.sendMessage(
                          'This is automated message to confirm that chat has started.',
                          '${widget.astrologerId}_${global.currentUserId}',
                          widget.astrologerId,
                          false);
                    } else {
                      await chatController.sendMessage(
                          'This is automated message to confirm that chat has started.',
                          '${widget.astrologerId}_${global.currentUserId}',
                          widget.astrologerId,
                          false);
                    }
                    await chatController.sendChatRequest(
                        widget.astrologerId, false);
                  }
                }
                global.hideLoader();
                Navigator.pop(context);
                Get.back();

                FlutterRingtonePlayer().play(
                    fromAsset:
                        "assets/phone_outgoing_call.mp3", // will be the sound on Android
                    ios: IosSounds.glass,
                    volume: 1,
                    looping: true // will be the sound on iOS
                    );
                _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
                  if (count >= 30) {
                    timer.cancel();
                    FlutterRingtonePlayer().stop();
                    callController.rejectedCall(callController.callId!);
                    Get.back();
                    Get.showSnackbar(GetSnackBar(
                        message:
                            'Right now advisor is busy, try again after some time'));
                  } else {
                    count++;
                  }
                });
                ;
                dialogForchat();
              } else {
                global.showToast(
                  message: 'Please verify your phone number',
                  textColor: global.textColor,
                  bgColor: global.toastBackGoundColor,
                );
              }
            }
          },
          title: 'Start ${widget.type} with ${widget.astrologerName}',
        );
      }),
    );
  }

  bool isCall = true;

  Timer? _timer;
  int count = 0;

  dialogForchat() {
    BuildContext context = Get.context!;
    listenNotification();
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, dialogState) {
              return PopScope(
                canPop: false,
                child: AlertDialog(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  title: Column(children: [
                    Center(
                      child: Text(
                        "You're all set!",
                        style: Get.theme.textTheme.headline1!.copyWith(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal),
                      ) /**/,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              maxRadius: 30,
                              backgroundColor: Get.theme.primaryColor,
                              child: CachedNetworkImage(
                                  imageUrl:
                                      '${global.imgBaseurl}${splashController.currentUser!.profile}',
                                  imageBuilder: (context, imageProvider) =>
                                      CircleAvatar(
                                        radius: 28,
                                        backgroundImage: imageProvider,
                                      ),
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      CircleAvatar(
                                        radius: 28,
                                        backgroundImage:
                                            AssetImage(Images.deafultUser),
                                      )),
                            ),
                            Center(
                              child: Text(
                                "•••••••••••",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            CircleAvatar(
                              maxRadius: 30,
                              backgroundColor: Get.theme.primaryColor,
                              child: CachedNetworkImage(
                                  imageUrl:
                                      '${global.imgBaseurl}${widget.astrologerProfile}',
                                  imageBuilder: (context, imageProvider) =>
                                      CircleAvatar(
                                        radius: 28,
                                        backgroundImage: imageProvider,
                                      ),
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      CircleAvatar(
                                        radius: 28,
                                        backgroundImage:
                                            AssetImage(Images.deafultUser),
                                      )),
                            ),
                          ],
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "${splashController.currentUser!.name}",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.normal),
                        ) /**/,
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(width: 13),
                        ),
                        Text(
                          "Advisor",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.normal),
                        ) /**/
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        'You will be connecting with Relationship Revive after advisor accept your request',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.normal),
                      ) /**/,
                    ),
                    Text(
                      'Advisor will try to answer atleast one question in this 5 mins session',
                      style: TextStyle(
                          fontSize: 11, fontWeight: FontWeight.normal),
                    ) /**/,
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: ElevatedButton(
                            onPressed: () async {
                              if (callController.callId != null) {
                                await callController
                                    .rejectedCall(callController.callId!);
                                FlutterRingtonePlayer().stop();
                                Get.back();
                              } else {}
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isCall
                                  ? Colors.red
                                  : Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: BorderSide(color: Colors.grey)),
                              shadowColor: Colors.transparent,
                            ),
                            child: Text(
                              isCall ? 'End Call' : 'Call',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white),
                            ) /*,*/
                            ),
                      ),
                    ),
                  ]),
                  actionsAlignment: MainAxisAlignment.spaceBetween,
                  actionsPadding:
                      const EdgeInsets.only(bottom: 15, left: 15, right: 15),
                ),
              );
            },
          );
        });
  }

  listenNotification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      _timer?.cancel();
      FlutterRingtonePlayer().stop();

      var messageData = json.decode(json.encode(message.data));

      Map<dynamic, dynamic> body;
      body = jsonDecode(messageData['body']);
      if (body["notificationType"] == 1) {
        print('callId - ${body["callId"]}');
        Get.to(() => IncomingCallRequest(
              astrologerId: body["astrologerId"],
              astrologerName: body["astrologerName"] == null
                  ? "Astrologer"
                  : body["astrologerName"],
              astrologerProfile: body["profile"] == null ? "" : body["profile"],
              token: body["token"],
              channel: body["channelName"],
              callId: body["callId"],
              fcmToken: body["fcmToken"] ?? "",
            ));
      } else if (body["notificationType"] == 100) {
        FlutterRingtonePlayer().stop();
        Get.back();
        _timer?.cancel();
        Fluttertoast.showToast(msg: 'Call rejected by advisor');
      }
    });
  }
}
