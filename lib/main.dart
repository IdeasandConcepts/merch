
import 'package:arrow_merchandising/view/screens/splash/auth_page.dart';
import 'package:arrow_merchandising/controller/localization_and_theme/changelocal_and_theme_controller.dart';
import 'package:arrow_merchandising/controller/localization_and_theme/theme_provider.dart';
import 'package:arrow_merchandising/controller/services/services.dart';
import 'package:arrow_merchandising/local.dart';


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';



void main() async {

 await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
 await initialServices();
 SystemChrome.setPreferredOrientations(
     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
 SystemChrome.setEnabledSystemUIMode(
     SystemUiMode.manual,
     overlays:[],);

 runApp(
     ChangeNotifierProvider(
   create: (context) => ThemeProvider(),
   child:
   MyApp(),
 )
 );
 // runApp(MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {

    LocaleAndThemeController controller = Get.put(LocaleAndThemeController());
    return ScreenUtilInit(
      designSize:
      //Size(540,730),
    Size(
       MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height,),

      // ScreenUtilInit(
        //designSize: const Size(360, 690),
     minTextAdapt: true,
     splitScreenMode: true,
    builder: (context,child) {
      return

        //child:
        GetMaterialApp(
          // navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          //defaultGlobalState: true,
          title: 'Shelf Pro',

          // theme: Provider.of<ThemeProvider>(context).themeData,
          //theme: controller.appTheme,
          translations: MyLocale(),
          locale: controller.language,
          //  locale: Get.deviceLocale,
          home:
          //YoloVideo(),
         // YoloVideo(),
          //RTVYoloVideo(),
          //AddTaskScreen(),
          //TasksScreen(),
          //GetDistance(),
          //LoginPage(),
          //TasksScreen(),
          //HomeScreen(),
          //LoginScreen(),
          //LoginPage(),
          //ShareOfShelfScreen(),
          //Ordering(),
          //MyProfile(),
          //HomeRoute(),
          // PdfApi(),
          //AvailabilityOptions(),
          //ShareWithAi(),
          //MyHomePage(title:"Planogram"),
          // ScrollScreen(),
         //PanoramaImageScreen()
          AndroidAuthPage(),
          //  initialRoute: '/',
          routes: {
            //  '/': (context) => const HomeRoute(),
            // '/second': (context) => const SecondRoute(),
            // '/third': (context) => const ThirdRoute(),
          },
          // routes: {
          //   "authPage": (context) => AndroidAuthPage()
          //
          //  },
        );
    }
    );
  }

}
