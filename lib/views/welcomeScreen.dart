import 'package:AstroGuru/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(

      child: Scaffold(
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
                ],
              )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: Text('Welcome \nto \nRelationship Revive.',textAlign: TextAlign.center,style: Get.textTheme.headlineSmall,)),
              Text(' Let’s begin the journey \ntowards a better \ntomorrow….',textAlign: TextAlign.center,style: Get.textTheme.headlineSmall,),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(' Let’s continue...',textAlign: TextAlign.center,style: Get.textTheme.headlineSmall,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
