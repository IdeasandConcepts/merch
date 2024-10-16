
import 'package:arrow_merchandising/view/widgets/availability_product_widget.dart';
import 'package:arrow_merchandising/models/availability_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';


class AndroidAvailabilityTaskBody extends StatefulWidget {
  final int id, phone, managerPhone;
  final String username, marketImage, profileImage, branch, market, nationality;
  final String comeFrom;
  //marketDetails;
  const AndroidAvailabilityTaskBody(
      {super.key,
      required this.username,
      required this.marketImage,
      required this.profileImage,
      required this.branch,
      required this.market,
      required this.id,
      required this.phone,
      required this.nationality,
      required this.comeFrom,
      required this.managerPhone});
  //const InventoryTaskBody({super.key});
  @override
  State<AndroidAvailabilityTaskBody> createState() =>
      _AndroidAvailabilityTaskBodyState();
}

class _AndroidAvailabilityTaskBodyState
    extends State<AndroidAvailabilityTaskBody> {
//  ScrollController _scrollController = ScrollController();

  //bool startProgress = false;


  @override
  Widget build(BuildContext context) {
    return Container(
      height:(widget.comeFrom=="Normal")?
      (MediaQuery.of(context).size.height / 2.4).h:
      (MediaQuery.of(context).size.height * 0.84),
      //350.h,
      //20.0,
      // decoration: BoxDecoration(
      //     color: Colors.white,
      //     borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0),
      //     )
      // ),
      child: Padding(
        padding:
            EdgeInsets.only(left: 15.h, right: 15.h, ),
        child: ListView.builder(
          itemCount: availabilityTaskDetails.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(top:8.0),
            child: Dismissible(
                key: Key(availabilityTaskDetails[index].toString()),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  setState(() {
                    availabilityTaskDetails.removeAt(index);
                  });
                },
                background: Container(
                  //padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      //Color(0xFFFFF6E6),
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(children: [
                    Spacer(),
                    SvgPicture.asset("assets/icons/Trash.svg")
                  ]),
                ),
                child: CartItemCard(
                  comefrom: widget.comeFrom,
                //  index: index,
                  merchTask: availabilityTaskDetails[index],
                )),
          ),
        ),
      ),
    );
  }

  bool uploadDone = false;
  // UploadTask? uploadTask;
  //
  // File? imagePath;
  //
  // final imagePicker = ImagePicker();
  //
  // Future getImage() async {
  //   final image = await imagePicker.pickImage(source: ImageSource.camera);
  //   setState(() {
  //     imagePath = File(image!.path);
  //     availabilityDisplayPhotos.add(imagePath);
  //   });
  // }

  // //String rtvImage="";
  //
  // Future uploadDisplayImage() async {
  //   final file = File(availabilityDisplayPhotos[0]!.path!);
  //   final ref = FirebaseStorage.instance
  //       .ref()
  //       .child(availabilityDisplayPhotos[0]!.path!);
  //   setState(() {
  //     startProgress = true;
  //     uploadTask = ref.putFile(file);
  //   });
  //
  //   //buildProgress();
  //
  //   final snapShot = await uploadTask!.whenComplete(() {
  //     setState(() {
  //       uploadDone = true;
  //       startProgress = true;
  //     });
  //   });
  //   String productImage = await snapShot.ref.getDownloadURL();
  //   setState(() {
  //     uploadTask = ref.putFile(file);
  //   });
  //   if ((productImage != "") && (uploadTask != null))
  //     setState(() {
  //       uploadDone = true;
  //       startProgress = false;
  //     });
  // }
  //
  // //
  // Widget buildProgress() => StreamBuilder<TaskSnapshot>(
  //     stream: uploadTask?.snapshotEvents,
  //     builder: (context, snapshot) {
  //       if (snapshot.hasError) {
  //         return Text(' Error ya Ahmed :: ${snapshot.error}');
  //       } else if (snapshot.hasData) {
  //         final task = snapshot.data!;
  //         double progress = task.bytesTransferred / task.totalBytes;
  //
  //         return Padding(
  //           padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 10),
  //           child: SizedBox(
  //             height: 50,
  //             child: Stack(
  //               fit: StackFit.expand,
  //               children: [
  //                 LinearProgressIndicator(
  //                   value: progress,
  //                   backgroundColor: kprimaryColor,
  //                   color: Colors.grey,
  //                 ),
  //                 //  ((progress / 100 )!=1)?
  //                 Center(
  //                   child: Text('${(100 * progress).roundToDouble()}%'),
  //                 )
  //               ],
  //             ),
  //           ),
  //         );
  //       } else {
  //         return Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       }
  //     });
}

