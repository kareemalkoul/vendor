import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:vendor/configs/size.dart';
import 'package:vendor/models/models_kareem/vendor_info.dart';
import 'package:vendor/screens/drawer/view/drawer.dart';
import 'package:vendor/screens/home/controller/homecontroller.dart';
import 'package:vendor/screens/home/main_tab_view/add_item_vendor/add_item_vendor.dart';
import 'package:vendor/screens/home/main_tab_view/items_vendor/controller/productscontroller.dart';
import 'package:vendor/screens/home/main_tab_view/items_vendor/items_vendor.dart';
import 'package:vendor/screens/home/main_tab_view/vendor_details/vendor_details.dart';
import 'package:vendor/widgets/Future_button.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  String vendorName = 'kareem';
  String phoneNumber = "0935062813";
  PageController controller;
  File _image;
  final picker = ImagePicker();
  String _chosenValue;
  int _currentIndex = 0;
  AnimationController _animationController;
  String imageprofile = "assets/images/profile.png";

  Future getImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    setState(
      () {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
          imageprofile = pickedFile.path;
        } else {
          print('No image selected.');
          imageprofile = "assets/images/profile.png";
        }
      },
    );
  }

  FirebaseMessaging messaging;
  @override
  void initState() {
    //imageprofile = File("assets/images/profile.png");
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    controller = PageController();
    // TODO: implement initState
    super.initState();

    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      print("token is");
      print(value);
      print("token done");
      HomeController.subsAll(value);
      HomeController.postToken(value);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void onTapbar(int i) {
    setState(
      () {
        controller.animateToPage(i,
            duration: Duration(milliseconds: 400),
            curve: Curves.fastLinearToSlowEaseIn);
        _currentIndex = i;
      },
    );
  }

  var isshowed = false.obs;

  @override
  Widget build(BuildContext context) {
    // isshowed.obs;
    return Scaffold(
      // floatingActionButton: FutureButton(
      //   child: Icon(Icons.add),
      //   onPressed: () {
      //     return ProductsController.getProducts();
      //   },
      // ),
      drawer: MyDrawer(
          imageprofile: imageprofile,
          vendorName: vendorName,
          phoneNumber: phoneNumber,
          isshowed: isshowed,
          animationController: _animationController),
      appBar: MyAppBar(),
      body: MyPageView(controller: controller),
      bottomNavigationBar: MyBottomBar(
        currentIndex: _currentIndex,
        onTapbar: onTapbar,
      ),
    );
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: Colors.green,
      title: Hero(tag: "Vendor", child: Text("Hi ${vendor.value.owner.value}")),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}

class MyBottomBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTapbar;
  const MyBottomBar({this.currentIndex, this.onTapbar});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(20)),
        border: Border.all(color: Theme.of(context).primaryColor),
      ),
      child: MyBar(
        currentIndex: currentIndex,
        onTapbar: onTapbar,
      ),
    );
  }
}

class MyPageView extends StatelessWidget {
  const MyPageView({
    Key key,
    @required this.controller,
  }) : super(key: key);

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return PageView(
      key: ValueKey(2),
      physics: NeverScrollableScrollPhysics(),
      controller: controller,
      children: [
        Vendor_Details_view(),
        ItemsVendor(),
        AddItemsVendor(),
      ],
    );
  }
}

class MyBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTapbar;
  const MyBar({this.currentIndex, this.onTapbar});
  @override
  Widget build(BuildContext context) {
    return SalomonBottomBar(
      currentIndex: currentIndex,
      onTap: onTapbar,
      //selectedItemColor: Colors.green,
      duration: Duration(milliseconds: 800),
      items: [
        SalomonBottomBarItem(
          icon: Icon(Icons.store),
          title: Text(
            "store",
          ),
        ),

        SalomonBottomBarItem(
          icon: FaIcon(FontAwesomeIcons.boxes),
          title: Text("items"),
        ),
        // SalomonBottomBarItem(
        //   icon: Icon(Ionicons.md_notifications),
        //   title: Text("notfication"),
        // ),
        SalomonBottomBarItem(
          icon: Icon(Ionicons.md_add_circle),
          title: Text("add item"),
        ),
      ],
    );
  }
}
