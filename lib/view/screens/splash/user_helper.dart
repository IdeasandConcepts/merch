import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Userhelper {
  static FirebaseFirestore _db = FirebaseFirestore.instance;
  //static FirebaseFirestore _db = FirebaseFirestore.instance.collection(collectionPath).doc()
  //late Map<String, dynamic> deviceData;
  static saveUser(User user) async {
   // PackageInfo packageInfo = await PackageInfo.fromPlatform();
   // int buildNumber = int.parse(packageInfo.buildNumber);
    Map<String, dynamic> userData = {
      'nationality': 'nationality',
      //merchendisers: myuser,
      'profile_image':'profileImage'.toString(),
     'market_image':'market_image'.toString(),
      'password':user.phoneNumber,
      'admin_number':551337260,
      'branch':"All Branches",
      //'build_number': buildNumber,
      'created_at': user.metadata.creationTime!,
      'email': user.email!,
    'id':2520505010,
      'last_login': user.metadata.lastSignInTime!,
      'location': 'current location',
    'market':"All Markets",
      'name': user.email!,
    'phone' :966551471471,
      'role': 'new user',
    };

    final userRef = _db.collection('Users').doc(user.uid);
    if ((await userRef.get()).exists) {
      await userRef.update({
        'last_login': user.metadata.lastSignInTime,
       // 'build_number': buildNumber,
      });
    } else {
      await userRef.set(userData);
    }
    //await saveDevice(user);
  }

  static saveDevice(User user) async {
    final nowMs = DateTime.now();

    //Map<String, dynamic> deviceData;
   // DeviceInfoPlugin devicePlugin = DeviceInfoPlugin();
    late String? deviceId;
    String? os_version, platform, model, device;

    // if (Platform.isAndroid) {
    //   ..final deviceInfo = await devicePlugin.androidInfo;
    //   deviceId = deviceInfo.brand;
    //   //Map<String, dynamic> deviceData = {
    //   os_version = deviceInfo.version.sdkInt.toString();
    //   platform = 'android';
    //   model = deviceInfo.model;
    //   device = deviceInfo.device;
    //   //  };
    // }
    // if (Platform.isIOS) {
    //   final deviceInfo = await devicePlugin.iosInfo;
    //   deviceId = deviceInfo.identifierForVendor!;
    //   // Map<String, dynamic> deviceData = {
    //   os_version = deviceInfo.systemVersion;
    //   platform = 'ios';
    //   model = deviceInfo.model;
    //   device = deviceInfo.name;
    //   // };
    // }
    final deviceRef = _db
        .collection('Users')
        .doc(user.uid)
        .collection('Devices')
        .doc("deviceId");

    if ((await deviceRef.get()).exists) {
      await deviceRef.update({
        'updated_at': nowMs,
        'uninstalled': false,
      });
    } else {
      await deviceRef.set({
        'created_at': nowMs,
        'updated_at': nowMs,
        'uninstalled': false,
        'id': "deviceId",
        'os_version': os_version,
        'platform': platform,
        'model': model,
        'device': device,
        'locaction': 'Current location'
        //'device_info': deviceData
        //deviceData.toString()

        //     'device_inf0':deviceData!,
        //  //   'device_info':deviceData,
        //    // 'device_info': deviceData
      });
    }
  }
}
