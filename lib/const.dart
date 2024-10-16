import 'package:flutter/material.dart';

//const kprimaryColor= Color(0xFFAADAAA);
// const inventoryUrl="https://14df-2a00-5400-e266-709a-bc24-5f3a-5ef5-31d.ngrok-free.app";
// const availabiltityUrl="https://14df-2a00-5400-e266-709a-bc24-5f3a-5ef5-31d.ngrok-free.app";
// const shareUrl="https://14df-2a00-5400-e266-709a-bc24-5f3a-5ef5-31d.ngrok-free.app";
// const plonogramUrl="https://1335-82-167-217-165.ngrok-free.app";

const urlApi="https://flaskproject1.onrender.com";
    //"https://flaskproject1-3.onrender.com";

 const mainColor = Color(0xff235464);
 const blackColor=Colors.black;
const transparentColor=Colors.transparent;
const whiteColor =Colors.white;
const greyColor=Colors.grey;
const redColor =Colors.red;
 const backgroundColor = Color(0xffFFFFFF);
 const backgroundColor2 = Color(0xffEEEEEE);
 const fontWhite = Color(0xffFFFFFF);
 const fontRed = Color(0xffE00000);
 const fontgrey = Color(0xff696969);

const kSecondColor=Color.fromRGBO(157, 157, 157, 1);
const kprimaryColor = Color.fromARGB(255, 2, 92, 102);
const kprimatyLightColor = Color(0xFFFFECDF);

const kBackgroundColor = Color(0xFFF8F8F1);
const kActiveIconColor = Color(0xFFE68342);
//const kTextColor=Color(0xFF222B45);
const kBlueLightColor = Color(0xFFC7BBF5);
const kBlueColor = Color(0xFF817DC0);
const kShadowColor = Color(0xFFE6E6E6);

const kprimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondoryColor = Color(0xFF979797);
const kTextColor = Color.fromRGBO(13, 2, 115,1);
//Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 350);

// Errors
final List<String> errors = [
  //"enter a valid  Email Address!!",
  //  "Enter a strong Password",
];
// form Errors
final RegExp emailValidatorRegExp =
RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String emptydataError = "emptydata";
const String kIvalidValueError = "please Enter a valid phone_number";
const String kEmailNullError = "Please Enter Your Email";
const String kInvalidEmailError = "Please Enter a Valid E_mail Address ";
const String kPassNullError = "Please Enter Your Password";
const String kshortPassError = "You Entered Short Password";
const String kMatchPassError = "Passwords don't match";
const String validphonenumbernumber = "Plase Enter valid phonenumber number";
const String validIdnumber = "Plase Enter valid Iqama number ";
const String validBithday = "Plase Enter valid Birthday  ";
final otpInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 15),
  enabledBorder: outLineInputBorder(),
  focusedBorder: outLineInputBorder(),
  border: outLineInputBorder(),
);

OutlineInputBorder outLineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: kTextColor),
  );
}
