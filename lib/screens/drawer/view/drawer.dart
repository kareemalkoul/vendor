import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor/models/models_kareem/cupon__sale_icons.dart';
import 'package:vendor/models/models_kareem/vendor_info.dart';
import 'package:vendor/screens/address/view/alladdresses.dart';
import 'package:vendor/screens/drawer/chat%20messages/view/chatmessages.dart';
import 'package:vendor/screens/drawer/chat%20messages/view/sentmessages.dart';
import 'package:vendor/screens/drawer/doc/view/document.dart';
import 'package:vendor/screens/drawer/offer/view/offers.dart';
import 'package:vendor/screens/drawer/profile/profile.dart';
import 'package:vendor/screens/drawer/sale/view/sales.dart';
import 'package:vendor/screens/drawer/story/view/mystories.dart';
import 'package:vendor/screens/faq/view/faq_page.dart';
import 'package:vendor/screens/login/view/login.dart';
import 'package:vendor/screens/messages/view/messages.dart';
import 'package:vendor/screens/phone/view/myphonenumbers.dart';
import 'package:vendor/screens/report/view/report.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key key,
    @required this.imageprofile,
    @required this.vendorName,
    @required this.phoneNumber,
    @required this.isshowed,
    @required AnimationController animationController,
  })  : _animationController = animationController,
        super(key: key);

  final String imageprofile;
  final String vendorName;
  final String phoneNumber;
  final RxBool isshowed;
  final AnimationController _animationController;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      //elevation: 50,
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
              arrowColor: Colors.black,
              currentAccountPicture: CircleAvatar(
                backgroundImage: vendor.value.imageUrl.value != ""
                    ? NetworkImage(vendor.value.imageUrl.value)
                    : AssetImage(imageprofile),
              ),
              accountName: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "${vendor.value.name.value}",
                  style: TextStyle(fontSize: 25),
                ),
              ),
              accountEmail: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "${vendor.value.email.value}",
                  style: TextStyle(fontSize: 15),
                ),
              )

              // onDetailsPressed: () {
              //   print("object");

              //   isshowed.value = !isshowed.value;
              // },
              // otherAccountsPictures: [
              //   AnimatedIcon(
              //     icon: AnimatedIcons.menu_close,
              //     progress: _animationController,
              //   )
              // ],
              ),
          // Obx(
          //   () => AnimatedContainer(
          //     duration: Duration(milliseconds: 500),
          //     height: isshowed.value ? 100 : 0,
          //   ),
          // ),
          ListTile(
            leading: Icon(Icons.account_box_rounded),
            title: Text('profile'),

            // trailing: Text("data"),
            onTap: () {
              Get.to(() => Profile());
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: Stack(
              children: [
                // Positioned(
                //     child: Icon(
                //   Icons.brightness_1,
                //   size: 15,
                //   color: Colors.red,
                // )),
                // Positioned(
                //     child: Icon(
                //   Icons.format_list_numbered,
                //   size: 8,
                //   color: Colors.red,
                // )),
                Positioned(
                    child: Icon(
                  CupertinoIcons.doc,
                  color: (doc == null || doc.length == 0) ? Colors.red : null,
                )),
              ],
            ),
            title: Text(
              'Document',
              style: TextStyle(
                color: (doc == null || doc.length == 0)
                    ? Colors.red
                    : Colors.black,
              ),
            ),
            onTap: () {
              // Update the state of the app.
              // ...
              Get.to(() => Documents());
            },
          ),
          ListTile(
            leading: Icon(CupertinoIcons.phone),
            title: Text('phones'),
            onTap: () {
              // Update the state of the app.
              // ...
              Get.to(() => MyPhoneNumbers());
            },
          ),
          ListTile(
            leading: Icon(CupertinoIcons.location),
            title: Text('address'),
            onTap: () {
              // Update the state of the app.
              // ...
              Get.to(() => AllAddresses());
            },
          ),
          // ListTile(
          //   leading: Icon(Cupon_Sale.instagram_stories),
          //   title: Text('addstories'),
          //   onTap: () {
          //     // Update the state of the app.
          //     // ...
          //     Get.to(() => AddStory());
          //   },
          // ),
          ListTile(
            leading: Icon(Cupon_Sale.cotton_pad),
            title: Text('stories'),
            onTap: () {
              // Update the state of the app.
              // ...
              Get.to(() => MyStories());
            },
          ),
          ListTile(
            leading: Icon(Cupon_Sale.sale),
            title: Text('offers'),
            onTap: () {
              // Update the state of the app.
              // ...
              Get.to(() => Offer());
            },
          ),
          ListTile(
            leading: Icon(Cupon_Sale.sale_tag),
            title: Text('sale'),
            onTap: () {
              // Update the state of the app.
              // ...
              Get.to(() => Sales());
            },
          ),
          ListTile(
            leading: Icon(Icons.chat),
            title: Text('masseges'),
            onTap: () {
              // Update the state of the app.
              // ...
              Get.to(() => ChatMessages());
            },
          ),
          ListTile(
            leading: Icon(Icons.send),
            title: Text('Replay masseges'),
            onTap: () {
              // Update the state of the app.
              // ...
              Get.to(() => SentMessages());
            },
          ),

          ListTile(
            leading: Icon(Icons.chat),
            title: Text('Messages App'),
            onTap: () {
              // Update the state of the app.
              // ...
              Get.to(() => Messages());
            },
          ),
          ListTile(
            leading: Icon(Icons.support_agent_rounded),
            title: Text('Support'),

            // trailing: Text("data"),
            onTap: () {
              Get.to(() => Report());
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('FAQ'),
            onTap: () {
              // Update the state of the app.
              // ...
              Get.to(() => FaqPage());
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.info_outline),
          //   title: Text('about'),
          //   onTap: () {
          //     // Update the state of the app.
          //     // ...
          //   },
          // ),
          // ListTile(
          //   leading: Icon(Icons.settings),
          //   title: Text('setting'),
          //   onTap: () {
          //     // Update the state of the app.
          //     // ...
          //   },
          // ),

          ListTile(
            leading: Icon(Icons.logout),
            title: Text('log out'),
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              Get.offAll(() => LogIn());
              // Update the state of the app.
              // ...
              // Future.delayed(Duration.zero, () async {
              //   SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              // });
            },
          ),
        ],
      ),
    );
  }
}
