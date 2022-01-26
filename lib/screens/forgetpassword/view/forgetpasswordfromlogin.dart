import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/configs/size.dart';
import 'package:vendor/screens/forgetpassword/controller/passwordcontoller.dart';
import 'package:vendor/widgets/mybutton.dart';
import 'package:vendor/widgets/mytextfield.dart';

class ForgetPasswordLogin extends StatelessWidget {
  var code;
  var newPassword;
  String email;

  ForgetPasswordLogin({Key key, this.email}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Forget password"),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Container(
          child: Column(
            children: [
              Container(
                height: getHeight(180),
                width: getWidth(200),
                child: Image.asset(
                  "images/logo.png",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: getHeight(50.0),
                child: Text(
                  "Reset Password",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: getHeight(20),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: MyTextField(
                  borderColor: Theme.of(context).primaryColor,
                  hintText: "Email",
                  hintTextColor: Colors.grey.shade400,
                  textColor: Theme.of(context).primaryColor,
                  type: 1,
                  valControl: (value) {
                    email = value;
                    print(email);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: MyTextField(
                  borderColor: Theme.of(context).primaryColor,
                  hintText: "Code",
                  hintTextColor: Colors.grey.shade400,
                  textColor: Theme.of(context).primaryColor,
                  type: 1,
                  valControl: (value) {
                    code = value;
                    print(code);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: MyTextField(
                  borderColor: Theme.of(context).primaryColor,
                  hintText: "New Password",
                  hintTextColor: Colors.grey.shade400,
                  textColor: Theme.of(context).primaryColor,
                  type: 1,
                  valControl: (value) {
                    newPassword = value;
                    print(newPassword);
                  },
                ),
              ),
              SizedBox(
                height: getHeight(40),
              ),
              MyButton(
                buttonColor: Theme.of(context).primaryColor,
                text: "sumbit",
                textColor: Colors.white,
                height: getHeight(50),
                width: getWidth(200),
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
                        email, code, newPassword);
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
      ),
    );
  }
}
