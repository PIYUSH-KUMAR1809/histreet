import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:histreet/utilities/shared_preferences.dart';
import 'package:histreet/widgets/custom_loader.dart';
import 'package:http/http.dart' as http;

import '../../utilities/logger.dart';

class HomeController extends GetxController {
  RxString baseImagePath = ''.obs;
  RxString clothesImagePath = ''.obs;
  RxString createClothesBaseImage = ''.obs;
  TextEditingController textprompt = TextEditingController();
  CustomLoader customLoader = CustomLoader();

  List<String> list = ['Lower Body', 'Upper Body', 'Dresses'];
  List<String> list2 = ['Upper Body', 'Lower Body', 'Dresses'];
  RxString dropDownValue = 'Lower Body'.obs;
  RxString dropDownValue2 = 'Upper Body'.obs;

  Future<void> createClothesPickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null && result.files.single.path != null) {
      createClothesBaseImage.value = result.files.single.path!;
      logger.i(createClothesBaseImage.value);
    }
  }

  Future<void> pickFile(bool isBaseImage) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null && result.files.single.path != null) {
      if (isBaseImage) {
        baseImagePath.value = result.files.single.path!;
        logger.i(baseImagePath.value);
      } else {
        clothesImagePath.value = result.files.single.path!;
        logger.i(clothesImagePath.value);
      }
    }
  }

  Future<dynamic> createCloth() async {
    String category = "upper_body";
    if (dropDownValue2.value == 'Lower Body') {
      category = "lower_body";
    } else if (dropDownValue2.value == 'Dresses') {
      category = "dresses";
    } else {
      category = "upper_body";
    }
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://web-production-27e6.up.railway.app/create'));
    request.fields.addAll({
      'text_prompt': textprompt.text,
      'category': category,
    });
    request.files.add(await http.MultipartFile.fromPath(
        'file', createClothesBaseImage.value));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      logger.i(response);
      var imageURL = await response.stream.bytesToString();
      logger.i(imageURL);
      return imageURL;
    } else {
      logger.e(response.reasonPhrase);
      return false;
    }
  }

  Future<dynamic> swapClothes() async {
    String category = "lower_body";
    if (dropDownValue.value == 'Lower Body') {
      category = "lower_body";
    } else if (dropDownValue.value == 'Dresses') {
      category = "dresses";
    } else {
      category = "upper_body";
    }
    var headers = {'Content-Type': 'multipart/form-data'};
    var request = http.MultipartRequest('POST',
        Uri.parse('https://web-production-27e6.up.railway.app/swap-clothes'));
    request.fields.addAll({'category': category});
    request.files.add(
        await http.MultipartFile.fromPath('person_image', baseImagePath.value));
    request.files.add(await http.MultipartFile.fromPath(
        'clothes_design', clothesImagePath.value));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      logger.i(response);
      var imageURL = await response.stream.bytesToString();
      logger.i(imageURL);
      return imageURL;
    } else {
      logger.e(response.reasonPhrase);
      return false;
    }
  }

  Future<void> logout() async {
    await clearUserId();
    Get.offAllNamed('/login');
  }
}
