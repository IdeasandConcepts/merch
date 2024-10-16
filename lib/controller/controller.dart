//
// import 'package:get/get.dart';
// import 'package:get/get_rx/get_rx.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
//
// class Controller extends GetxController
// {
//   RxString initDrop1="Shelf".obs;
//   RxString initDrop2="Category".obs;
//   RxString initDrop3="Product".obs;
//   RxList isSelectCat=[false,false,false].obs;
//   RxList isSelectCat2=[false,false,false].obs;
// }


import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends GetxController{

  @override
  void onInit(){
    super.onInit();
  }
  @override
  void onReady(){
    super.onReady();
  }
  @override
  void onClose(){
    super.onClose();
  }

  @override
  var selectedImagePath =''.obs;
  void getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);

    if(pickedFile!=null) {
      //setState(() {
      selectedImagePath.value = pickedFile.path;
      //(File(image!.path));
     // imageSrc = selectedImage!.toString();
      // startProgress = false;
      // });
    }
    else
    {
      print("No Image selected");
    }
  }
}