import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/screens/drawer/offer/contoller/offercontoller.dart';
import 'package:vendor/screens/drawer/profile/textfield_editing_vendor.dart';

class EditeOffer extends StatelessWidget {
  int id;
  var ids;
  int price;

  EditeOffer({Key key, this.id, this.ids, this.price}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit  offer"),
      ),
      bottomNavigationBar: FloatingActionButton(
        isExtended: true,
        child: Text("sumbit"),
        onPressed: () async {
          var body = await OfferController.OfferEdit(price, id);
          if (body == false) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: Duration(seconds: 1),
              content: Text("error"),
              backgroundColor: Theme.of(context).primaryColor,
            ));
            return;
          }
          Get.back();
        },
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Text("offer id $id"),
              SizedBox(
                height: 30,
              ),
              Text("product ids $ids"),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 30,
              ),
              VendorRowInfoEditing(
                onChanged: (value) {
                  price = int.parse(value);
                },
                descraption: "$price",
                title: "price",
              )
            ],
          ),
        ),
      ),
    );
  }
}
