import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/screens/getget/controller/getcontroller.dart';

class GetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("get screen"),
      ),
      body: Container(
        child: GetBuilder<GetScreenController>(
          init: GetScreenController(),
          builder: (GetScreenController controller) {
            print("object");
            return ListView(
              children: [
                InkWell(
                  onTap: () {
                    controller.update();
                    controller.add(1);
                  },
                  child: Text("${controller.num}"),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
