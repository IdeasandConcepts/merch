import 'package:arrow_merchandising/view/components/default_button.dart';
import 'package:arrow_merchandising/view/screens/splash/auth_helper.dart';
import 'package:arrow_merchandising/view/screens/splash/auth_page.dart';
import 'package:arrow_merchandising/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController idcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  late String idstr, passwordstr;

  bool _obscureText=false;

  void toggle(){
    setState(() {
      _obscureText=!_obscureText;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color:kprimaryColor,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                width: 545.w,
                height: 0.65.sh,
                decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(35.r)),
                    image: const DecorationImage(
                      image: AssetImage("assets/images/appBackground.jpeg"),
                      fit: BoxFit.cover,
                    )),
              ),
              Stack(
                children: [
                  Center(
                    child: Container(
                      width: 346.h,
                      height: 600.h,
                      padding: EdgeInsets.all(25.w).copyWith(bottom: 0),
                      decoration: BoxDecoration(
                          color: kBackgroundColor,
                          borderRadius: BorderRadius.circular(30.r)),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(left:15.h,right: 15.h),
                              child: Container(
                                child: Image.asset(
                                  "assets/images/appLogo.png",
                                ),
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Shelf".toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 40.sp,
                                      color: kprimaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Pro".toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 40.sp,
                                      color: kSecondColor,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            SizedBox(height: 40.h),
                            Material(
                                elevation: 15,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                                  width: 300.w,
                                  height:  60.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular( 20),
                                  ),
                                  child: TextFormField(
                                    // maxLines: 1,
                                    keyboardType: TextInputType.emailAddress,
                                    controller: idcontroller,
                                    // controller: username,
                                    decoration: InputDecoration(
                                      contentPadding:
                                      EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 10),
                                      prefixIcon: Icon(Icons.person),
                                      border: InputBorder.none,
                                      labelText: "User name".tr,
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14.sp),
                                    ),
                                    onSaved: (newValue) {
                                      idstr = newValue!;
                                      idstr = idcontroller.text;
                                    },
                                    onChanged: (newValue) {
                                      idstr = newValue;
                                      idstr = idcontroller.text;
                                    },
                                  ),
                                )),
                            SizedBox(height: 29.h),

                            Material(
                              //color:kBackgroundColor,
                                borderRadius: BorderRadius.circular(0),
                                elevation: 15,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                                  width: 300.w,
                                  height:  60.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular( 0),
                                    //color: const Color(0xffF6F6F6),
                                  ),
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    obscureText: !_obscureText,
                                    controller: passwordcontroller,
                                    // controller: username,
                                    decoration: InputDecoration(
                                      contentPadding:
                                      EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                                      // floatingLabelBehavior: FloatingLabelBehavior.always,
                                      prefixIcon: Icon(Icons.lock,color: Colors.black,),
                                      suffixIcon: IconButton(
                                        onPressed: (){
                                          toggle();
                                        },
                                        icon: Icon(Icons.visibility,color: Colors.black,),
                                      ),
                                      border: InputBorder.none,
                                      labelText: "Password".tr,
                                      hintStyle: TextStyle(
                                          color: Colors.white,
                                          //const Color(0xff9B9B9B),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14.sp),
                                      // border: InputBorder.none,
                                    ),

                                    // labelText: "Password",
                                    onSaved: (newValue) {
                                      idstr = newValue!;
                                      idstr = idcontroller.text;
                                    },
                                    onChanged: (newValue) {
                                      idstr = newValue;
                                      idstr = passwordcontroller.text;
                                    },
                                  ),
                                )),
                            SizedBox(height: 51.h),
                            GestureDetector(
                              onTap: () async{
                                if (_formkey.currentState?.validate() == true)
                                  _formkey.currentState?.save();
                                {
                                  try {
                                    final user = await AuthHelper.signWithemail(
                                        idcontroller.text.toString().trim(),
                                        passwordcontroller.text.toString().trim());
                                    if (user != null) {
                                      Fluttertoast.showToast(

                                          msg: "Login Successfully".tr,
                                          backgroundColor: kprimaryColor,
                                          toastLength: Toast.LENGTH_LONG,
                                          fontSize: 20,
                                          gravity:ToastGravity.CENTER

                                      );
                                      //Get.to(()=>AuthPage());
                                      Get.offAll(AndroidAuthPage());

                                      // Get.offAll(AuthPage());
                                      //Get.replace => AuthPage());
                                      // print('success');
                                    }
                                  } on FirebaseAuthException catch (e) {
                                    if ((idcontroller.text.toString() == "")
                                        &&(passwordcontroller.text.toString()=="")) {
                                      Fluttertoast.showToast(
                                          msg: "User Name && Password!! are Empty".tr,
                                          backgroundColor: Colors.grey,
                                          toastLength: Toast.LENGTH_LONG,
                                          fontSize: 20,
                                          gravity: ToastGravity.CENTER
                                      );
                                    }
                                    else if ((idcontroller.text.toString() == "")
                                        &&(passwordcontroller.text.toString()!="")) {
                                      Fluttertoast.showToast(
                                          msg: "User Name Can't be Empty".tr,
                                          backgroundColor: Colors.grey,
                                          toastLength: Toast.LENGTH_LONG,
                                          fontSize: 20,
                                          gravity: ToastGravity.CENTER
                                      );
                                    }else if ((idcontroller.text.toString() != "")
                                        &&(passwordcontroller.text.toString()=="")) {
                                      Fluttertoast.showToast(
                                          msg: "Password Can't be Empty".tr,
                                          backgroundColor: Colors.grey,
                                          toastLength: Toast.LENGTH_LONG,
                                          fontSize: 20,
                                          gravity: ToastGravity.CENTER
                                      );
                                    }
                                    else if ((idcontroller.text.toString() != "")
                                        &&(passwordcontroller.text.toString()!="")) {
                                      Fluttertoast.showToast(
                                          msg: "Wrong User Name && Password!!".tr,
                                          backgroundColor: Colors.grey,
                                          toastLength: Toast.LENGTH_LONG,
                                          fontSize: 20,
                                          gravity: ToastGravity.CENTER
                                      );
                                      print(e);
                                    }
                                  }
                                }
                              },
                              child: DefualtButton(
                                text: "LOGIN".tr,
                                selected: true,
                                // onTap: () {
                                //   Get.to(() =>  AndroidAuthPage());
                                // },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}