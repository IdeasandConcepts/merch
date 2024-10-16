

import 'package:arrow_merchandising/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Validation extends StatefulWidget {
  const Validation({Key? key}) : super(key: key);

  @override
  State<Validation> createState() => _ValidationState();
}

class _ValidationState extends State<Validation> {
  @override
  TextEditingController idcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String userName="";
  String password="";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            children: <Widget>[
              Container(
                height: 300,
                decoration: BoxDecoration(
                color: kprimaryColor.withOpacity(0.5)
                ),
              ),
              const SizedBox(height: 50.0),
              Form(
                key: _formKey,
                //key: _formkey,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: TextFormField(
                        controller: idcontroller,
                        decoration: InputDecoration(
                          contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                            ),
                          ),
                          labelText: 'Email'.tr,
                        ),
                        // Here is Validation Code
                        validator: (value) {
                          if (value!.isEmpty)
                                {
                            return 'Empty field'.tr;
                          } else if (value.contains('#')) {
                            return 'Invalid Email Address';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          userName = newValue!;
                          userName = idcontroller.text;
                        },
                        onChanged: (newValue) {
                          userName = newValue;
                          userName = passwordcontroller.text;
                        },
                      ),
                    ),
                    const SizedBox(height: 30.0),

                    //  'Phone',
                    Container(
                      child: TextFormField(
                        controller: passwordcontroller,
                        // controller: username,
                        decoration: InputDecoration(
                          contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          // suffixIcon: CustomSurffixIcon(
                          //   svgIcon: "assets/icons/person.svg",
                          // ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              //color: kprimaryColor
                              // kTextColor
                            ),
                          ),
                          filled: true,
                          labelText: 'Password'.tr,
                        ),
                        // Here is Validation Code
                        validator: (value) {
                          if (value!.isEmpty)
                          {
                            return 'Empty field'.tr;
                          } else if (value.contains('#')) {
                            return 'Invalid Password'.tr;
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          password = newValue!;
                          password = passwordcontroller.text;
                        },
                        onChanged: (newValue) {
                          password = newValue;
                          password = passwordcontroller.text;
                        },
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 50.0),
              InkWell(
                onTap: () async {
                  // Here is Validation Code
                  if (_formKey.currentState?.validate() == true) {
                    _formKey.currentState?.save();
                    //  if data correct
                    print("Success Data");
                    // Start login Validation
                  }
                },
                child: Text(
               'LOGIN'.tr,
                ),
              ),

              const SizedBox(height: 50.0),

            ],
          ),
        ),
      ),
    );
  }
}
