import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/screens/address/view/alladdresses.dart';
import 'package:vendor/screens/drawer/chat%20messages/view/chatmessages.dart';
import 'package:vendor/screens/drawer/chat%20messages/view/sentmessages.dart';
import 'package:vendor/screens/drawer/offer/view/offers.dart';
import 'package:vendor/screens/drawer/profile/profile.dart';
import 'package:vendor/screens/drawer/story/view/mystories.dart';
import 'package:vendor/screens/home/view/home.dart';
import 'package:vendor/screens/login/view/login.dart';
import 'package:vendor/screens/messages/view/messages.dart';
import 'package:vendor/screens/signup/view/signup.dart';
import 'screens/drawer/doc/view/document.dart';
import 'screens/drawer/offer/view/addoffer.dart';

class MainHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("mainhome"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: TextButton(
                  onPressed: () {
                    Get.to(() => Home());
                  },
                  child: Text("home"),
                ),
              ),
              SizedBox(
                height: 50,
                child: TextButton(
                  onPressed: () {
                    Get.to(() => AllAddresses());
                  },
                  child: Text("address"),
                ),
              ),
              SizedBox(
                height: 50,
                child: TextButton(
                  onPressed: () {
                    Get.to(() => ChatMessages());
                  },
                  child: Text("ChatMessages"),
                ),
              ),
              SizedBox(
                height: 50,
                child: TextButton(
                  onPressed: () {
                    Get.to(() => SentMessages());
                  },
                  child: Text("SentMessages"),
                ),
              ),
              SizedBox(
                height: 50,
                child: TextButton(
                  onPressed: () {
                    Get.to(() => Documents());
                  },
                  child: Text("Documents"),
                ),
              ),
              SizedBox(
                height: 50,
                child: TextButton(
                  onPressed: () {
                    Get.to(() => Offer());
                  },
                  child: Text("Offer"),
                ),
              ),
              SizedBox(
                height: 50,
                child: TextButton(
                  onPressed: () {
                    Get.to(() => AddOffer());
                  },
                  child: Text("Add Offer"),
                ),
              ),
              SizedBox(
                height: 50,
                child: TextButton(
                  onPressed: () {
                    Get.to(() => Profile());
                  },
                  child: Text("Profile"),
                ),
              ),
              SizedBox(
                height: 50,
                child: TextButton(
                  onPressed: () {
                    Get.to(() => MyStories());
                  },
                  child: Text("MyStories"),
                ),
              ),
              SizedBox(
                height: 50,
                child: TextButton(
                  onPressed: () {
                    Get.to(() => LogIn());
                  },
                  child: Text("LogIn"),
                ),
              ),
              SizedBox(
                height: 50,
                child: TextButton(
                  onPressed: () {
                    Get.to(() => Messages());
                  },
                  child: Text("Messages"),
                ),
              ),
              SizedBox(
                height: 50,
                child: TextButton(
                  onPressed: () {
                    Get.to(() => SignUp());
                  },
                  child: Text("SignUp"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
