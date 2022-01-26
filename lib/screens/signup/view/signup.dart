import 'package:vendor/screens/home/view/home.dart';
import 'package:flutter/material.dart';
import 'package:vendor/screens/splashscreen/view/splashscreen.dart';
import 'package:vendor/widgets/mybutton.dart';
import 'package:vendor/widgets/mytextfield.dart';
import 'package:vendor/configs/size.dart';
import 'package:vendor/screens/signup/controller/signupcontroller.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var name;
  var slogan;
  var email;
  var password;
  var specification;
  var owner;
  var accountStatus;
  var code;

  bool loading = false;
  bool res = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: loading
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
                      SizedBox(
                        height: getHeight(30),
                        child: Text(
                          "SignUp",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                              fontSize: 25),
                        ),
                      ),
                      SizedBox(
                        height: getHeight(20),
                      ),
                      SizedBox(
                        width: getWidth(340),
                        child: MyTextField(
                          type: 3,
                          borderColor: Theme.of(context).primaryColor,
                          hintText: "name",
                          hintTextColor: Colors.grey.shade400,
                          textColor: Theme.of(context).primaryColor,
                          valControl: (value) {
                            name = value;
                            print(name);
                          },
                        ),
                      ),
                      SizedBox(
                        height: getHeight(30),
                      ),
                      SizedBox(
                        width: getWidth(340),
                        child: MyTextField(
                          type: 1,
                          borderColor: Theme.of(context).primaryColor,
                          hintText: "email",
                          hintTextColor: Colors.grey.shade400,
                          textColor: Theme.of(context).primaryColor,
                          valControl: (value) {
                            email = value;
                            print(email);
                          },
                        ),
                      ),
                      SizedBox(
                        height: getHeight(30),
                      ),
                      SizedBox(
                        width: getWidth(340),
                        child: MyTextField(
                          type: 3,
                          borderColor: Theme.of(context).primaryColor,
                          hintText: "password",
                          hintTextColor: Colors.grey.shade400,
                          textColor: Theme.of(context).primaryColor,
                          valControl: (value) {
                            password = value;
                            print(password);
                          },
                        ),
                      ),
                      SizedBox(
                        height: getHeight(30),
                      ),
                      SizedBox(
                        width: getWidth(340),
                        child: MyTextField(
                          type: 3,
                          borderColor: Theme.of(context).primaryColor,
                          hintText: "Specification",
                          hintTextColor: Colors.grey.shade400,
                          textColor: Theme.of(context).primaryColor,
                          valControl: (value) {
                            specification = value;
                            print(specification);
                          },
                        ),
                      ),
                      SizedBox(
                        height: getHeight(30),
                      ),
                      SizedBox(
                        width: getWidth(340),
                        child: MyTextField(
                          type: 3,
                          borderColor: Theme.of(context).primaryColor,
                          hintText: "Owner",
                          hintTextColor: Colors.grey.shade400,
                          textColor: Theme.of(context).primaryColor,
                          valControl: (value) {
                            owner = value;
                            print(owner);
                          },
                        ),
                      ),
                      SizedBox(
                        height: getHeight(30),
                      ),
                      SizedBox(
                        width: getWidth(340),
                        child: MyTextField(
                          type: 3,
                          borderColor: Theme.of(context).primaryColor,
                          hintText: "Slogan",
                          hintTextColor: Colors.grey.shade400,
                          textColor: Theme.of(context).primaryColor,
                          valControl: (value) {
                            slogan = value;
                            print(slogan);
                          },
                        ),
                      ),
                      SizedBox(
                        height: getHeight(30),
                      ),
                      SizedBox(
                        width: getWidth(340),
                        child: MyTextField(
                          type: 3,
                          borderColor: Theme.of(context).primaryColor,
                          hintText: "code ",
                          hintTextColor: Colors.grey.shade400,
                          textColor: Theme.of(context).primaryColor,
                          valControl: (value) {
                            code = value;
                            print(code);
                          },
                        ),
                      ),
                      SizedBox(
                        height: getHeight(40),
                      ),
                      MyButton(
                        buttonColor: Theme.of(context).primaryColor,
                        text: "SignUp",
                        textColor: Colors.white,
                        height: getHeight(50),
                        width: getWidth(200),
                        fun: () async {
                          print(email);
                          print("check");
                          var checkRes = SignUpController.check(
                              name,
                              slogan,
                              email,
                              password,
                              specification,
                              owner,
                              accountStatus,
                              code);
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
                          res = await SignUpController.signup(
                              name,
                              slogan,
                              email,
                              password,
                              specification,
                              owner,
                              accountStatus,
                              code);
                          if (res) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SplashScreen()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("error!"),
                              backgroundColor: Theme.of(context).primaryColor,
                            ));

                            setState(() {
                              loading = !loading;
                            });
                          }
                        },
                      ),
                      SizedBox(
                        height: getHeight(60),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
