import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/models/models_kareem/vendor_info.dart';
import 'package:vendor/screens/drawer/profile/controller/profilecontroller.dart';
import 'profile_picture.dart';
import 'vendor_row.dart';

class Profile extends StatelessWidget {
  var value;
  Future getData() async {
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
    return userData;
  }

  @override
  Widget build(BuildContext context) {
    value = getData();
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: value,
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return Container(
                  child: SingleChildScrollView(
                    child: Obx(
                      () => Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          ProfilePicture(
                            isEdite: true,
                            image: vendor.value.imageUrl.value,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Center(
                            child: Text(
                              "${vendor.value.name}",
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                          Divider(
                            thickness: 2,
                            endIndent: 30,
                            indent: 30,
                          ),
                          VendorRowInfo(
                            title: vendor.value.slogan.value,
                            icon: Icons.store,
                          ),
                          VendorRowInfo(
                            title: vendor.value.email.value,
                            icon: Icons.phone,
                          ),
                          VendorRowInfo(
                            title: "*********",
                            icon: Icons.mail,
                          ),
                          VendorRowInfo(
                            title: vendor.value.phone.value == ""
                                ? "no phone number"
                                : vendor.value.phone.value,
                            icon: Icons.phone,
                          ),
                          VendorRowInfo(
                            title: vendor.value.slogan.value,
                            icon: Icons.info,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                );
              }
            }),
      ),
    );
  }
}
