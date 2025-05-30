import 'dart:io';

import 'package:AstroGuru/controllers/reviewController.dart';
import 'package:AstroGuru/controllers/splashController.dart';
import 'package:AstroGuru/controllers/themeController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../utils/images.dart';

// ignore: must_be_immutable
class BlogScreen extends StatelessWidget {
  final String link;
  final String title;
  final String? videoTitle;
  final String? date;
  final YoutubePlayerController? controller;
  BlogScreen(
      {super.key,
      required this.link,
      this.controller,
      this.title = 'News',
      this.date,
      this.videoTitle});
  final ReviewController reviewController = Get.find<ReviewController>();
  SplashController splashController = Get.find<SplashController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    title,
                    style: Get.theme.primaryTextTheme.headline6!
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: GestureDetector(
                      onTap: () {
                        splashController.createAstrologerShareLink();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                Images.whatsapp,
                                height: 40,
                                width: 40,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text('Share',
                                    style: Get.textTheme.subtitle1!
                                        .copyWith(fontSize: 12,color: Colors.white)),
                              )
                            ],
                          ),
                        ),
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
      )
      /*AppBar(
          backgroundColor: Get.theme.appBarTheme.systemOverlayStyle!.statusBarColor,
          title: Text(
            '$title',
            style: Get.theme.primaryTextTheme.headline6!
                .copyWith(fontSize: 18, fontWeight: FontWeight.normal),
          ),
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
              color: Get.theme.iconTheme.color,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                splashController.createAstrologerShareLink();
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        Images.whatsapp,
                        height: 40,
                        width: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Share',
                            style: Get.textTheme.subtitle1!
                                .copyWith(fontSize: 12)),
                      )
                    ],
                  ),
                ),
              ),
            )
          ])*/,
      body: title == "News"
          ? WebView(
              initialUrl: link,
              javascriptMode: JavascriptMode.unrestricted,
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  child: Center(
                    child: YoutubePlayer(
                      aspectRatio: 16 / 13,
                      controller: controller!,
                      showVideoProgressIndicator: true,
                      progressColors: ProgressBarColors(
                        playedColor: Colors.red,
                        handleColor: Colors.grey,
                      ),
                      bottomActions: [
                        CurrentPosition(),
                        ProgressBar(
                          isExpanded: true,
                        ),
                        RemainingDuration(),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: Get.width * 0.7,
                        child: Text('$videoTitle'),
                      ),
                      Text(
                        '$date',
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
