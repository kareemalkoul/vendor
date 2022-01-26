import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/configs/size.dart';
import 'package:vendor/screens/drawer/profile/textfield_editing_vendor.dart';
import 'package:vendor/screens/forgetpassword/controller/passwordcontoller.dart';
import 'package:vendor/widgets/mybutton.dart';

class ForgetPassword extends StatelessWidget {
  var code;
  var newPassword;
  String email;

  ForgetPassword({Key key, this.email}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forget password"),
      ),
      body: SingleChildScrollView(
          child: Container(
        child: Column(
          children: [
            SizedBox(
              height: getHeight(50),
            ),
            VendorRowInfoEditing(
              title: "email",
              descraption: email,
              onChanged: (value) => email = value,
            ),
            VendorRowInfoEditing(
              title: "Code",
              onChanged: (value) => code = value,
            ),
            SizedBox(
              height: getHeight(10),
            ),
            VendorRowInfoEditing(
              title: "New Password",
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
                if (code == null ||
                    newPassword == null ||
                    newPassword == "" ||
                    code == "") {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("complete fields"),
                    backgroundColor: Theme.of(context).primaryColor,
                  ));
                } else if (newPassword.length < 8) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("password must be 8 or more char"),
                    backgroundColor: Theme.of(context).primaryColor,
                  ));
                } else {
                  var res = await PasswordController.resetPassword(
                      code, email, newPassword);
                  if (res) {
                    Get.back();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("error"),
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
