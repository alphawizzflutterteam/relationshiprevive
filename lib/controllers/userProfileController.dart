// ignore_for_file: unnecessary_null_comparison, unnecessary_statements

import 'dart:developer';
import 'dart:io';

import 'package:AstroGuru/controllers/splashController.dart';

import 'package:AstroGuru/utils/services/api_helper.dart';
import 'package:AstroGuru/views/verifyPhoneScreen.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:AstroGuru/utils/global.dart' as global;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../model/dailyHoroscope_model.dart';
import 'loginController.dart';

class UserProfileController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController placeBirthController = TextEditingController();
  TextEditingController currentAddressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  SplashController splashController = Get.find<SplashController>();
  FocusNode fSearch = new FocusNode();
  FocusNode nameFocus = FocusNode();
  FocusNode currentAddFocus = FocusNode();
  FocusNode cityFocus = FocusNode();
  FocusNode countryFocus = FocusNode();
  String toastMessage = "";
  String gender = 'Male';
  bool isShowMore = false;
  String profile = "";
  APIHelper apiHelper = APIHelper();
  DateTime? pickedDate;
  Uint8List? tImage;
  XFile? selectedImage;
  File? imageFile;
  File? userFile;
  var zodicData = <Zodic>[];
  bool isImgSelectFromList = false;
  String selectedListImg = "";

  @override
  void onInit() async {
    _inIt();
    super.onInit();
  }

  _inIt() async {
    await splashController.getCurrentUserData();
    await getValue();
  }

  onOpenCamera() async {
    selectedImage = await openCamera(Get.theme.primaryColor).obs();
    update();
  }

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file =
        await File('${(await getApplicationDocumentsDirectory()).path}/$path')
            .create(recursive: true);
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  getValue() async {
    print('${splashController.currentUser!.birthDate}_______________');
    if (splashController.currentUser != null) {
      nameController.text = splashController.currentUser!.name!;
      profile = splashController.currentUser!.profile ?? "";
      updateGeneder(splashController.currentUser!.gender!);
      dateController.text = formatDate(
          splashController.currentUser!.birthDate!, [dd, '-', mm, '-', yyyy]);
      timeController.text = splashController.currentUser!.birthTime!;
      placeBirthController.text = splashController.currentUser!.birthPlace!;
      currentAddressController.text =
          splashController.currentUser!.addressLine1!;
      cityController.text = splashController.currentUser!.location!;
      countryController.text = splashController.currentUser?.country ?? '';
      pinController.text =
          splashController.currentUser!.pincode.toString() == "null"
              ? ""
              : splashController.currentUser!.pincode.toString();
      imageFile = null;
      userFile = null;
      update();
    }
  }

  updateGeneder(value) {
    gender = value;
    update();
  }

  Future<File> imageService(ImageSource imageSource) async {
    try {
      final ImagePicker picker = ImagePicker();
      XFile? selectedImage = await picker.pickImage(
          source: imageSource, imageQuality: 80, maxHeight: 400, maxWidth: 400);
      imageFile = File(selectedImage!.path);

      if (selectedImage != null) {
        imageFile;
      }
    } catch (e) {
      print("Exception - businessRule.dart - _openGallery() ${e.toString()}");
    }
    return imageFile!;
  }

  showMoreText() {
    isShowMore = !isShowMore;
    update();
  }

  bool isValidData({bool? fromUpdate}) {
    if (nameController.text == "") {
      toastMessage = "Please Enter your first name";
      update();
      return false;
    } else if (!(fromUpdate ?? false) && phoneController.text.length != 10) {
      print('${phoneController.text.length}__________');
      toastMessage = "Please Enter valid mobile number";
      update();
      return false;
    }
    return true;
  }

  Future<XFile?> openCamera(Color color, {bool isProfile = true}) async {
    try {
      final ImagePicker picker = ImagePicker();
      XFile? _selectedImage =
          await picker.pickImage(source: ImageSource.camera);

      if (_selectedImage != null) {
        print("cropped file :- $_selectedImage");
        return _selectedImage;
      }
    } catch (e) {
      // ignore: avoid_print
      print("Exception - user_profile_controller.dart - openCamera():" +
          e.toString());
    }
    return null;
  }

  updateCurrentUser(int id) async {
    var basicDetails = {
      "name": nameController.text,
      "contactNo": splashController.currentUser!.contactNo,
      "email": splashController.currentUser!.email,
      "gender": gender,
      "birthTime": timeController.text == "" ? null : timeController.text,
      "birthDate": pickedDate == null ? null : pickedDate!.toIso8601String(),
      "birthPlace":
          placeBirthController.text == "" ? null : placeBirthController.text,
      "addressLine1": currentAddressController.text == ""
          ? null
          : currentAddressController.text,
      "addressLine2": null,
      "location": cityController.text == "" ? null : cityController.text,
      "pincode":
          pinController.text == "" ? null : int.parse(pinController.text),
      "profile": profile == "" ? null : profile,
      "country": countryController.text
    };
    try {
      await global.checkBody().then((result) async {
        if (result) {
          await apiHelper
              .updateUserProfile(id, basicDetails)
              .then((result) async {
            if (result.status == "200") {
              global.showToast(
                message: 'Your Profile has been updated',
                textColor: global.textColor,
                bgColor: global.toastBackGoundColor,
              );
              await splashController.getCurrentUserData();
              Get.back();
            } else {
              global.showToast(
                message: 'Failed to update profile please try again later!',
                textColor: global.textColor,
                bgColor: global.toastBackGoundColor,
              );
            }
          });
        }
      });
    } catch (e) {
      print("Exception in updateUserProfile:-" + e.toString());
    }
  }

  updateCurrentUserProfilepic(String profile) async {
    try {
      await global.checkBody().then((result) async {
        if (result) {
          await apiHelper.updetUserProfilePic(profile).then((result) async {
            if (result.status == "200") {
              global.showToast(
                message: 'Your Profile pic has been updated',
                textColor: global.textColor,
                bgColor: global.toastBackGoundColor,
              );
              await splashController.getCurrentUserData();
              Get.back();
            } else {
              global.showToast(
                message: 'Failed to update profile please try again later!',
                textColor: global.textColor,
                bgColor: global.toastBackGoundColor,
              );
            }
          });
        }
      });
    } catch (e) {
      print("Exception in updateUserProfile:-" + e.toString());
    }
  }

  sendOtp() async {
    print(phoneController.text);
    print('country code ${phoneController.text}');

    try {
      await global.checkBody().then((result) async {
        if (result) {
          await apiHelper
              .sendOtp(phoneController.text, '0')
              .then((result) async {
            if (result.status == "200") {
              print('${result.status}____________');
              log('${result.recordList['otp']}____________');
              // var recordId = result.recordList["recordList"];

              global.hideLoader();
              LoginController loginController = Get.find<LoginController>();
              loginController.timer();
              Get.to(() => VerifyPhoneScreen(
                    phoneNumber: phoneController.text,
                    verificationId: "",
                    otp: result.recordList['otp'].toString(),
                    fromSignup: true,
                  ));
            } else {
              global.hideLoader();
              log("what\'s wrong ${result.status}");

              global.showToast(
                message: result.error.contactNo[0],
                textColor: global.textColor,
                bgColor: global.toastBackGoundColor,
              );
            }
          });
        }
      });
    } catch (e) {}

    /*await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '${countryCode + phoneController.text}',
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        global.hideLoader();
        print('exception $e');

        global.showToast(
          message: 'Please enter valid mobile number',
          textColor: global.textColor,
          bgColor: global.toastBackGoundColor,
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        verificationId = verificationId;
        update();
        global.hideLoader();
        LoginController loginController = Get.find<LoginController>();
        loginController.timer();
        Get.to(() => VerifyPhoneScreen(
              phoneNumber: phoneController.text,
              verificationId: verificationId,
            ));
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );*/
  }

  registerUser() async {
    var basicDetails = {
      "name": nameController.text,
      "contactNo": phoneController.text,
      "gender": gender,
      "email": emailController.text,
      //"birthTime": timeController.text == "" ? null : timeController.text,
      "birthDate": pickedDate == null ? null : pickedDate!.toIso8601String(),
      // "birthPlace": placeBirthController.text == "" ? null : placeBirthController.text,
      "addressLine1": currentAddressController.text == ""
          ? null
          : currentAddressController.text,
      // "addressLine2": null,
      "location": cityController.text == "" ? null : cityController.text,
      "pincode":
          pinController.text == "" ? null : int.parse(pinController.text),
      "profile": profile == "" ? null : profile,
      "country": countryController.text
    };
    try {
      await global.checkBody().then((result) async {
        if (result) {
          await apiHelper
              .registerUserProfile(basicDetails)
              .then((result) async {
            log('${basicDetails}');
            if (result.status == "200") {
              global.showToast(
                message: 'User register successfully',
                textColor: global.textColor,
                bgColor: global.toastBackGoundColor,
              );
              await splashController.getCurrentUserData();
              Get.back();
              Get.back();
            } else {
              global.showToast(
                message: 'Failed to update profile please try again later!',
                textColor: global.textColor,
                bgColor: global.toastBackGoundColor,
              );
            }
          });
        }
      });
    } catch (e) {
      print("Exception in updateUserProfile:-" + e.toString());
    }
  }

  getZodicImg() async {
    try {
      await global.checkBody().then((result) async {
        if (result) {
          global.showOnlyLoaderDialog(Get.context);
          await apiHelper.getZodiacProfileImg().then((result) async {
            global.hideLoader();
            if (result.status == "200") {
              zodicData = result.recordList;
              update();
            } else {
              global.showToast(
                message: 'Fail to Get defualt img!',
                textColor: global.textColor,
                bgColor: global.toastBackGoundColor,
              );
            }
          });
        }
      });
    } catch (e) {
      print("Exception in getZodicImg:-" + e.toString());
    }
  }
}
