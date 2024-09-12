import 'package:AstroGuru/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'journey3.dart';

class Journey2 extends StatefulWidget {
  const Journey2({super.key});

  @override
  State<Journey2> createState() => _Journey2State();
}

class _Journey2State extends State<Journey2> {



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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50,),

              Text("Gender",style: Get.textTheme.headlineLarge,),

              SizedBox(height: 50,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: (){},
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/man.png')
                            )
                          ),
                        ),
                      ),
                      Text('Male',style:Get.textTheme.titleLarge),

                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: (){},
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/woman.png')
                              )
                          ),
                        ),
                      ),
                      Text('Female',style:Get.textTheme.titleLarge)

                    ],
                  )
                ],
              ),



              SizedBox(height: 50,),

              Padding(
                padding: const EdgeInsets.all(20),
                child: GestureDetector(
                    onTap:(){
                      Get.to(Journey3());
                    },
                    child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: colors.gradient4,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text('Prefer Not To Say',textAlign: TextAlign.center,style:Get.textTheme.titleLarge))),
              ),


              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     Icon(Icons.arrow_circle_right,size: 50,color: Colors.white,)
              //   ],
              // )
            ],
          ),
        ),
      ),

    );
  }
}
