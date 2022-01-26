import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/screens/onlanding/view/onlanding.dart';

class MyBottomNav extends StatelessWidget {
  final RxInt index;
  final int count;
  final Function() next;
  final Function() skip;
  final RxBool isLastPage;
  MyBottomNav(
      {Key key, this.index, this.count, this.next, this.skip, this.isLastPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: EdgeInsets.all(25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            !isLastPage.value
                ? InkWell(
                    onTap: () {
                      skip();
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Text(
                        "Skip",
                        style: TextStyle(
                          fontSize: 25,
                          color: primaryColor.withOpacity(1),
                        ),
                      ),
                    ),
                  )
                : SizedBox(),
            IndexOfPage(
              count: count,
              index: index,
            ),
            Row(
              children: [
                InkWell(
                  onTap: () => next(),
                  child: AnimatedContainer(
                    padding: isLastPage.value
                        ? EdgeInsets.symmetric(horizontal: 10)
                        : null,
                    duration: Duration(milliseconds: 500),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.9),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: Text(
                        isLastPage.value ? "Lets Start" : "next",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LetsStart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder())),
        onPressed: () {},
        child: Text(
          "Lets Start",
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}

class IndexOfPage extends StatelessWidget {
  final count;
  final index;
  const IndexOfPage({Key key, this.index, this.count}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      child: Row(
        children: [
          ...List.generate(
            count,
            (i) => MyAnimatedContainer(num: i, index: index),
          ),
        ],
      ),
    );
  }
}

class MyAnimatedContainer extends StatelessWidget {
  static const Duration duration = Duration(milliseconds: 600);

  const MyAnimatedContainer({
    Key key,
    @required this.num,
    @required this.index,
  }) : super(key: key);

  final int num;
  final RxInt index;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedContainer(
        margin: EdgeInsets.all(5),
        duration: duration,
        width: num == index.value ? 20 : 10,
        decoration: BoxDecoration(
          color: num == index.value
              ? primaryColor.withOpacity(1)
              : Colors.grey.shade400,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
