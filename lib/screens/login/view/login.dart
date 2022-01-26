import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vendor/screens/forgetpassword/view/forgetpassword.dart';
import 'package:vendor/screens/forgetpassword/view/forgetpasswordfromlogin.dart';
import 'package:vendor/screens/home/view/home.dart';
import 'package:vendor/screens/signup/view/signup.dart';
import 'package:flutter/material.dart';
import 'package:vendor/configs/size.dart';
import 'package:vendor/screens/splashscreen/view/splashscreen.dart';
import 'package:vendor/widgets/mytextfield.dart';
import 'package:vendor/widgets/mybutton.dart';
import 'package:vendor/screens/login/controller/logincontroller.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  var email;
  var password;
  bool res = false;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white));
    SizeConfig.init(context);
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
                    children: [
                      SizedBox(
                        height: getHeight(60.0),
                      ),
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
                          "Welcome Back!",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        "Log in using you existent account",
                        style: TextStyle(
                            fontSize: 15, color: Colors.grey.shade400),
                      ),
                      SizedBox(
                        height: getHeight(20.0),
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
                          counter: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // Text(
                              //   "did forget password?  ",
                              //   style: TextStyle(
                              //       fontSize: 15, color: Colors.grey.shade400),
                              // ),
                              InkWell(
                                onTap: () {
                                  Get.to(() => ForgetPasswordLogin());
                                },
                                child: Text(
                                  "forget password ?",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Theme.of(context).primaryColor),
                                ),
                              ),
                            ],
                          ),
                          type: 5,
                          borderColor: Theme.of(context).primaryColor,
                          hintText: "Password",
                          hintTextColor: Colors.grey.shade400,
                          textColor: Theme.of(context).primaryColor,
                          valControl: (value) {
                            password = value;
                            print(password);
                          },
                        ),
                      ),
                      SizedBox(
                        height: getHeight(20.0),
                      ),
                      MyButton(
                        buttonColor: Theme.of(context).primaryColor,
                        text: "LogIn",
                        textColor: Colors.white,
                        height: getHeight(50),
                        width: getWidth(200),
                        fun: () async {
                          print("login");
                          var checkRes = LogInController.check(email, password);
                          if (checkRes != 1) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("$checkRes"),
                              backgroundColor: Theme.of(context).primaryColor,
                            ));
                            //return;
                          }

                          setState(() {
                            loading = !loading;
                          });
                          res = await LogInController.login(email, password);
                          if (res) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SplashScreen()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text(" your email or password not vaild"),
                              backgroundColor: Theme.of(context).primaryColor,
                            ));
                            setState(() {
                              loading = !loading;
                            });
                          }
                        },
                      ),
                      SizedBox(
                        height: getHeight(20.0),
                      ),
                      // SizedBox(
                      //   height: getHeight(25.0),
                      //   child: Text(
                      //     "Or Login With",
                      //     style: TextStyle(
                      //         fontSize: 15, color: Colors.grey.shade400),
                      //   ),
                      // ),
                      SizedBox(
                        height: getHeight(20.0),
                      ),
                      SizedBox(
                        height: getHeight(30.0),
                      ),
                      SizedBox(
                        height: getHeight(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "don't have an account?  ",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey.shade400),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUp()));
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getHeight(30.0),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
