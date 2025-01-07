import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../widget/commonAppbar.dart';
import 'package:AstroGuru/utils/global.dart' as global;

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.primaryColor,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: CommonAppBar(
            title: 'Privacy Policy',
          )),
      body: WebView(
        initialUrl: '${global.webBaseUrl}admin/privacy-policy-1',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
