
import 'package:AstroGuru/constants/colors.dart';
import 'package:AstroGuru/views/Journey2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Journey1 extends StatefulWidget {
  const Journey1({super.key});

  @override
  State<Journey1> createState() => _Journey1State();
}

class _Journey1State extends State<Journey1> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50,),


                  Center(
                    child: Container(
                        height: 300,
                        width: 300,
                        child: Lottie.asset("assets/animation/name_animation.json")),
                  ),

                  Center(child: Text('Let\'s us begin...',style: Get.textTheme.titleLarge,)),
                  SizedBox(height: 20,),

                  Text('First Name:'),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      validator: (value) {
                        if(value!.isEmpty){
                          return "Please Enter First Name";
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        fillColor: Colors.blue.shade50,
                          filled: true,
                          isDense: true,
                          hintText: "Enter Your First Name",
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w400),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),


                          )),
                    ),
                  ),

                  Text('Middle Name:'),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      validator: (value) {
                        if(value!.isEmpty){
                          return "Please Enter Middle Name";
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                          fillColor: Colors.blue.shade50,
                          filled: true,
                          isDense: true,
                          hintText: "Enter Your Middle Name",
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w400),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),


                          )),
                    ),
                  ),

                  Text('Last Name:'),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      validator: (value) {
                        if(value!.isEmpty){
                          return "Please Enter Last Name";
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                          fillColor: Colors.blue.shade50,
                          filled: true,
                          isDense: true,
                          hintText: "Enter Your Last Name",
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w400),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),


                          )),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: GestureDetector(
                          onTap:(){
                              if(_formKey.currentState!.validate()){
                                Get.to(Journey2());
                                }
                              },
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                              decoration: BoxDecoration(
                                color: colors.gradient3,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text('Next',textAlign: TextAlign.center,style:Get.textTheme.titleLarge))),
                    ),
                  ),
              
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
