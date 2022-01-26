import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get.dart';
import 'package:vendor/screens/phone/controller/phonescontroller.dart';
import 'package:vendor/screens/phone/view/myphonenumbers.dart';
import 'package:vendor/widgets/mybutton.dart';
import 'package:vendor/widgets/mytextfield.dart';
import 'package:flutter/material.dart';
import 'package:vendor/configs/size.dart';

class AddPhone extends StatefulWidget {
  @override
  _AddPhoneState createState() => _AddPhoneState();
}

class _AddPhoneState extends State<AddPhone> {
  var phone;
  var name;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Add phone"),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        backgroundColor: Colors.white,
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
                child: Column(
                  children: [
                    SizedBox(
                      height: getHeight(100),
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: getWidth(50),
                            ),
                            AutoSizeText(
                              "name :",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                              maxLines: 1,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: MyTextField(
                            type: 3,
                            borderColor: Theme.of(context).primaryColor,
                            hintText: "",
                            hintTextColor: Colors.grey.shade400,
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
                      height: getHeight(50),
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: getWidth(50),
                            ),
                            AutoSizeText(
                              "Phone :",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                              maxLines: 1,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: MyTextField(
                            type: 2,
                            borderColor: Theme.of(context).primaryColor,
                            hintText: "",
                            hintTextColor: Colors.grey.shade400,
                            textColor: Theme.of(context).primaryColor,
                            valControl: (value) {
                              phone = value;
                              print(phone);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getHeight(50),
                    ),
                    MyButton(
                      buttonColor: Theme.of(context).primaryColor,
                      text: "Add",
                      textColor: Colors.white,
                      height: getHeight(50),
                      width: getWidth(200),
                      fun: () async {
                        if (phone == null) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("number cannot be empty!"),
                            backgroundColor: Colors.lightBlue,
                          ));
                          return;
                        }

                        if (!isValidPhoneNumber(phone)) return;

                        setState(() {
                          loading = !loading;
                        });
                        var res = await PhonesController.addPhone(phone, name);
                        if (res != false) {
                          Get.off(() => MyPhoneNumbers());
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("error"),
                            backgroundColor: Colors.lightBlue,
                          ));
                          return;
                        }
                      },
                    ),
                  ],
                ),
              ));
  }

  bool isValidPhoneNumber(String string) {
    if (string == null || string.isEmpty) {
      return false;
    }

    const pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(string)) {
      return false;
    }
    return true;
  }
}
