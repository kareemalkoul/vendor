import 'package:get/get.dart';
import 'package:vendor/requests_handling/requests.dart';

class GetScreenController extends GetxController {
  int num = 0;

  void add(int i) {
    num += i;
    update();
  }

  void getData() async {
    await Requests.getRequest(
        "https://floating-badlands-10743.herokuapp.com/api/faq/all");
    update();
  }
}
