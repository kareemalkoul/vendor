import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vendor/screens/login/view/login.dart';
import 'package:vendor/screens/login/view/login1.dart';

import 'package:vendor/screens/onlanding/view/bootomNav.dart';
import 'package:vendor/screens/onlanding/view/pageview.dart';

double width;
 Color primaryColor = Colors.teal;

class OnLandding extends StatelessWidget {
  static const Duration duration = Duration(milliseconds: 400);
  static const curve = Curves.easeIn;
  RxInt index = 0.obs;
  final count = 4;
  final PageController controller = PageController();
  RxBool isLastPage = false.obs;

  @override
  Widget build(BuildContext context) {
    primaryColor = Theme.of(context).primaryColor;
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: primaryColor));
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: MyBottomNav(
        isLastPage: isLastPage,
        next: () {
          if (isLastPage.value) {
            Get.offAll(() => Login());
          }
          controller.nextPage(duration: duration, curve: curve);
        },
        skip: () {
          controller.animateToPage(count, duration: duration, curve: curve);
        },
        index: index,
        count: count,
      ),
      body: SafeArea(
        child: Stack(children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: primaryColor,
                    // border: Border.all(color: Colors.blueAccent),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(width * 2),
                    ),
                  ),
                ),
              ),
              Expanded(child: SizedBox()),
            ],
          ),
          Mypageview(
            controller: controller,
            func: (x) {
              index.value = x;
              if (x == count - 1) {
                isLastPage.value = true;
              } else {
                isLastPage.value = false;
              }
            },
          ),
        ]),
      ),
    );
  }
}
