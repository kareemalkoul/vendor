import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get.dart';
import 'package:vendor/screens/address/controller/addresscontroller.dart';
import 'package:vendor/screens/address/view/alladdresses.dart';
import 'package:vendor/screens/home/view/home.dart';
import 'package:vendor/widgets/mybutton.dart';
import 'package:vendor/widgets/mytextfield.dart';
import 'package:flutter/material.dart';
import 'package:vendor/configs/size.dart';

class AddAddress extends StatefulWidget {
  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  var city;
  var country;
  var street;
  var nearTo;
  var type = "Home";
  var name;

  bool loading = false;

  List<DropdownMenuItem> gender = [
    DropdownMenuItem(
      child: AutoSizeText(
        "Home",
        style: TextStyle(color: Colors.lightBlue),
        maxLines: 1,
      ),
      value: "Home",
    ),
    DropdownMenuItem(
      child: AutoSizeText(
        "Work",
        style: TextStyle(color: Colors.lightBlue),
        maxLines: 1,
      ),
      value: "Work",
    )
  ];
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: AutoSizeText(
          "add address",
          style: TextStyle(color: Colors.white, fontSize: 20),
          maxLines: 1,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: loading
          ? Center(
              child: SizedBox(
                height: getHeight(200),
                width: getWidth(200),
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              ),
            )
          : SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: getHeight(20),
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: getWidth(50),
                            ),
                            AutoSizeText(
                              "name" + " :",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                              maxLines: 1,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: getWidth(340),
                          child: MyTextField(
                            type: 3,
                            borderColor: Theme.of(context).primaryColor,
                            hintText: "",
                            hintTextColor: Theme.of(context).primaryColor,
                            textColor: Theme.of(context).primaryColor,
                            valControl: (value) {
                              name = value;
                              print(name);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getHeight(30),
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: getWidth(50),
                            ),
                            AutoSizeText(
                              "country" + " :",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                              maxLines: 1,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: getWidth(340),
                          child: MyTextField(
                            type: 3,
                            borderColor: Theme.of(context).primaryColor,
                            hintText: "",
                            hintTextColor: Theme.of(context).primaryColor,
                            textColor: Theme.of(context).primaryColor,
                            valControl: (value) {
                              country = value;
                              print(country);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getHeight(30),
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: getWidth(50),
                            ),
                            AutoSizeText(
                              "city" + " :",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                              maxLines: 1,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: getWidth(340),
                          child: MyTextField(
                            type: 3,
                            borderColor: Theme.of(context).primaryColor,
                            hintText: "",
                            hintTextColor: Theme.of(context).primaryColor,
                            textColor: Theme.of(context).primaryColor,
                            valControl: (value) {
                              city = value;
                              print(city);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getHeight(30),
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: getWidth(50),
                            ),
                            AutoSizeText(
                              "street" + " :",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                              maxLines: 1,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: getWidth(340),
                          child: MyTextField(
                            type: 3,
                            borderColor: Theme.of(context).primaryColor,
                            hintText: "",
                            hintTextColor: Theme.of(context).primaryColor,
                            textColor: Theme.of(context).primaryColor,
                            valControl: (value) {
                              street = value;
                              print(street);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getHeight(30),
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: getWidth(50),
                            ),
                            AutoSizeText(
                              "nearto :",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                              maxLines: 1,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: getWidth(340),
                          child: MyTextField(
                            type: 3,
                            borderColor: Theme.of(context).primaryColor,
                            hintText: "",
                            hintTextColor: Theme.of(context).primaryColor,
                            textColor: Theme.of(context).primaryColor,
                            valControl: (value) {
                              nearTo = value;
                              print(nearTo);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getHeight(30),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            AutoSizeText(
                              "Type :   ",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                              maxLines: 1,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: getWidth(150),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 1.5,
                                )),
                            child: Center(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  focusColor: Theme.of(context).primaryColor,
                                  iconEnabledColor:
                                      Theme.of(context).primaryColor,
                                  items: gender,
                                  value: type,
                                  onChanged: (value) {
                                    setState(() {
                                      type = value;
                                      print(type);
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getHeight(50),
                    ),
                    MyButton(
                      buttonColor: Theme.of(context).primaryColor,
                      text: "add",
                      textColor: Colors.white,
                      height: getHeight(50),
                      width: getWidth(200),
                      fun: () async {
                        var checkRes = AddressController.check(
                            country, city, street, nearTo, name);
                        print(checkRes);
                        if (checkRes != 1) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("$checkRes"),
                            backgroundColor: Theme.of(context).primaryColor,
                          ));
                          return;
                        }
                        setState(() {
                          loading = !loading;
                        });
                        await AddressController.addAddress(
                            country, city, street, nearTo, name, type);
                        Get.off(() => AllAddresses());
                      },
                    ),
                    // SizedBox(
                    //   height: getHeight(20),
                    // ),
                  ],
                ),
              ),
            ),
    );
  }
}
