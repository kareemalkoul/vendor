import 'package:dio/dio.dart';
import 'prefhalndler.dart';
import 'headers.dart' as myheaders;
import 'package:image_picker/image_picker.dart';

class ImageUploader {
  static Future upload(String url, Map<String, dynamic> body) async {
    Dio dio = Dio();
    var token = await PrefHandler.getToken();
    var image;
    var picked_image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked_image != null) {
      image = picked_image;
      print("got a picture");
    }

    String fileName = image.path.split('/').last;
    var file = await MultipartFile.fromFile(image.path, filename: fileName);
    body.addAll({"file": file});
    FormData formData = FormData.fromMap(body);
    var response;
    try {
      response = await dio.post(url,
          data: formData,
          options: Options(headers: myheaders.Headers.reqHeaders(token)));
      print(response);
    } catch (e) {
      print(e);
    }
  }

  static Future uploadImage(
      String url, Map<String, dynamic> body, dynamic image) async {
    Dio dio = Dio();
    var token = await PrefHandler.getToken();
    String fileName = image.path.split('/').last;
    var file = await MultipartFile.fromFile(image.path, filename: fileName);
    body.addAll({"file": file});
    FormData formData = FormData.fromMap(body);
    var response;
    try {
      response = await dio.post(url,
          data: formData,
          options: Options(headers: myheaders.Headers.reqHeaders(token)));
      print(response);
    } catch (e) {
      print(e);
    }
    return response;
  }
}
