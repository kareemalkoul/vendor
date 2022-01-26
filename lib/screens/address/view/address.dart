import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get.dart';
import 'package:vendor/screens/address/view/editaddress.dart';
import 'package:vendor/widgets/profileinfo.dart';
import 'package:flutter/material.dart';
import 'package:vendor/configs/size.dart';

class Address extends StatefulWidget {
  var city;
  var country;
  var street;
  var nearTo;
  var name;
  var id;
  Function updateState;
  Address(
      {this.city,
      this.nearTo,
      this.street,
      this.country,
      this.name,
      this.id,
      this.updateState});
  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {
  var city;
  var country;
  var street;
  var nearTo;
  var name;
  var id;
  Map<String, dynamic> map;
  Function updateState;

  void init() {
    city = widget.city;
    country = widget.country;
    street = widget.street;
    name = widget.name;
    nearTo = widget.nearTo;
    id = widget.id;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
    updateState = () {
      setState(() {
        name = map["name"];
        country = map["country"];
        city = map["city"];
        street = map["street"];
        nearTo = map["nearTo"];
      });
      widget.updateState();
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: AutoSizeText(
          "addresses",
          style: TextStyle(color: Colors.white, fontSize: 20),
          maxLines: 1,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Get.to(
                  () => EditAddress(
                    city: city,
                    street: street,
                    country: country,
                    name: name,
                    id: id,
                    nearTo: nearTo,
                  ),
                );
              })
        ],
      ),
      body: SingleChildScrollView(
          child: Center(
        child: Column(
          children: [
            SizedBox(
              height: getHeight(80),
            ),
            AutoSizeText(
              "$name",
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
              maxLines: 1,
            ),
            SizedBox(
              height: getHeight(40),
            ),
            ProfileInfo(
              text: "country",
              borderColor: Theme.of(context).primaryColor,
              containerColor: Colors.white,
              height: getHeight(50.0),
              width: getWidth(330),
              child: Center(child: Text("$country")),
            ),
            SizedBox(height: getHeight(30)),
            ProfileInfo(
              text: "city",
              borderColor: Theme.of(context).primaryColor,
              containerColor: Colors.white,
              height: getHeight(50.0),
              width: getWidth(330),
              child: Center(child: Text("$city")),
            ),
            SizedBox(height: getHeight(30)),
            ProfileInfo(
              text: "street",
              borderColor: Theme.of(context).primaryColor,
              containerColor: Colors.white,
              height: getHeight(50.0),
              width: getWidth(330),
              child: Center(child: Text("$street")),
            ),
            SizedBox(height: getHeight(30)),
            ProfileInfo(
              text: "near to",
              borderColor: Theme.of(context).primaryColor,
              containerColor: Colors.white,
              height: getHeight(200.0),
              width: getWidth(330),
              child: Center(child: Text("$nearTo")),
            ),
            SizedBox(height: getHeight(30)),
          ],
        ),
      )),
    );
  }
}
