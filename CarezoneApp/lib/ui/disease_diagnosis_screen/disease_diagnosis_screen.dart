import 'dart:convert';
import 'dart:io';
import 'package:carezone/ui/resourses/Color_manager.dart';
import 'package:carezone/ui/resourses/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;

class DiseaseDiagosis extends StatefulWidget {
  const DiseaseDiagosis({super.key});
  @override
  State<DiseaseDiagosis> createState() => _DiseaseDiagosisState();
}

class _DiseaseDiagosisState extends State<DiseaseDiagosis> {
  String? result;
  final picker = ImagePicker();
  File? img;
  var url = 'https://hamada-production.up.railway.app/predictApi';
  Future pickImage() async {
    // ignore: deprecated_member_use
    PickedFile? pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile == null) {
      return;
    } else {
      setState(() {
        img = File(pickedFile.path);
        result = null;
      });
    }
  }

  upload() async {
    setState(() {
      // Show the progress indicator
      result = 'waiting...';
    });
    final request = http.MultipartRequest('POST', Uri.parse(url));
    final header = {'Content_type': 'multipart/form-data'};
    request.files.add(http.MultipartFile(
        'fileup', img!.readAsBytes().asStream(), img!.lengthSync(),
        filename: img!.path.split('/').last));
    request.headers.addAll(header);
    final myRequest = await request.send();
    http.Response res = await http.Response.fromStream(myRequest);
    if (myRequest.statusCode == 200) {
      final resJson = jsonDecode(res.body);
      print('response here: $resJson');
      result = resJson['prediction'];
    } else {
      print('Error ${myRequest.statusCode}');
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Brain Tumor Detection',
            style: TextStyle(color: Colors.black87, fontSize: AppSize.s20)),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            size: 26,
            color: ColorManager.black,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.symmetric(horizontal: AppSize.s4),
                width: MediaQuery.of(context).size.width,
                height: 170,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Let's start the diagnosis, upload the x-ray",
                      style: GoogleFonts.lato(
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    ElevatedButton.icon(
                        icon: Icon(
                          Icons.image_outlined,
                          size: 26,
                          color: ColorManager.darkPrimary,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 3,
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 24,
                          ),
                        ),
                        label: const Text(
                          'Pick image',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                        onPressed: () async {
                          await pickImage();
                        }),
                    const SizedBox(
                      height: 3,
                    ),
                    Visibility(
                      visible: img != null ? true : false,
                      child: ElevatedButton.icon(
                        icon: const Icon(
                          Icons.upload_file,
                          size: 28,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'Upload to see result',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 3,
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 24,
                          ),
                        ),
                        onPressed: () async {
                          await upload();
                        },
                      ),
                    ),
                  ],
                )),
            const SizedBox(
              height: 7,
            ),
            img == null
                ? Center(child: Lottie.asset('images/100943-perulogy.json'))
                : Image.file(img!),
            const SizedBox(
              height: AppSize.s16,
            ),
            result == null
                ? const Text('')
                : Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 24,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Text(
                      result ?? '',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
