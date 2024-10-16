
import 'package:arrow_merchandising/view/screens/mechandiser%20list/profile_data.dart';
import 'package:arrow_merchandising/view/screens/super_visor/super_app_bar.dart';
import 'package:arrow_merchandising/models/merchandisers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:arrow_merchandising/const.dart';


class AndroidSuperClientList extends StatefulWidget {
  final int id, phone;
  final String profileImage, city, role, nationality;
  final String market,marketImage, name;
  //final List<String> mycollection;
  const AndroidSuperClientList({
    super.key,
    required this.market,
    required this.name,
   required this.marketImage,
    required this.profileImage,
    required this.city,
    //required this.branch,
    required this.id,
    required this.phone,
   // required this.marketDetails,
    required this.nationality,
    required this.role,
  });

  @override
  State<AndroidSuperClientList> createState() => _AndroidSuperClientListState();
}

class _AndroidSuperClientListState extends State<AndroidSuperClientList> with TickerProviderStateMixin {


  TextEditingController searchController=TextEditingController();
  String searchResult="";

  List<String>
  namesList = [],
  nationalitiesList=[],
  carslist=[],
  photos=[];
  List<int>
  phonesList=[],
  natId=[];
  Future getId() async {
    await FirebaseFirestore.instance
        .collection("Merchandisers")
    //.orderBy('branch_id')
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((element) {
        FirebaseFirestore.instance
            .collection("Merchandisers")
            .doc(element.reference.id)
            .get()
            .then((value) {
          Map<String, dynamic> data = value.data() as Map<String, dynamic>;
         // if(
          if(
          (!namesList.contains(data['full_name']))
          &&
          (!nationalitiesList.contains(data['nationality']))
          &&
          (!phonesList.contains(data['phone']))
          &&
          (!carslist.contains(data['car_details']))
          &&
          (!photos.contains(data['profile_image']))
          &&
          (!natId.contains(data['id']))

          )
          {
          namesList.add(data['full_name']);
          nationalitiesList.add(data['nationality']);
          carslist.add(data['car_details']);
          phonesList.add(data['phone']);
          photos.add(data['profile_image']);
          natId.add(data['id']);
          }
        });
      });
    });
    print("All Data Added");
  }

  //
  // double screenHieght=0.0;
  // double screenWidth=0.0;
  // bool startAnimation=false;
  List<String>  marketList = [];

  // List<String> selectedMerchList = [];

  Future getAllMerch() async {
    // get Merchandiser
    await FirebaseFirestore.instance
        .collection('Merchandisers')
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((element) {
        FirebaseFirestore.instance
            .collection("Merchandisers")
            .doc(element.reference.id)
            .get()
            .then((value) {
          Map<String, dynamic> data = value.data() as Map<String, dynamic>;
          // print(data['name']);
          if (marketList.contains(data['market'])) {

          }else{
            marketList.add(data['market']);
          }
        });
      });
    });
  }
    @override
  void initState() {
    // TODO: implement initState
    getId();
    getAllMerch();
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   setState(() {
    //
    //     startAnimation=true;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    //
    // screenHieght=MediaQuery.of(context).size.height;
    // screenWidth=MediaQuery.of(context).size.width;
    // TabController _tabController = TabController(length: 2, vsync: this);
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kprimaryColor,
          title: SuperAppBar(
            comeFrom: "Merchandisers",
            title: "Merchandisers List",
            //manegerName: widget.manegerName,
            phone: widget.phone,
            market: widget.market,
            marketImage: "",
            branch:"All Branches",
            username: widget.name,
            profileImage: widget.profileImage,
          )),
      body: ListView(
         shrinkWrap: true,
        children: <Widget>[
          const SizedBox(height: 8),
          (searchResult=="")
          ?Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
               // color: kprimaryColor.withOpacity(0.4)
            ),
            child: StreamBuilder<List<Merchandiser>>(
                stream: (widget.market=="All Markets")?readMerchandisers():readMarketMerchandisers(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text(' Error ya Ahmed :: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final users = snapshot.data!;
                    return  GridView.count(
                        childAspectRatio: 0.9,
                        crossAxisCount: 2,
                        primary: false,
                        // crossAxisSpacing:2,
                        //mainAxisSpacing: 2.0,
                      shrinkWrap: true,
                    children:users.map(buildCard).toList()
                    //  children: users.map(buildMerchandiser).toList(),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          )
              //?(searchResult!="")
          :Container(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  itemCount:namesList.length,
                  itemBuilder:(context,index){
                    if(
                    namesList[index].toUpperCase().contains(searchResult.toUpperCase())
                    ||
                    namesList[index].contains(searchResult)
                    ||
                    namesList[index].toString().startsWith(searchResult)
                    ||
                    namesList[index].toUpperCase().toString().startsWith(searchResult.toUpperCase())
                    )
                    {
                      return ListTile(
                          leading: Container(
                            padding: EdgeInsets.only(left: 5, right: 12,),
                            decoration:
                            BoxDecoration(borderRadius: BorderRadius.circular(15)),
                            child: Image.network(photos[index]),
                          ),
                          title: Text(namesList[index]),
                          subtitle: Text('${natId[index]}'),
                          onTap: () {
                            Get.to(() => AndroidProfileData(
                                merchName: namesList[index],
                                merchNationality:  nationalitiesList[index],
                                merchcarDetails:  carslist[index],
                                merchProfileImage:  photos[index] ,
                                merchPhone: phonesList[index],
                                merchNatId:  natId[index],
                                marketImage:widget. marketImage,
                                role:widget.role,
                                city: widget.city,
                                branch: "All Branches",
                                nationality: widget.nationality,
                                //marketDetails: widget.marketDetails,
                                id: widget.id,
                                phone: widget.phone,
                                market: widget.market,
                                name: widget.name,
                                // marketImage: widget.marketImage,
                                profileImage: widget.profileImage));
                          }

                      );
                    }
                    return null;
                  }
              )
          ),

          //  ),
        ],
      ),
    );
  }

Widget buildCard(Merchandiser merchandiser){
  return
    InkWell(
        onTap: () {
                Get.to(() => AndroidProfileData(
                    merchName:   merchandiser.fullName,
                    merchNationality:  merchandiser.nationality,
                    merchcarDetails:  merchandiser.carDetails,
                    merchProfileImage:  merchandiser.profileImage ,
                    merchPhone:  merchandiser.phone,
                    merchNatId:  merchandiser.id,
                    marketImage:widget. marketImage,
                    role:widget.role,
                    city: widget.city,
                    branch: "All Branches",
                    nationality: widget.nationality,
                    //marketDetails: widget.marketDetails,
                    id: widget.id,
                    phone: widget.phone,
                    market: widget.market,
                    name: widget.name,
                   // marketImage: widget.marketImage,
                    profileImage: widget.profileImage));
              },
      child: Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      elevation: 7.0,
      child: Column(
        children: <Widget>[
          SizedBox(height: 12.0,),
          Stack(children: <Widget>[
            Container(
                height: 60.0,
                width: 60.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.blueGrey,
                  image: DecorationImage(
                      image: NetworkImage(
                    merchandiser.profileImage
                  )
                  ),
                )
            ),
            Container(
              margin: EdgeInsets.only(left: 35),
              height: 20.0,
              width: 20.0,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
                  color:merchandiser.status=="Out Duty"? kprimaryColor:Colors.amber,
                  border: Border.all(color: Colors.white,
                      style: BorderStyle.solid,
                      width: 2.0
                  )

              ),
            )
          ]),
          SizedBox(height: 8.0,),
          Text(
            merchandiser.fullName,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontWeight: FontWeight.bold),),
          SizedBox(height: 5.0,),
          Text(
            merchandiser.status,
            style: TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.bold),),
          SizedBox(height: 15,),
          Expanded(child: Container(width: 175.0,
            //padding: EdgeInsets.all(10),
            // height: 20,
            decoration: BoxDecoration(color:merchandiser.status=='Available'? Colors.grey :kprimaryColor,
              // borderRadius: BorderRadius.circular(20)
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25.0),
                  bottomRight: Radius.circular(25.0)
              ),

            ),
            child: Center(child: Text("Details".tr.toUpperCase(),
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
            )
              ,),
          ),

          ),
          SizedBox(height: 10,),

        ],
        //  )
        //],
      ),
      ),
    );
}

  Stream<List<Merchandiser>> readMerchandisers() => FirebaseFirestore.instance
      .collection('Merchandisers')
 // .where("market",
     // whereIn:[widget.market,'All Markets'])
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => Merchandiser.fromJson(doc.data()))
          .toList());

  Stream<List<Merchandiser>> readMarketMerchandisers() => FirebaseFirestore.instance
      .collection('Merchandisers')
      .where("market",
      isEqualTo:widget.market)
      .snapshots()
      .map((snapshot) => snapshot.docs
      .map((doc) => Merchandiser.fromJson(doc.data()))
      .toList());
}
//}
