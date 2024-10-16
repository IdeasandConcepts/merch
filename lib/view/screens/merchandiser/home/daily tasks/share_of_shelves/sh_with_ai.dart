

import 'dart:convert';
import 'dart:io';
import 'package:arrow_merchandising/view/components/default_button.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/merch_nav_bar.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/profile/branch_appbar.dart';
import 'package:arrow_merchandising/view/widgets/custom_dropdown.dart';
import 'package:arrow_merchandising/const.dart';
import 'package:arrow_merchandising/models/ai_share_model.dart';
import 'package:arrow_merchandising/models/share_products.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';




class ShareWithAi extends StatefulWidget {
  final int id, phone, adminPhone;
  final String username,
      marketImage,
      profileImage,
      branch,
      place,
      market,
      nationality,
  manegerName;
  final String orderBy,taskType;
  const ShareWithAi(
      {super.key,
        required this.orderBy,
        required this.place,
        required this.username,
        required this.marketImage,
        required this.profileImage,
        required this.branch,
        required this.market,
        required this.id,
        required this.phone,
        required this.nationality,
        required this.manegerName,
        required this.adminPhone, required this.taskType});


  //final String title;

  @override
  State<ShareWithAi> createState() => _ShareWithAiState();
}

class _ShareWithAiState extends State<ShareWithAi> {
  TextEditingController fullShaleAreaController = TextEditingController();
  TextEditingController marketShaleAreaController = TextEditingController();

 // ScrollController _scrollController=ScrollController();
String imageSrc="";
  String productName="";
  File? selectedImage=null;
  String? message = "";
  String? greetings = '';
  //var resJson="";
  List<String> resJson=[];

  String product="";
 // String details="";
  double price=0;

  List<String> places = [
    "On Shelves",
    "On Display",
    "On Gandola",
    "On Back Door"
  ];
  String selectedPlace = "All Places";
  bool selectPlace=false;
  List<String> categories = [];
  String selectedCategory = "All Categories";


  List<String> productsCodesList = [];

  Future getId() async {
    await FirebaseFirestore.instance
        .collection("arrow_products")
        .orderBy("id", descending: false)
        .limit(700)
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((element) {
        FirebaseFirestore.instance
            .collection("arrow_products")
            .doc(element.reference.id)
            .get()
            .then((value) {
          Map<String, dynamic> data = value.data() as Map<String, dynamic>;
          // for (int i = 0; i < data.length; i++) {
          if (categories.contains(data['category'])) {
          } else {
            setState(() {
              categories.add(data['category']);
            });
            //  });
          }
          // }
        });
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      getId();
      selectedPlace = widget.place;
    });
    //getId();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  // List<String> arrnagedData=[];
  // List<String>finalProducts=[];
  //
  // List<String>allProducts=[
  //   "CHESE&CHILLI\t160",
  //   "SPICY\t160",
  //   "BBQ\t165",
  //   "HOT PAPRIKA\t165",
  //   "HTSPCY\t165",
  //   "KETCHUP\t165",
  //   "NACHOCHS\t165",
  //   "ORIGINAL\t165",
  //   "SLTVNGR\t165",
  //   "SRCRMONIN\t165",
  //   "BBQ\t200",
  //   "CHEESY CHESE\t200",
  //   "HOT PAPRIKA\t200",
  //   "HTSPCY\t200",
  //   "KETCHUP\t200",
  //   "ORIGINAL\t200",
  //   "SLTVNGR\t200",
  //   "SRCRMONIN\t200",
  //   "BBQ\t40",
  //   "HOT\t40",
  //   "HTSPCY\t40",
  //   "ORIGINAL\t40",
  //   "SLTVNGM\t40",
  //   "SRCRMONIN\t40",
  //   "BBQ\t70",
  //   "HTSPCY\t70",
  //   "ORIGINAL\t70",
  //   "SRCRMONIN\t70",
  // ];

  // List<String> data = List<String>.from(map['categories'] as List);
  double c=0.0;
  uploadImage() async {
    setState(() {
      startProgress=true;

    });
    final request = http.MultipartRequest(
        "POST",
        Uri.parse("${urlApi}/upload"));
    final headers = {"Content-type": "multipart/from-data"};
    request.files.add(http.MultipartFile("image",
        selectedImage!.readAsBytes().asStream(), selectedImage!.lengthSync(),
        filename: selectedImage!.path.split("/").last));
    request.headers.addAll(headers);
    final response = await request.send();
    http.Response res = await http.Response.fromStream(response);

    // message = resJson['message'];
    if(response.statusCode==200){
       resJson = jsonToList(jsonDecode(res.body));
       setState(() {
         c =  getShareArea();
         startProgress=false;
       });
      print("class is : $resJson ");
    }
    else
    {
      print("Error ${response.statusCode}");
    }

    final file=File(selectedImage!.path);
    final ref=
    FirebaseStorage.instance
        .ref().child("Share Pictures/"+DateTime.now().toString()+'.png');

      startProgress=true;
      uploadTask=ref.putFile(file);
    final snapShot=await uploadTask!.whenComplete(() {
      setState(() {
        uploadDone=true;
        startProgress=false;
      });
    });
    imageSrc=await snapShot.ref.getDownloadURL();
    print(imageSrc);
    setState(() {
      uploadTask=ref.putFile(file);
      uploadDone=true;
    });
    if((imageSrc!="")&&(uploadTask!=null))
      setState(() {
        uploadDone=true;
        startProgress=false;
      });
   // });

  }
String shelveCase="";
double  getShareArea(){
    int l=resJson.length;
    double r=l*9.52;
    c = 1235- r;

   // print(c);

    if(c<50)
      setState(() {
        shelveCase="Full Of Stock";
      });

     // print ("Full");
    else
     setState(() {
       shelveCase="Empty Area".tr+'\t'+'${c}';
     });
     // print ("Empty"+'\t'+'${c}');
return c;
  }
  List<T> jsonToList<T>(Object? responseData) {
    final temp = responseData as List? ?? <dynamic>[];
    final list = <T>[];
    for (final tmp in temp) {
      list.add(tmp as T);
    }
    return list;
  }

  Future getImage() async {
    final pickedImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      selectedImage = File(pickedImage!.path);
    });
  }
//  File? imagePath;


  final imagePicker = ImagePicker();

  Future  getCameraImage() async {
    final image = await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      selectedImage=(File(image!.path));

      //progress=false;

    });
  }
  // void arrange(){
  //   for(int i=0;i<resJson.length;i++)
  //     {
  //       if(!arrnagedData.contains(resJson[i]))
  //         {
  //           arrnagedData.add(resJson[i]);
  //         }
  //     }
  //   for(int j=0;j<arrnagedData.length;j++)
  //     {
  //       print(arrnagedData[j]);
  //     }
  // }
  // String convert (int index)
  // {
  //   String name;
  //   name=allProducts[index];
  //   return name;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kprimaryColor,
          title:
          MerchAppBar(
            // appBar: MerchAppBar(
            title: "Share Of Shelves",
            manegerName: widget.manegerName,
            phone: widget.phone,
            market: widget.market,
            marketImage: widget.marketImage,
            branch: widget.branch,
            username: widget.username,
            profileImage: widget.profileImage,
          ) ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20.h,right: 20.h),
            child: Container(

              child: Column(

                  children: [
                    // Text("Filter",
                    //     style: TextStyle(
                    //         fontWeight: FontWeight.w700, fontSize: 28.sp)),
                    SizedBox(height: 12.h),

                    // Shelve DropdownButton
                    (selectPlace != false)
                        ? CustomDropdownButton(
                        onChanged: (value) {},
                        onTap: () {},
                        hintText: selectedPlace.tr,
                        items: List.generate(
                          1,
                              (index) => DropdownMenuItem(
                              onTap: () {},
                              value: 1,
                              child: Text(selectedPlace.tr,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp))),
                        ))
                        : (widget.place != "All Places")
                        ? CustomDropdownButton(
                        onChanged: (value) {},
                        onTap: () {},
                        hintText: widget.place.tr,
                        items: List.generate(
                          1,
                              (index) => DropdownMenuItem(
                              onTap: () {},
                              value: 1,
                              child: Text(widget.place.tr,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp))),
                        ))
                        : CustomDropdownButton(
                        onChanged: (value) {},
                        onTap: () {},
                        hintText: selectedPlace.tr,
                        items: List.generate(
                          places.length,
                              (index) =>
                          // null)[
                          DropdownMenuItem(
                              onTap: () {
                                setState(() {
                                  selectedPlace = places[index];
                                  selectPlace = true;
                                });
                              },
                              value: 1,
                              child: Text("${places[index].tr}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp))),
                        )),
                   // SizedBox(height: 12.h),
                    //

                    SizedBox(height: 12.h),
                    // category
                    CustomDropdownButton(
                        onChanged: (value) {},
                        onTap: () {},
                        hintText: selectedCategory.tr,
                        items: List.generate(
                          categories.length,
                              (index) =>
                          // null)[
                          DropdownMenuItem(
                              onTap: () {
                                setState(() {
                                  selectedCategory = categories[index];
                                });
                              },
                              value: 1,
                              child: Text("${categories[index].tr}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp))),
                        )),
                  ]),
              // height: 130,
              // width: 340,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              SizedBox(height: 10,),
              selectedImage == null
                  ? Text("Please pick a Image to upload".tr)
                  : Image.file(
                  selectedImage!,
                  height:MediaQuery.of(context).size.height / 3,

                  width:MediaQuery.of(context).size.width-30
              ),


                SizedBox(height: 10,),
                Container(height: 50,
                  child: Center(
                    child: Text(
                    shelveCase.tr,
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                // SizedBox(height: 15,),
          //       if(c!=0.0)
          //       Container(
          //       child: Column(
          //       children: [
          //       SizedBox(height: 15,),
          //
          //
          //   ]),
          //
          // ),
                ]),
        ],
      ),

      floatingActionButton:(
          selectedCategory!="All Categories"
              &&


          selectedImage==null)? FloatingActionButton(
        backgroundColor: kprimaryColor,
        onPressed:  (){Get.defaultDialog(
            title: "",
            content: Column(children: [
              InkWell(
                  onTap: (){
                    getCameraImage();
                    Navigator.of(context).pop();
                  },
                  child: DefualtButton( selected: true,text: "From Camera".tr)),
              SizedBox(height: 10,),
              InkWell(
                  onTap: (){
                    getImage();

                    Navigator.of(context).pop();
                  },
                  child: DefualtButton( selected: true,text: "From Gallery".tr)),
            ],
            ));
        },
        child: Icon(Icons.add_a_photo,color: Colors.white,),
      ):null,

  bottomNavigationBar:(selectedImage!=null && shelveCase=="")?
  (startProgress==false)?
  Padding(
  padding: EdgeInsets.only(left: 15.h, right: 15.h, ),
  child: InkWell(
  onTap:() {
    uploadImage();
  },
  child: DefualtButton(text: "Calculate".tr, selected: true))):
  buildProgress():

  ( startProgress==false&&shelveCase!="")?
   InkWell(
      onTap: ()  {
       // if(doneTask==false)
      createShareTask(
          AiShareModel(
            taskType: widget.taskType,
            fullArea: 0.0,
            markerArea: 0.0,
            place: selectedPlace,
            selectedProducts: selectedCategory,
            orderBy: widget.orderBy,
            status: 'Done',
            branch: widget.branch,
            market: widget.market,
            madeBy: widget.username,
            taskDate: (DateFormat('yyyy-MM-dd')
                .format(DateTime.now())
                .toString()),
            taskTime: (DateFormat('kk:mm')
                .format(DateTime.now())
                .toString()),
            degree: c,
            imagePath:imageSrc,
          ));

      // if((doneTask=true)&&(uploadDone==true))
      // {

     },
     child: Padding(
     padding: const EdgeInsets.only(left:20.0,right:20,bottom: 10),
     child: DefualtButton( selected: true,
     text: 'Create Task'.tr,
     ),
     )

     //  ؟؟++++++؟؟ـ-ـ§
     ):

null
 // SizedBox(height: 20,)

    );
  }
  

Future createShareTask(AiShareModel rtvTask) async {
  final shareData =
  FirebaseFirestore.instance.collection('Share Of Shelves').doc();
  final json = rtvTask.tojson();
  await shareData.set(json);
setState(() {
  doneTask=true;
});
  if(doneTask==true)
    Get.offAll(() =>
        MerchNavBar(
            tab_index:(widget.taskType=="New Task")?1:2,
            manegerName: widget.manegerName,
            username: widget.username,
            marketImage: widget.marketImage,
            profileImage: widget
                .profileImage,
            branch: widget.branch,
            market: widget.market,
            id: widget.id,
            phone: widget.phone,
            //marketDetails:widget. marketDetails,
            nationality: widget.nationality,
            mangerphone: widget.adminPhone)
    );
  completeShareTasks.add(selectedPlace);

  //  final
}
//bool doneTask=false;

double markerArea = 0.0;

bool doneTask=false,uploadDone=false,startProgress=false;
UploadTask? uploadTask;

// Future uploadImage() async {
//
//     final file = File(selectedImage!.path!);
//     final ref =
//     FirebaseStorage.instance
//         .ref().child(selectedImage!.path!);
//     setState(() {
//       startProgress = true;
//       uploadTask = ref.putFile(file);
//     });
//     final snapShot = await uploadTask!.whenComplete(() {
//
//         setState(() {
//           uploadDone=true;
//            startProgress=false;
//         });
//
//       // });
//     });
//     imageSrc=(await snapShot.ref.getDownloadURL());
//     setState(() {
//       uploadTask = ref.putFile(file);
//     });
//
//   setState(() {
//     if(selectedImage!="") {
//      // im = imageSrc;
//       uploadDone = true;
//       startProgress = false;
//     }
//   });
// }

  //print(uploadDone);


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


