

import 'dart:io';

import 'package:arrow_merchandising/view/components/default_button.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/merch_nav_bar.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/profile/profile_screen.dart';
import 'package:arrow_merchandising/const.dart';
import 'package:arrow_merchandising/models/Visits.dart';
import 'package:arrow_merchandising/models/capture_photos.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class VisitReview extends StatefulWidget {
  // final FirstVisit firstVisit;
  // final LastVisit lastVisit;
  //List<CapturePhotos> before,after;
  final int id, phone, adminPhone;
  final String marketImage,
      profileImage,
      username,
     // orderBy,
      branch,
      manegerName,
      market,
      nationality;
  const VisitReview({
    super.key,
   // required this.firstVisit,
   // required this.orderBy,
    required this.marketImage,
    required this.profileImage,
    required this.username,
    required this.branch,
    required this.market,
    required this.id,
    required this.phone,
    required this.nationality,
   // required this.lastVisit,
    required this.adminPhone,
    required this.manegerName
  });

  @override
  State<VisitReview> createState() => _VisitReviewState();
}

class _VisitReviewState extends State<VisitReview> with TickerProviderStateMixin{


  @override
  Widget build(BuildContext context) {
    TabController _controller =TabController(length: 2, vsync: this);
    // final currentWidth = MediaQuery.of(context).size.width-21.42;
    // final currenheight = MediaQuery.of(context).size.height+160.58;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(35, 84, 100, 1),
        leading: IconButton(
          onPressed: (){
            Get.defaultDialog(
              title: "",
              content: MerchDrawerItems(
                  name: widget.username, market:  widget.market, profileImage:  widget.profileImage,
                  branch: widget. branch, phone:  widget.phone)
            );
          },
          icon: Padding(
            padding: const EdgeInsets.fromLTRB(8,8,0,0),
            child: const Icon(Icons.menu,color: Colors.white,size: 24,),
          ),),

      ),

      body: Container(
        height: 800.h,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical:10 ),
          child: Column(
            children: [

              Container(
                height: 60.h,
                child: TabBar(
                    controller: _controller,


                    indicatorColor: kprimaryColor,
                   // indicatorSize:,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,

                    tabs: [
                      Container(
                        height: 58.h,
                          width: 151.h,
                          decoration:  BoxDecoration(
                            //  color: kprimaryColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: Tab(child:Text( "Before".tr,style: TextStyle(color: Colors.black)))),
                      Container(
                          height: 58.h,
                          width: 151.h,
                          decoration:  BoxDecoration(
                              //color: kprimaryColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: Tab(child:Text( "After".tr,style: TextStyle(color: Colors.black),))),

                      // child: Text("Before")),
                //  Text("")
                ]),
              ),

              SizedBox(height: 10.h,),
              Container(
                height: 600.h,
                child: TabBarView(
                  controller: _controller,
                    children: [
                    buildVisitCard("Before",firstVisitTask,),
                    buildVisitCard("After",lastVisitTask,),
                ]),
              )
                  ],
              ),
              ),
      ),

bottomNavigationBar:    Padding(
    padding:  EdgeInsets.only(left:15.h,right: 15.h,),
  child: InkWell(
  onTap: ()  {
    if(lastVisitTask.length>0)
      {
    print("firstVisitTask");
    print(firstVisitTask.length);
    print("lastVisitTask");
    print(lastVisitTask.length);

    createVisitTask(FullVisit(
        orderBy:"Daily Task",
       after: lastVisitTask,
            before:firstVisitTask,
            market: widget.market,
            branch: widget.branch,
            madeBy: widget.username,
            date: (DateFormat('yyyy-MM-dd')
                .format(DateTime.now())
                .toString()),
            taskTime: (DateFormat('kk:mm')
                .format(DateTime.now())
                .toString()),
            status: 'done'
        ));

      if(doneTask==true)
    {
    setState(() {
    firstVisitTask = [];
    lastVisitTask = [];
    completeLastOrderingTask.add(lastVisitTask[0].title);

    }

    );
    }
          Get.offAll(() =>
              MerchNavBar(
                  tab_index: 2,
                  //username: username, marketImage: marketImage, profileImage: profileImage, branch: branch, market: market, id: id, phone: phone, manegerName: manegerName, nationality: nationality, mangerphone: mangerphone)
                  manegerName: widget.manegerName,
                  username: widget.username,
                  marketImage: widget.marketImage,
                  profileImage: widget
                      .profileImage,
                  branch: widget.branch,
                  market: widget.market,
                  id: widget.id,
                  phone: widget.phone,
                  nationality: widget.nationality,
                  mangerphone: widget.adminPhone)
          );
      }
    else{
      Get.defaultDialog(
        title: "",
        content: Text("Add Data To Last Ordering".tr)
      );
      Navigator.of(context).pop();
    }
    // uploadAfterImage(myImagePath)
  },
  child:Padding(
    padding:  EdgeInsets.only(left:15.h,right: 15.h),
    child: DefualtButton(
    text:"Confirm",selected: true,
      // style:  TextStyle(fontSize: 22,
      //   fontWeight: FontWeight.w700, color: Colors.white),))
        ),
  )),
),
    );
  }

  Container buildVisitCard(String title,List<CapturePhotos> visit ) {
    return Container(
                height: 600.h,
                child: ListView.builder(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,

                  // children: [
                    itemCount:visit.length ,
                    itemBuilder: (context,index)
                    {
                      return _Cards(visit[index],title);
                    }
                  //           _Cards(),
                  //           ]
                )
            );
  }

  Card _Cards(CapturePhotos visit,String title){
    // return ListView.builder(
    //   // crossAxisAlignment: CrossAxisAlignment.center,
    //   // mainAxisAlignment: MainAxisAlignment.center,
    //
    //   // children: [
    //     itemCount:lastVisitTaskDetails.length ,
    //     itemBuilder: (context,index)
    //     {
          return


          Card(

    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
    ),

    child: Container(
      height: 151,
      width: 376,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10)
      ),
      child: Row(children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal:10 ,vertical: 10),
            child:
            Card(
              child: Container(
                // decoration: BoxDecoration(
                //
                // ),
                  height: 120.h,
                  width: 120.h,
                  child: Image.network(visit.images[0])
                 // Icon(Icons.add)
              ),
            )
          // Image.asset("assets/addPic.png", scale: 2,
          //
          // ),
        ),
        Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(5,9.6,0,0),
            child: Container(
                height: 35.89,
                width: 203.43,

                decoration: BoxDecoration(
                    color: Color.fromRGBO(246, 246, 246, 1),
                    borderRadius: BorderRadius.circular(11),
                    boxShadow: [BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                      spreadRadius: 0,
                      blurRadius: 25,
                      offset: Offset(0, 1),
                    )]
                ),
                child: TextButton(
                  onPressed: (){},
                  child: Text(visit.product, style: TextStyle(color: Color.fromRGBO(63, 61, 61, 1), fontSize: 14,fontWeight: FontWeight.w500)) ,)),

          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5,9.6,0,0),
            child: Container(
                height: 35.89,
                width: 203.43,

                decoration: BoxDecoration(
                    color: Color.fromRGBO(246, 246, 246, 1),
                    borderRadius: BorderRadius.circular(11),
                    boxShadow: [BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                      spreadRadius: 0,
                      blurRadius: 25,
                      offset: Offset(0, 1),
                    )]
                ),
                child: TextButton(
                  onPressed: (){},
                  child: Text(visit.place, style: TextStyle(color: Color.fromRGBO(63, 61, 61, 1), fontSize: 14,fontWeight: FontWeight.w500)) ,)),

          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5,9.6,0,0),
            child: Container(
                height: 35.89,
                width: 203.43,

                decoration: BoxDecoration(
                    color: Color.fromRGBO(246, 246, 246, 1),
                    borderRadius: BorderRadius.circular(11),
                    boxShadow: [BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                      spreadRadius: 0,
                      blurRadius: 25,
                      offset: Offset(0, 1),
                    )]
                ),
                child: TextButton(
                  onPressed: (){},
                  child: Text(title, style:TextStyle(color: Color.fromRGBO(63, 61, 61, 1), fontSize: 14,fontWeight: FontWeight.w500)) ,)),

          ),
        ],)
      ],),
    )

        );

          ;
    //     }
    //   //           _Cards(),
    //   //           ]
    // );
  }
    Future createVisitTask(FullVisit capturePhotos) async {
    final visit =
    FirebaseFirestore.instance.collection("Visits").doc();
    final json = capturePhotos.toMap();
    await visit.set(json);
    doneTask=true;
    //  final
  }
 bool doneTask=false,uploadDone=false,startProgress=false;
 UploadTask? uploadTask;
 //String rtvImage="";

 Future uploadBeforeImage(List<File?> myImagePath) async {
   for (int i = 0; i < myImagePath.length; i++) {
     final file = File(myImagePath[i]!.path);
     final ref =
     FirebaseStorage.instance
         .ref().child(myImagePath[i]!.path);
     setState(() {
       startProgress = true;
       uploadTask = ref.putFile(file);
     });
     final snapShot = await uploadTask!.whenComplete(() {
       if(strBeforePhotosList.length==myImagePath.length)
       setState(() {
         uploadDone=true;
         startProgress=false;
       });

       // });
     });
     strBeforePhotosList.add(await snapShot.ref.getDownloadURL());
     setState(() {
       uploadTask = ref.putFile(file);
     });
   }
   setState(() {
     if(strBeforePhotosList.length==myImagePath.length)
      // uploadDone=true;
       startProgress=false;
   });
 }

 List<String> strBeforePhotosList=[];


 List<String> strAfterPhotosList=[];

  Future uploadAfterImage(List<File?> myImagePath) async {
    for (int i = 0; i < myImagePath.length; i++) {
      final file = File(myImagePath[i]!.path);
      final ref =
      FirebaseStorage.instance
          .ref().child(myImagePath[i]!.path);
      setState(() {
        startProgress = true;
        uploadTask = ref.putFile(file);
      });
      final snapShot = await uploadTask!.whenComplete(() {
        if(strAfterPhotosList.length==myImagePath.length)
          setState(() {
            uploadDone=true;
            startProgress=false;
          });

        // });
      });
      strAfterPhotosList.add(await snapShot.ref.getDownloadURL());
      setState(() {
        uploadTask = ref.putFile(file);
      });
    }
    setState(() {
      if(strAfterPhotosList.length==myImagePath.length)
         uploadDone=true;
        startProgress=false;
    });
  }
//  List<File?> imagePath=[];
//
//
//  final imagePicker = ImagePicker();
//
//  Future  getImage() async {
//    final image = await imagePicker.pickImage(source: ImageSource.camera);
//    setState(() {
//      imagePath.add(File(image!.path));
//    });
//  }

 Widget buildProgress() =>
     StreamBuilder<TaskSnapshot>(
         stream: uploadTask?.snapshotEvents,
         builder: (context,snapshot)
         {
           if (snapshot.hasError) {
             return Text(' Error ya Ahmed :: ${snapshot.error}');
           } else if (snapshot.hasData) {
             final task = snapshot.data!;
             double progress=task.bytesTransferred / task.totalBytes;

             return Padding(
               padding: const EdgeInsets.only(left:20.0,right:20,bottom: 10),
               child: SizedBox(
                 height: 50,
                 child: Stack(
                   fit: StackFit.expand,
                   children: [
                     LinearProgressIndicator(
                       value: progress,
                       backgroundColor: kprimaryColor,
                       color: Colors.grey,
                     ),
                     //  ((progress / 100 )!=1)?
                     Center(child: Text('${(100 * progress).roundToDouble()}%'),
                     )
                   ],
                 ),
               ),
             );
           } else {
             return Center(
               child:
               CircularProgressIndicator(),
             );
           }
         }
     );



}