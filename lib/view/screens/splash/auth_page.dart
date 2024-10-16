

import 'package:arrow_merchandising/view/screens/merchandiser/home/main%20data/daily_tasks.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../super_visor/home/supervisor_screen.dart';
import 'waiting_screen.dart';
import 'aplash_screen.dart';
import 'user_helper.dart';


class AndroidAuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            Userhelper.saveUser(snapshot.data!);
            Userhelper.saveDevice(snapshot.data!);
            return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('Users')
                    .doc(snapshot.data!.uid)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    final myuser = snapshot.data!.data();
                     if (myuser['role'] == "manager") {
                      return AndroidSuperVisorScreen(
                        role:myuser['role'],
                        nationality: myuser['nationality'],
                        name: myuser['name'],
                        profileImage: myuser['profile_image'].toString(),
                        id: myuser['id'],
                        phone: myuser['phone']
                      );
                    } else if (myuser['role'] == "merchandiser") {
                      return DailyTasks(
                            nationality: myuser['nationality'],
                            branch:myuser['branch'],
                            market:myuser['market'],
                        username: myuser['name'],
                            profileImage: myuser['profile_image'].toString(),
                            marketImage: myuser['market_image'].toString(),
                            id: myuser['id'],
                            phone: myuser['phone'],
                            adminPhone: myuser['admin_number'],
                      );
                     // supervisor
                    } else if (myuser['role'] == "super") {
                      return AndroidSuperVisorScreen(
                        role:myuser['role'],
                        nationality: myuser['nationality'],
                        name: myuser['name'],
                        profileImage: myuser['profile_image'].toString(),
                        id: myuser['id'],
                        phone: myuser['phone'],
                      );
                    }
                    else if(myuser['role'] == "new user")
                   {
                     return WaitingScreen(username:myuser['name'],);
                    }
                  }
                   return Center(child: new CircularProgressIndicator());
                });

          }
         return AndroidSplashScreen();
        }
        );
  }

}
