import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/screens/drawer/offer/contoller/offercontoller.dart';
import 'package:vendor/screens/drawer/offer/view/addoffer.dart';
import 'package:vendor/screens/drawer/offer/view/offercrad.dart';
import 'package:vendor/widgets/Future_scafold.dart';

// class Offer extends StatefulWidget {
//   @override
//   _OfferState createState() => _OfferState();
// }

// class _OfferState extends State<Offer> {
//   Future value;
//   List offers = [];
//   Function updateState;

//   @override
//   void initState() {
//     super.initState();
//     value = getData();
//     updateState = () {
//       print("called");
//       setState(() {
//         value = null;
//         value = getData();
//       });
//     };
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Get.to(() => AddOffer());
//         },
//         child: Icon(Icons.add),
//       ),
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: AutoSizeText(
//           "offers",
//           style: TextStyle(color: Colors.white, fontSize: 20),
//           maxLines: 1,
//         ),
//       ),
//       body: SafeArea(
//         child: FutureBuilder(
//           builder: (context, AsyncSnapshot<dynamic> snap) {
//             if (snap.data != null) {
//               if (offers.length != 0) {
//                 return ListView.builder(
//                   itemCount: offers.length,
//                   itemBuilder: (context, index) {
//                     print(offers.length);
//                     return InkWell(
//                       onTap: () {
//                         // Get.to(() => EditeOffer(
//                         //       id: offers[index]["id"],
//                         //       ids: offers[index]["Offer_products"],
//                         //       price: offers[index]["price"],
//                         //     ));
//                       },
//                       child: Column(
//                         children: [
//                           OfferCard(
//                             id: offers[index]["id"],
//                             title: offers[index]["id"],
//                             image: offers[index]["image"],
//                             updateState: updateState,
//                           ),
//                           Divider(
//                             color: Theme.of(context).primaryColor,
//                             thickness: 1.5,
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               } else
//                 return Center(child: Text("no offers to show it"));
//             }
//             return Center(
//               child: CircularProgressIndicator(
//                 backgroundColor: Colors.white,
//               ),
//             );
//           },
//           future: value,
//         ),
//       ),
//     );
//   }

//   Future getData() async {
//     offers = await OfferController.getOffer();
//     return offers;
//   }
// }
//var dataoffer;

class Offer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureScafold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Get.off(() => AddOffer());
        },
        child: Icon(Icons.add),
      ),
      nameScreen: "offer",
      fetchData: () {
        return OfferController.getOffer();
      },
      itemBuilder: (context, index, offers, setState) {
        print(offers.length);
        return InkWell(
          onTap: () {
            // Get.to(() => EditeOffer(
            //       id: offers[index]["id"],
            //       ids: offers[index]["Offer_products"],
            //       price: offers[index]["price"],
            //     ));
          },
          child: Column(
            children: [
              OfferCard(
                  id: offers[index]["id"],
                  title: offers[index]["id"],
                  image: offers[index]["image"],
                  updateState: setState),
              Divider(
                color: Theme.of(context).primaryColor,
                thickness: 1.5,
              ),
            ],
          ),
        );
      },
    );
  }
}
