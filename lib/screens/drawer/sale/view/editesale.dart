import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/screens/drawer/profile/textfield_editing_vendor.dart';
import 'package:vendor/screens/drawer/sale/controller/salecontoller.dart';
import 'package:vendor/screens/drawer/sale/view/sales.dart';

class EditeSale extends StatelessWidget {
  int id;
  var ids;
  double price;
  double newprice;

  EditeSale({Key key, this.id, this.ids, this.price}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Edit Sale"),
      ),
      bottomNavigationBar: FloatingActionButton(
        isExtended: true,
        child: Text("sumbit"),
        onPressed: () async {
          print(id);
          var body = await SaleController.saleEdit(id, price);
          if (body == false) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: Duration(seconds: 1),
              content: Text("error"),
              backgroundColor: Theme.of(context).primaryColor,
            ));
            return;
          }
          if (newprice > price) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: Duration(seconds: 1),
              content: Text("cannot discount be more than price "),
              backgroundColor: Theme.of(context).primaryColor,
            ));
            return;
          }
          Get.off(() => Sales());
        },
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Text("Sale id :$id"),
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
                  newprice = double.parse(value);
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
