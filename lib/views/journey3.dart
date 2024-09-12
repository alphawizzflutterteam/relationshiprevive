import 'package:AstroGuru/constants/colors.dart';
import 'package:AstroGuru/views/journey4.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Journey3 extends StatefulWidget {
  const Journey3({super.key});

  @override
  State<Journey3> createState() => _Journey3State();
}

class _Journey3State extends State<Journey3> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
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
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50,),

                  Center(child: Text("Address",style: Get.textTheme.headlineLarge,)),


                  Center(
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/Home.png')
                          )
                      ),
                    ),
                  ),
                  SizedBox(height: 50,),

                  Text('House no.'),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      validator: (value) {
                        if(value!.isEmpty){
                          return "Please Enter Address";
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                          fillColor: Colors.blue.shade50,
                          filled: true,
                          isDense: true,
                          hintText: "Enter Current Address",
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w400),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),


                          )),
                    ),
                  ),

                  Text('City/State/Country'),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      validator: (value) {
                        if(value!.isEmpty){
                          return "Please Enter city/state/country";
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                          fillColor: Colors.blue.shade50,
                          filled: true,
                          isDense: true,
                          hintText: "Enter City/State/Country",
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w400),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),


                          )),
                    ),
                  ),

                  Text('Pincode'),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      validator: (value) {
                        if(value!.isEmpty){
                          return "Please Enter Pincode";
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                          fillColor: Colors.blue.shade50,
                          filled: true,
                          isDense: true,
                          hintText: "Enter Pincode",
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w400),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),


                          )),
                    ),
                  ),




                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: GestureDetector(
                          onTap:(){
                            if(_formKey.currentState!.validate()){
                              Get.to(Journey4());
                            }
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                              decoration: BoxDecoration(
                                color: colors.gradient4,
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
