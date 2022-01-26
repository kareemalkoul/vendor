import 'package:flutter/material.dart';
import 'package:vendor/screens/onlanding/view/page.dart';

class Mypageview extends StatelessWidget {
  final Function(int) func;
  final PageController controller;

  const Mypageview({Key key, this.func, this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      onPageChanged: (x) {
        print("page $x");
        func(x);
      },
      children: [
        MyPage(
          pathAnimation: "assets/jsons_Animation/16416-store-at-hitit.json",
          title: "Make Money",
          descraption:
              "put your Product in our app and be available to all people in our comminty for make more money",
        ),
        MyPage(
          pathAnimation: "assets/jsons_Animation/74824-delivery-man.json",
          title: "Dliver your Products",
          descraption:
              "We are responsible for Dlivering Your Products from your Shop to our Customer in the fastest way",
        ),
        MyPage(
          pathAnimation: "assets/jsons_Animation/38441-shop.json",
          title: "Shop Offers",
          descraption:
              "add Offers and Sales to your online Store to attract customers and make more",
        ),
        MyPage(
          pathAnimation: "assets/jsons_Animation/36546-live-chating.json",
          title: "chat with your Customers",
          descraption:
              "chat with your customers to know what they want and order Special Orders",
        ),
      ],
    );
  }
}
