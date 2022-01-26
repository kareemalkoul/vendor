import 'dart:io';
import 'package:get/get.dart';

class VendorInfo {
  RxString imageUrl = "".obs;
  RxInt imageID = 0.obs;
  RxString name = "".obs;
  RxString slogan = "".obs;
  RxString password = "".obs;
  RxString email = "".obs;
  RxString phone = "".obs;
  RxString about = "".obs;
  RxString specification = "".obs;
  RxString owner = "".obs;

  VendorInfo({
    this.imageID,
    this.imageUrl,
    this.slogan,
    this.name,
    this.email,
    this.phone,
    this.about,
    this.password,
    this.specification,
    this.owner,
  });
}

Rx<VendorInfo> vendor = VendorInfo(
  name: "".obs,
  slogan: "".obs,
  password: "".obs,
  email: "".obs,
  phone: "".obs,
  about: "".obs,
  specification: "".obs,
  owner: "".obs,
  imageID: 0.obs,
  imageUrl: "".obs,
).obs;
