import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:histreet/home/controller/home_controller.dart';
import 'package:histreet/widgets/custom_loader.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.put(HomeController());
  CustomLoader customLoader = CustomLoader();

  void _showImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        imageUrl = imageUrl.replaceAll('"', '');
        return AlertDialog(
          title: const Text('Image URL'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SelectableText(imageUrl),
              const SizedBox(height: 10),
              CachedNetworkImage(
                imageUrl: imageUrl,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          backgroundColor: const Color.fromRGBO(14, 17, 23, 1.0),
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(14, 17, 23, 1.0),
            title: Text(
              'HiStreet',
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 20.0),
            ),
            actions: [
              IconButton(
                onPressed: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    backgroundColor: Colors.grey[900],
                    title: Text(
                      'Log out',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                      ),
                    ),
                    content: Text(
                      'Are you sure, you want to log out?',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          homeController.logout();
                        },
                        child: Text(
                          'Yes',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'No',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                icon: const Icon(
                  Icons.logout,
                  color: Color.fromRGBO(133, 133, 133, 1.0),
                ),
              ),
            ],
            bottom: TabBar(
              labelColor: Colors.red,
              unselectedLabelColor: Colors.white,
              indicator: const BoxDecoration(
                color: Colors
                    .transparent, // To make the underline color transparent and set the border manually
                border: Border(
                  bottom: BorderSide(
                    color: Colors.red, // Thickness of the underline
                  ),
                ),
              ),
              tabs: <Widget>[
                Text(
                  'Swap Clothes',
                  style: GoogleFonts.poppins(
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  'Create Clothes',
                  style: GoogleFonts.poppins(
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 10.0,
                                right: 10.0,
                                bottom: 10.0,
                                top: 20.0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Text(
                                      'Clothes Swap with Stable Diffusion',
                                      style: GoogleFonts.poppins(
                                          color: Colors.white, fontSize: 18.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 10.0,
                                right: 10.0,
                                bottom: 10.0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Text(
                                      'Upload the base image and the clothes design image to swap clothes.',
                                      softWrap: true,
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Obx(
                              () => buildSwapClothesBaseImage(
                                'Upload Base Image',
                                homeController.baseImagePath.value,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 20.0,
                              ),
                              child: Obx(
                                () => buildSwapClothesClothesDesign(
                                    'Upload Clothes Design Image',
                                    homeController.clothesImagePath.value),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0, bottom: 20.0),
                              child: Container(
                                color: const Color.fromRGBO(38, 39, 48, 1.0),
                                child: DropdownMenu<String>(
                                  textStyle: GoogleFonts.poppins(
                                    color: Colors.white,
                                  ),
                                  menuStyle: MenuStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      const Color.fromRGBO(38, 39, 48, 1.0),
                                    ),
                                  ),
                                  initialSelection: homeController.list.first,
                                  onSelected: (String? value) {
                                    homeController.dropDownValue.value = value!;
                                  },
                                  dropdownMenuEntries: homeController.list
                                      .map<DropdownMenuEntry<String>>(
                                          (String value) {
                                    return DropdownMenuEntry<String>(
                                      value: value,
                                      label: value,
                                      style: MenuItemButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        textStyle: GoogleFonts.poppins(
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0, bottom: 20.0),
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  side: const BorderSide(
                                    color: Color.fromRGBO(65, 68, 76, 1.0),
                                    width: 1.0,
                                  ),
                                ),
                                onPressed: () async {
                                  //TODO: API Call
                                  customLoader.showLoader(context);
                                  var response =
                                      await homeController.swapClothes();
                                  customLoader.hideLoader();
                                  if (response == false) {
                                    ScaffoldMessenger.of(context)
                                        .clearSnackBars();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Error Occurred'),
                                        duration: Duration(seconds: 1),
                                      ),
                                    );
                                  } else {
                                    _showImageDialog(context, response);
                                  }
                                },
                                child: Text(
                                  'Swap Clothes',
                                  style:
                                      GoogleFonts.poppins(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 10.0,
                                right: 10.0,
                                bottom: 10.0,
                                top: 20.0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Text(
                                      'Clothes Swap with Stable Diffusion',
                                      style: GoogleFonts.poppins(
                                          color: Colors.white, fontSize: 18.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 10.0,
                                right: 10.0,
                                bottom: 10.0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Text(
                                      'Upload the base image and the clothes design image to swap clothes.',
                                      softWrap: true,
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Obx(
                              () => buildCreateClothesBaseImage(
                                'Upload Base Image',
                                homeController.baseImagePath.value,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0, bottom: 20.0),
                              child: TextFormField(
                                controller: homeController.textprompt,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor:
                                      const Color.fromRGBO(38, 39, 48, 1.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide.none, // No border
                                  ),
                                  hintText: 'Enter a prompt for design',
                                  hintStyle: GoogleFonts.poppins(),
                                ),
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                ),
                                cursorColor: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0, bottom: 20.0),
                              child: Container(
                                color: const Color.fromRGBO(38, 39, 48, 1.0),
                                child: DropdownMenu<String>(
                                  textStyle: GoogleFonts.poppins(
                                    color: Colors.white,
                                  ),
                                  menuStyle: MenuStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      const Color.fromRGBO(38, 39, 48, 1.0),
                                    ),
                                  ),
                                  initialSelection: homeController.list2.first,
                                  onSelected: (String? value) {
                                    homeController.dropDownValue2.value =
                                        value!;
                                  },
                                  dropdownMenuEntries: homeController.list2
                                      .map<DropdownMenuEntry<String>>(
                                          (String value) {
                                    return DropdownMenuEntry<String>(
                                      value: value,
                                      label: value,
                                      style: MenuItemButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        textStyle: GoogleFonts.poppins(
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0, bottom: 20.0),
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  side: const BorderSide(
                                    color: Color.fromRGBO(65, 68, 76, 1.0),
                                    width: 1.0,
                                  ),
                                ),
                                onPressed: () async {
                                  //TODO: API Call
                                  customLoader.showLoader(context);
                                  var response =
                                      await homeController.createCloth();
                                  customLoader.hideLoader();
                                  if (response == false) {
                                    ScaffoldMessenger.of(context)
                                        .clearSnackBars();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Error Occurred'),
                                        duration: Duration(seconds: 1),
                                      ),
                                    );
                                  } else {
                                    _showImageDialog(context, response);
                                  }
                                },
                                child: Text(
                                  'Create Clothes',
                                  style:
                                      GoogleFonts.poppins(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCreateClothesBaseImage(String title, String? imagePath) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () => homeController.createClothesPickFile(),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(38, 39, 48, 1.0),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.cloud_upload, size: 50, color: Colors.white),
                const SizedBox(height: 10),
                const Text(
                  'Drag and drop file here',
                  style: TextStyle(color: Colors.white),
                ),
                const Text(
                  'Limit 200MB per file • PNG, JPG, JPEG',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => homeController.createClothesPickFile(),
                  child: const Text('Browse files'),
                ),
                if (homeController.createClothesBaseImage.value != '') ...[
                  const SizedBox(height: 10),
                  Image.file(
                    File(homeController.createClothesBaseImage.value),
                    height: 100,
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSwapClothesBaseImage(String title, String? imagePath) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () => homeController.pickFile(true),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(38, 39, 48, 1.0),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.cloud_upload, size: 50, color: Colors.white),
                const SizedBox(height: 10),
                const Text(
                  'Drag and drop file here',
                  style: TextStyle(color: Colors.white),
                ),
                const Text(
                  'Limit 200MB per file • PNG, JPG, JPEG',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => homeController.pickFile(true),
                  child: const Text('Browse files'),
                ),
                if (homeController.baseImagePath.value != '') ...[
                  const SizedBox(height: 10),
                  Image.file(
                    File(homeController.baseImagePath.value),
                    height: 100,
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSwapClothesClothesDesign(String title, String? imagePath) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () => HomeController().pickFile(false),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(38, 39, 48, 1.0),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.cloud_upload, size: 50, color: Colors.white),
                const SizedBox(height: 10),
                const Text(
                  'Drag and drop file here',
                  style: TextStyle(color: Colors.white),
                ),
                const Text(
                  'Limit 200MB per file • PNG, JPG, JPEG',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => homeController.pickFile(false),
                  child: const Text('Browse files'),
                ),
                if (homeController.clothesImagePath.value != '') ...[
                  const SizedBox(height: 10),
                  Image.file(
                    File(homeController.clothesImagePath.value),
                    height: 100,
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
