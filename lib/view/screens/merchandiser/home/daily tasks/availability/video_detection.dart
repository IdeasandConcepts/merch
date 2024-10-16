
import 'dart:math';
import 'package:arrow_merchandising/view/components/default_button.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/home/daily%20tasks/availability/availability.dart';
//import 'package:arrow_merchandising/android/merchandiser/home/daily%20tasks/invintory/inventory_screen.dart';
import 'package:arrow_merchandising/const.dart';
import 'package:arrow_merchandising/models/availability_products.dart';
//import 'package:arrow_merchandising/models/inventory_products.dart';
import 'package:arrow_merchandising/models/new_products.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vision/flutter_vision.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';

late List<CameraDescription> cameras;

class AvailabilityVideoDetection extends StatefulWidget {
  final int id, phone, managerPhone;
  final String marketImage,
      profileImage,
      username,
      managerName,
      branch,
      market,
      nationality;
  final String place,
      category,
      orderBy,taskType;
  const AvailabilityVideoDetection(
      {super.key,
        required this.managerPhone,
        required this.marketImage,
        required this.profileImage,
        required this.username,
        required this.branch,
        required this.market,
        required this.id,
        required this.phone,
        required this.nationality,
        required this.place,
        required this.managerName,
        required this.orderBy, required this.taskType, required this.category,


      });

  @override
  State<AvailabilityVideoDetection> createState() => _AvailabilityVideoDetectionState();

// List<Map<String, dynamic>> Allresult = [];
}

class _AvailabilityVideoDetectionState extends State<AvailabilityVideoDetection> {
  late CameraController controller;
  late FlutterVision vision;
  List<Map<String, dynamic>> yoloResults = [];
  List<Map<String, dynamic>> allResult = [];
  CameraImage? cameraImage;
  bool isLoaded = false;
  bool isDetecting = false;
  double confidenceThreshold = 0.5;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    try {
      cameras = await availableCameras();
      vision = FlutterVision();
      controller = CameraController(cameras[0], ResolutionPreset.high);
      await controller.initialize();
      await loadYoloModel();
      setState(() {
        isLoaded = true;
        isDetecting = false;
      });
    } catch (e) {
      print("Error initializing the camera or loading the model: $e");
    }
  }

  @override
  void dispose() {
    controller.dispose();
    vision.closeYoloModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    List<Widget> displayBoxesAroundRecognizedObjects(Size screen) {
      if (yoloResults.isEmpty) return [];
      double factorX = screen.width / (cameraImage?.height ?? 1);
      double factorY = screen.height / (cameraImage?.width ?? 1);

      Color colorPick = const Color.fromARGB(255, 50, 233, 30);

      return yoloResults.map((result) {

        double objectX = result["box"][0] * factorX;
        double objectY = result["box"][1] * factorY;
        double objectWidth = (result["box"][2] - result["box"][0]) * factorX;
        double objectHeight = (result["box"][3] - result["box"][1]) * factorY;

        return Positioned(
          left: objectX,
          top: objectY,
          width: objectWidth,
          height: objectHeight,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              border: Border.all(color: Colors.pink, width: 2.0),
            ),
            child: Text(
              "${result['tag']} ${(result['box'][4] * 100).toStringAsFixed(2)}%",
              style: TextStyle(
                background: Paint()..color = colorPick,
                color: const Color.fromARGB(255, 115, 0, 255),
                fontSize: 18.0,
              ),
            ),
          ),
        );
      }).toList();
    }

    if (!isLoaded) {
      return const Scaffold(
        body: Center(
          child: Text("Model not loaded, waiting for it"),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: CameraPreview(controller),
          ),
          ...displayBoxesAroundRecognizedObjects(size),
          Positioned(
            bottom: 75,
            width: MediaQuery.of(context).size.width,
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    width: 5, color: Colors.white, style: BorderStyle.solid),
              ),
              child: isDetecting
                  ? IconButton(
                onPressed: () async {
                  await stopDetection();
                  //
                  Get.defaultDialog(
                      title: "",
                      content: Column(
                        children: [
                          InkWell(
                              onTap: () {

                                //  getCameraImage();
                                Navigator.of(context).pop();
                              },
                              child: DefualtButton(
                                  selected: true, text: "Continue".tr)),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                              onTap: () {
                                // onTap: () {
                                startProgress = true;
                                for (int x = 0; x < allResult.length; x++) {
                                  // allresult
                                  tags.add(allResult[x]['tag']);
                                }
                                //  })
                                print(tags.length);
                                // for (int p = 0; p < result.length; p++) {
                                //   setState(() {
                                //     tags.add(result[p]['tag']);
                                //   });
                                // }
                                filterList();
                                if (startProgress == false)
                                  Get.to(() => Availability(
                                    category: widget.category,
                                      taskType: widget.taskType,
                                      place: widget.place,
                                      orderBy: widget.orderBy,
                                      //managerPhone: managerPhone, userName: userName, market: market, branch: branch, marketImage: marketImage, profileImage: profileImage, id: id, phone: phone, nationality: nationality, manegerName: manegerName))
                                      manegerName: widget.managerName,
                                      // tab_index: 2,
                                      username: widget.username,
                                      marketImage: widget.marketImage,
                                      profileImage: widget.profileImage,
                                      market: widget.market,
                                      branch: widget.branch,
                                      id: widget.id,
                                      phone: widget.phone,
                                      //marketDetails:widget. marketDetails,
                                      nationality: widget.nationality,
                                      managerPhone: widget.managerPhone));
                              },
                              child: DefualtButton(
                                  selected: true, text: "Finish Detection".tr)),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          // InkWell(
                          //     onTap: () {
                          //       getImage();
                          //
                          //       Navigator.of(context).pop();
                          //     },
                          //     child: DefualtButton(
                          //         selected: true, text: "From Gallery".tr)),
                        ],
                      ));
                  //
                },
                icon: const Icon(
                  Icons.stop,
                  color: Colors.red,
                ),
                iconSize: 50,
              )
                  : IconButton(
                onPressed: () async {
                  await startDetection();
                },
                icon: const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                ),
                iconSize: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> loadYoloModel() async {
    try {
      await vision.loadYoloModel(
        labels: 'assets/label.txt',
        modelPath: 'assets/yolos.tflite',
        modelVersion: "yolov8",
        numThreads: 1,
        useGpu: true,
      );
      setState(() {
        isLoaded = true;
      });
    } catch (e) {
      print("Error loading YOLO model: $e");
    }
  }

  Future<void> yoloOnFrame(CameraImage cameraImage) async {
    try {
      final result = await vision.yoloOnFrame(
        bytesList: cameraImage.planes.map((plane) => plane.bytes).toList(),
        imageHeight: cameraImage.height,
        imageWidth: cameraImage.width,
        iouThreshold: 0.4,
        confThreshold: 0.4,
        classThreshold: 0.5,
      );
      if (result.isNotEmpty) {
        setState(() {
          yoloResults = result;

          print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
          print(yoloResults);
          // widget.A
          allResult=filterDetections(result);
          print("******************************/");
          print(allResult);
          // Append filtered results
        });
      }
    } catch (e) {
      print("Error during YOLO detection: $e");
    }
  }
  List<Map<String, dynamic>> filteredResults = [];
  List<Map<String, dynamic>> filterDetections(List<Map<String, dynamic>> detections) {


    for (var i = 0; i < detections.length; i++) {
      var currentDetection = detections[i];
      bool isDuplicate = false;

      for (var j = 0; j < filteredResults.length; j++) {
        var existingDetection = filteredResults[j];

        double iou = calculateIOU(
          currentDetection["box"],
          existingDetection["box"],
        );

        if (iou > .5) {
          // If IOU is high, consider it a duplicate
          isDuplicate = true;
          print("isDuplicate");
          print(isDuplicate);
          break;
        }
      }

      if (!isDuplicate) {
        filteredResults.add(currentDetection);
      }
    }
    print("filteredResults");
    print(filteredResults);
    return filteredResults;
  }

  double calculateIOU(List<double> boxA, List<double> boxB) {
    double xA = max(boxA[0], boxB[0]);
    double yA = max(boxA[1], boxB[1]);
    double xB = min(boxA[2], boxB[2]);
    double yB = min(boxA[3], boxB[3]);

    double intersection = max(0, xB - xA + 1) * max(0, yB - yA + 1);
    double boxAArea = (boxA[2] - boxA[0] + 1) * (boxA[3] - boxA[1] + 1);
    double boxBArea = (boxB[2] - boxB[0] + 1) * (boxB[3] - boxB[1] + 1);

    double iou = intersection / (boxAArea + boxBArea - intersection);

    return iou;
  }

  Future<void> startDetection() async {
    setState(() {
      isDetecting = true;
    });
    if (controller.value.isStreamingImages) {
      return;
    }
    await controller.startImageStream((image) async {
      if (isDetecting) {
        cameraImage = image;
        await yoloOnFrame(image);
      }
    });
  }

  Future<void> stopDetection() async {
    print("all result *************************************************");
    print(allResult);
    setState(() {
      isDetecting = false;
      yoloResults.clear();
    });
    await controller.stopImageStream();
  }
  void filterList() {
//    var ascading = resJson..sort();
    for (int h = 0; h < tags.length; h++) {
      tags.sort((a, b) => a.compareTo(b));
    }
    print(tags.length);
    for (int k = 0; k < tags.length; k++) {
      // tags.sort((a,b)=>a.compareTo(b));
      // print(tags[k]);
      if (!selectedJsonProducts.contains(tags[k])) {
        setState(() {
          selectedJsonProducts.add(tags[k]);
          selectedNewJsonProducts.add(tags[k]);
          newJson.add(JsonProduct(product: tags[k], prAmount: 1));
        });
      } else {
        for (int x = 0; x < selectedJsonProducts.length; x++) {
          if (newJson[x].product == tags[k]) {
            setState(() {
              newJson[x].prAmount = newJson[x].prAmount + 1;
            });
          } else {}
        }
      }
    }

    print("..........");

    for (int p = 0; p < newJson.length; p++) {
      getId(int.parse(newJson[p].product), newJson[p].prAmount);
    }
    setState(() {
      startProgress = false;
    });
    print(newJson.length);
    newJson = [];
    selectedJsonProducts = [];
    selectedNewJsonProducts = [];
    print(availabilityTaskDetails.length);
    // if(rTVTaskDetails.length>0
    // &&startProgress==false)
    // Get.to(()=> RTVWithAiReview(
    //   taskType: widget.taskType,
    //   // rtvProduct: rTVTaskDetails,
    //   orderBy: widget.orderBy,
    //   //imageSrc: ,
    //   manegerName: widget.managerName,
    //   phone: widget.phone,
    //   managerPhone: widget.managerPhone,
    //   market: widget.market,
    //   marketImage: widget.marketImage,
    //   username: widget.username,
    //   profileImage: widget.profileImage,
    //   place:widget.place,
    //   nationality: widget.nationality,
    //   branch: widget.branch,
    //   id: widget.id,
    // ));
  }

  List<String> tags = [];
  Future getId(int id, int amount) async {
    await FirebaseFirestore.instance
        .collection("arrow_products")
        .where("id", isEqualTo: id)
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
          //  for (int k = 0; k < data.length; k++)
              {
            if (data['id'] == (id)) {
              setState(() {
                availabilityTaskDetails.add(AvailabilityProduct(
                  //rType: widget.taskType,
                  image: data['photo'],
                  weight: data['weight'],
                  prCategory: data['category'],
                  product: data['product_name'] + "\t" + "${data["weight"]}",
                  prAmount: amount,
                  //pType:"Piece"
                ));

                print(
                  data['product_name'] + "\t" + "${data["weight"]}",
                );
              });
            }
          }
        });
      });
    });
    // for (int i = 0; i < rTVTaskDetails.length; i++) {
  }
  bool startProgress = false;
  UploadTask? uploadTask;

  // UploadTask? uploadTask;
  // bool progress = false;
  // bool doneTask = false, uploadDone = false, startProgress = false;
  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
      stream: uploadTask?.snapshotEvents,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(' Error ya Ahmed :: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final task = snapshot.data!;
          double progress = task.bytesTransferred / task.totalBytes;

          return Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 10),
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
                  Center(
                    child: Text('${(100 * progress).roundToDouble()}%'),
                  )
                ],
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      });
}
