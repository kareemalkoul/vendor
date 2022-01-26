import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get.dart';
import 'package:vendor/screens/phone/view/addphone.dart';
import 'package:vendor/screens/phone/view/editphone.dart';
import 'package:flutter/material.dart';
import 'package:vendor/configs/size.dart';
import 'package:vendor/screens/phone/controller/phonescontroller.dart';

class MyPhoneNumbers extends StatefulWidget {
  @override
  _MyPhoneNumbersState createState() => _MyPhoneNumbersState();
}

class _MyPhoneNumbersState extends State<MyPhoneNumbers> {
  Future value;
  List phones = [];

  Function updateState;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    value = getData();
    updateState = () {
      setState(() {
        value = null;
        value = getData();
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add_call),
        onPressed: () {
          Get.off(() => AddPhone());
        },
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: AutoSizeText(
          "My Phones",
          style: TextStyle(color: Colors.white, fontSize: 20),
          maxLines: 1,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: FutureBuilder(
        builder: (context, AsyncSnapshot<dynamic> snap) {
          if (snap.data != null) {
            return ListView.builder(
              itemCount: phones.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SizedBox(
                      height: getHeight(20),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: getWidth(30),
                        ),
                        Column(
                          children: [
                            Container(
                              height: getHeight(50),
                              width: getWidth(200),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                    width: 2),
                                color: Theme.of(context).primaryColor,
                              ),
                              child: SizedBox(
                                width: getWidth(200),
                                child: Center(
                                  child: AutoSizeText(
                                    "${phones[index]["name"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: getHeight(20),
                            ),
                            Container(
                              height: getHeight(50),
                              width: getWidth(200),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                    width: 2),
                                color: Theme.of(context).primaryColor,
                              ),
                              child: SizedBox(
                                width: getWidth(200),
                                child: Center(
                                  child: AutoSizeText(
                                    "${phones[index]["number"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: getWidth(100),
                        ),
                        Column(
                          children: [
                            IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: Theme.of(context).primaryColor,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditPhone(
                                                phoneId: phones[index]["id"],
                                                updateState: updateState,
                                                name: phones[index]["name"],
                                                phone: phones[index]["number"],
                                              )));
                                }),
                            SizedBox(
                              height: getHeight(20),
                            ),
                            IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Theme.of(context).primaryColor,
                                ),
                                onPressed: () async {
                                  var res = await PhonesController.deletePhone(
                                      phones[index]["id"]);
                                  if (res == false) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text("error occurred"),
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                    ));
                                  } else {
                                    updateState();
                                  }
                                }),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getHeight(20),
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 1.5,
                    ),
                  ],
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
          );
        },
        future: value,
      ),
    );
  }

  Future getData() async {
    phones = await PhonesController.getPhones();
    return phones;
  }
}
