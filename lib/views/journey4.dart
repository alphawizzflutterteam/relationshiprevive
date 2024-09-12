import 'package:AstroGuru/constants/colors.dart';
import 'package:AstroGuru/views/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Journey4 extends StatelessWidget {
  const Journey4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,

            children: [
              SizedBox(height: 50,),


              Container(
                height: 250,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/phone.png')
                    )
                ),
              ),

              Text("Get started with your email or phone number",style: Get.textTheme.headlineMedium,textAlign: TextAlign.center,),


              Padding(
                padding: const EdgeInsets.all(20),
                child: GestureDetector(
                    onTap:(){
                      Get.to(LoginScreen());
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        decoration: BoxDecoration(
                          color: colors.gradient4,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text('Start Now',textAlign: TextAlign.center,style:Get.textTheme.titleLarge))),
              ),



            ],
          ),
        ),
      ),

    );
  }
}
