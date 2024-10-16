


import 'package:arrow_merchandising/view/widgets/prooduct_widget.dart';
import 'package:arrow_merchandising/models/rtv_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';



class AndroidRTVTaskBody extends StatefulWidget {
  final int id, phone,managerPhone;
  final String username,
      marketImage,
      profileImage,
      branch,
      market,
      nationality,
  place,
  comeFrom;
  const AndroidRTVTaskBody(
      {super.key,
        required this.username,
        required this.marketImage,
        required this.profileImage,
        required this.branch,
        required this.market,
        required this.id,
        required this.phone,
        required this.nationality,
        required this.place,
        required this.comeFrom,
        required this.managerPhone});
  //const RTVTaskBody({super.key});
  @override
  State<AndroidRTVTaskBody> createState() => _AndroidRTVTaskBodyState();
}

class _AndroidRTVTaskBodyState extends State<AndroidRTVTaskBody> {

  // ScrollController _scrollController=ScrollController();
  //
  // bool startProgress=false;
  //
  // var _sellectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.brown,
      height:(widget.comeFrom=="Normal")?
      (MediaQuery.of(context).size.height / 2.7).h:
      (MediaQuery.of(context).size.height * 0.84),
   //    decoration: BoxDecoration(
   //        color: Colors.blue,
   //        borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0),
   //        )
   //    ),
      child:
       //  List.generate(length, (index) => null)
      ListView.builder(
        itemCount:   rTVTaskDetails.length,
        itemBuilder: (context, index) =>


            Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Dismissible(
              key: Key(  rTVTaskDetails[index].toString()),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                setState(() {
                  rTVTaskDetails.removeAt(index);
                });
              },
              background: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.grey,
                    //Color(0xFFFFF6E6),
                    borderRadius: BorderRadius.circular(15)),
                child: Row(children: [
                  Spacer(),
                  SvgPicture.asset("assets/icons/Trash.svg")
                ]),
              ),
              child:RTVProductWidget(
              //   count: 1,
              // product: rTVTaskDetails[index],
              // image: ,
              //AndroidCartItemCard(
                merchTask:   rTVTaskDetails[index],
                //index: index,
              )),
        ),
      ),
    );
  }
//   bool uploadDone = false;
//   UploadTask? uploadTask;
//
//   File? imagePath;
//
//   final imagePicker = ImagePicker();
//
//   Future  getImage() async {
//     final image = await imagePicker.pickImage(source: ImageSource.camera);
//     setState(() {
//       imagePath=File(image!.path);
//      // displayRTVPhotos.add(imagePath);
//     });
//   }
//   // //String rtvImage="";
//   //
//   Future uploadDisplayImage() async {
//     // final file = File(displayRTVPhotos[0]!.path!);
//     // final ref =
//     // FirebaseStorage.instance
//     //     .ref().child(displayRTVPhotos[0]!.path!);
//     // setState(() {
//     //   startProgress= true;
//     //   uploadTask = ref.putFile(file);
//     // });
//
//     //buildProgress();
//
//     final snapShot = await uploadTask!.whenComplete(() {
//       setState(() {
//         uploadDone = true;
//         startProgress = true;
//       });
//     });
//     String productImage = await snapShot.ref.getDownloadURL();
//     setState(() {
//     //  uploadTask = ref.putFile(file);
//     });
//     if ((productImage != "") && (uploadTask != null))
//       setState(() {
//         uploadDone = true;
//         startProgress = false;
//       });
//   }
//
//   //
//   Widget buildProgress() =>
//       StreamBuilder<TaskSnapshot>(
//           stream: uploadTask?.snapshotEvents,
//           builder: (context, snapshot) {
//             if (snapshot.hasError) {
//               return Text(' Error ya Ahmed :: ${snapshot.error}');
//             } else if (snapshot.hasData) {
//               final task = snapshot.data!;
//               double progress = task.bytesTransferred / task.totalBytes;
//
//               return Padding(
//                 padding: const EdgeInsets.only(
//                     left: 20.0, right: 20, bottom: 10),
//                 child: SizedBox(
//                   height: 50,
//                   child: Stack(
//                     fit: StackFit.expand,
//                     children: [
//                       LinearProgressIndicator(
//                         value: progress,
//                         backgroundColor: kprimaryColor,
//                         color: Colors.grey,
//                       ),
//                       //  ((progress / 100 )!=1)?
//                       Center(
//                         child: Text('${(100 * progress).roundToDouble()}%'),
//                       )
//                     ],
//                   ),
//                 ),
//               );
//             } else {
//               return Center(
//                 child:
//                 CircularProgressIndicator(),
//               );
//             }
//           }
//       );
}
//
