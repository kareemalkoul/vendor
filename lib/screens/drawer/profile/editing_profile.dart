import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor/configs/size.dart';
import 'package:vendor/models/models_kareem/vendor_info.dart';
import 'package:vendor/screens/drawer/profile/controller/profilecontroller.dart';
import 'package:vendor/screens/forgetpassword/view/forgetpassword.dart';
import 'package:vendor/screens/forgetpassword/view/resetpassword.dart';
import 'package:vendor/widgets/mybutton.dart';
import 'profile_picture.dart';
import 'textfield_editing_vendor.dart';

class EditingProfile extends StatefulWidget {
  @override
  _EditingProfileState createState() => _EditingProfileState();
}

class _EditingProfileState extends State<EditingProfile> {
  var name;

  var slogan;

  var email;

  var password;

  var specification;

  var owner;

  var accountStatus;

  var imageUrl;

  var oldImage;

  bool ischanged = false;

  var pickedImage;

  String oldpassword;

  String newPassword;

  var isfirst = true;

  dynamic getImage() {
    if (imageUrl == null && pickedImage == null) {
      return AssetImage("images/usericon.png");
    } else if (imageUrl != null && pickedImage == null) {
      return NetworkImage(imageUrl);
    } else if (pickedImage != null) return FileImage(File(pickedImage.path));
  }

  @override
  Widget build(BuildContext context) {
    print(vendor.value.imageUrl.value);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              if (await ProfileController.profileDelete() != false) {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.clear();
                Navigator.pop(context);
                // Update the state of the app.
                // ...
                Future.delayed(Duration.zero, () async {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                });
              }
              print("Failed delete");
            },
          ),
        ],
        // automaticallyImplyLeading: false,
        title: Center(child: Text("Editig Profile")),
      ),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            // physics: BouncingScrollPhysics(),
            child: Obx(
              () => Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  ProfilePicture(
                    onTap: () async {
                      pickedImage = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (pickedImage != null) {
                        try {
                          if (pickedImage.path != null) {
                            ischanged = true;
                            isfirst = false;
                            setState(() {});
                            return pickedImage.path;
                          }
                        } catch (e) {
                          print(e);
                        }
                      }
                      print(ischanged);
                      setState(() {});
                    },
                    isEdite: false,
                    image: vendor.value.imageUrl.value,
                    seconedimage: ischanged
                        ? pickedImage.path
                        : "assets/images/profile.png",
                    isfirst: isfirst,
                    // !ischanged
                    //     ? (vendor.value.imageUrl.value == ""
                    //         ? null
                    //         : Image.network(vendor.value.imageUrl.value))
                    //     : Image.file(File(pickedImage.path)
                    // ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  VendorRowInfoEditing(
                    title: "Store Name",
                    descraption: vendor.value.name.value,
                    onChanged: (value) => vendor.value.name.value = value,
                  ),
                  VendorRowInfoEditing(
                    title: "Owner",
                    descraption: vendor.value.owner.value,
                    onChanged: (value) => vendor.value.owner.value = value,
                  ),
                  VendorRowInfoEditing(
                    title: "Slogan",
                    descraption: vendor.value.slogan.value,
                    onChanged: (value) => vendor.value.slogan.value = value,
                  ),
                  VendorRowInfoEditing(
                    title: "ُEmail",
                    descraption: vendor.value.email.value,
                    onChanged: (value) => vendor.value.email.value = value,
                    textInputType: TextInputType.emailAddress,
                  ),
                  VendorRowInfoEditing(
                    title: "Phone",
                    descraption: vendor.value.phone.value,
                    onChanged: (value) => vendor.value.phone.value = value,
                    textInputType: TextInputType.number,
                  ),
                  VendorRowInfoEditing(
                    title: "specification",
                    descraption: vendor.value.specification.value,
                    onChanged: (value) => vendor.value.about.value = value,
                  ),
                  // Divider(indent: 20, endIndent: 10, thickness: 2, height: 20),
                  // VendorRowInfoEditing(
                  //   title: "Old password",
                  //   descraption: oldpassword,
                  //   onChanged: (value) => oldpassword = value,
                  //   obscureText: true,
                  // ),
                  // VendorRowInfoEditing(
                  //   title: "New password",
                  //   descraption: newPassword,
                  //   onChanged: (value) => newPassword = value,
                  //   obscureText: true,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: getWidth(10),
                      ),
                      Container(
                        width: getWidth(190),
                        height: getHeight(40),
                        child: TextButton(
                          onPressed: () {
                            Get.to(() => ResetPassword());
                          },
                          child: Text("change password"),
                        ),
                      ),
                      SizedBox(
                        width: getWidth(10),
                      ),
                      Container(
                        width: getWidth(190),
                        height: getHeight(40),
                        child: TextButton(
                          onPressed: () {
                            Get.to(() => ForgetPassword(
                                  email: vendor.value.email.value,
                                ));
                          },
                          child: Text("reset password"),
                        ),
                      ),
                      SizedBox(
                        width: getWidth(5),
                      )
                    ],
                  ),
                  SizedBox(
                    height: getHeight(10),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 10, 20),
                    child: FloatingActionButton(
                      isExtended: true,
                      child: Text("Submit"),
                      onPressed: () async {
                        name = vendor.value.name.value;
                        slogan = vendor.value.slogan.value;
                        email = vendor.value.email.value;
                        password = vendor.value.password.value;
                        specification = vendor.value.specification.value;
                        owner = vendor.value.owner.value;
                        accountStatus = vendor.value.about.value;

                        var checkRes = ProfileController.check(
                            name,
                            slogan,
                            email,
                            password,
                            specification,
                            owner,
                            accountStatus);
                        print(checkRes);
                        if (checkRes != 1) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("$checkRes"),
                            backgroundColor: Colors.lightBlue,
                          ));
                          return;
                        }
                        var editRes;
                        editRes = await ProfileController.profileEdit(
                            name,
                            slogan,
                            email,
                            password,
                            specification,
                            owner,
                            accountStatus);
                        print("1");

                        if (editRes.statusCode == 200 && ischanged == true) {
                          if (imageUrl == null)
                            await ProfileController.addUserImage(pickedImage);
                          else
                            await ProfileController.editUserImage(
                                pickedImage, oldImage);
                        }
                        var phone = await ProfileController.phoneGet();
                        if (phone.length == 0) {
                          print("aaa");
                          ProfileController.addPhone(vendor.value.phone.value);
                        } else {
                          print(vendor.value.phone.value);
                          print(phone[0]["id"]);
                          await ProfileController.editPhone(
                              vendor.value.phone.value, phone[0]["id"]);
                        }
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
