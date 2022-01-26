import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/configs/size.dart';
import 'package:vendor/screens/drawer/profile/textfield_editing_vendor.dart';
import 'package:vendor/screens/forgetpassword/controller/passwordcontoller.dart';
import 'package:vendor/widgets/mybutton.dart';

class ResetPassword extends StatelessWidget {
  var oldPassword;
  var newPassword;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("change password"),
      ),
      body: SingleChildScrollView(
          child: Container(
        child: Column(
          children: [
            SizedBox(
              height: getHeight(50),
            ),
            VendorRowInfoEditing(
              title: "Old password",
              onChanged: (value) => oldPassword = value,
            ),
            SizedBox(
              height: getHeight(10),
            ),
            VendorRowInfoEditing(
              title: "New Passord",
              onChanged: (value) => newPassword = value,
            ),
            SizedBox(
              height: getHeight(40),
            ),
            MyButton(
              buttonColor: Theme.of(context).primaryColor,
              text: "Sumbit",
              height: getHeight(50),
              width: getWidth(250),
              fun: () async {
                if (oldPassword == null ||
                    newPassword == null ||
                    newPassword == "" ||
                    oldPassword == "") {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("complete fields"),
                    backgroundColor: Theme.of(context).primaryColor,
                  ));
                } else if (newPassword.length < 8
                    // || oldPassword.length < 8
                    ) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("password must be 8 or more char"),
                    backgroundColor: Theme.of(context).primaryColor,
                  ));
                } else {
                  var res = await PasswordController.checkPassword(oldPassword);
                  if (res) {
                    var res1 =
                        await PasswordController.changekPassword(newPassword);
                    if (res1) {
                      Get.back();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("error"),
                        backgroundColor: Theme.of(context).primaryColor,
                      ));
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("password uncorrect"),
                      backgroundColor: Theme.of(context).primaryColor,
                    ));
                  }
                }
              },
            )
          ],
        ),
      )),
    );
  }
}
