import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/models/models_kareem/vendor_info.dart';
import 'package:vendor/screens/drawer/doc/controller/documentcontroller.dart';
import 'package:vendor/screens/drawer/doc/view/document.dart';
import 'package:vendor/screens/drawer/profile/controller/profilecontroller.dart';
import 'package:vendor/screens/home/main_tab_view/add_item_vendor/add_item_vendor.dart';
import 'package:vendor/screens/home/main_tab_view/add_item_vendor/controller/addproductcontroller.dart';
import 'package:vendor/screens/home/main_tab_view/items_vendor/controller/productscontroller.dart';
import 'package:vendor/screens/home/main_tab_view/items_vendor/items_vendor.dart';
import 'package:vendor/screens/home/main_tab_view/vendor_details/controller/homecontroller.dart';
import 'package:vendor/screens/home/main_tab_view/vendor_details/vendor_details.dart';
import 'package:vendor/screens/home/view/home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    getData().then((value) => Get.offAll(() => Home()));
  }

  Future getData() async {
    print("splash");
    List userData = await ProfileController.profileGet();
    vendor.value.email.value = userData[0]['email'];
    vendor.value.name.value = userData[0]['name'];
    vendor.value.slogan.value = userData[0]['slogan'];
    vendor.value.specification.value = userData[0]['specification'];
    vendor.value.owner.value = userData[0]['owner'];
    if (userData[0]['Vendor_Image'] != null) {
      vendor.value.imageUrl.value = userData[0]['Vendor_Image']["url"];
      vendor.value.imageID.value = userData[0]['Vendor_Image']["id"];
    }
    var phone = await ProfileController.phoneGet();
    print(phone);
    if (phone.length != 0) {
      vendor.value.phone.value = phone[0]["number"].toString();
    }

    var body = await AddProductController.getCat();

    for (int i = 0; i < body.length; i++) {
      categoryName.add(body[i]["title"]);
      categoryid.add(body[i]["id"]);
    }
    products = await ProductsController.getProducts();
    for (int i = 0; i < products.length; i++) {
      if (products[i]["Images"].length != 0)
        images.add(products[i]["Images"][0]["url"]);
      else
        images.add("");
    }
    money = (await HomeController.getMoney())["sum"].toString();
    sales = (await HomeController.getSales()).length.toString();

    listEraning = await HomeController.getWeakly();
    doc = await DocumentController.getDocument();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withOpacity(0.5)
          ], begin: Alignment.topCenter, end: Alignment.bottomRight),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.store,
                    color: Colors.white,
                    size: 55,
                  ),
                  // Lottie.asset(
                  //   "assets/jsons_Animation/landingpage/loading.json",
                  // )
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor),
                      strokeWidth: 6,
                      // backgroundColor: Theme.of(context).primaryColor,
                    ),
                  )
                ],
              ),
              Text("Vendor",
                  style: TextStyle(color: Colors.white, fontSize: 20))
            ],
          ),
        ),
      ),
    );
  }
}
