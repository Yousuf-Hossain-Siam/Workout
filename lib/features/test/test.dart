import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:luna_3/core/services/network_caller.dart';
import 'package:luna_3/core/services/storage_service.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  bool _isPickingImage = false;
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  final _logger = Logger();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text('Test Screen', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("upload your photo", style: TextStyle(color: Colors.white)),
              SizedBox(height: 16),
              InkWell(
                onTap: () {
                  _uploadPhoto(context);
                },
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child:
                      _image != null
                          ? Image.file(File(_image!.path), fit: BoxFit.cover)
                          : Center(
                            child: Icon(
                              Icons.upload,
                              size: 50,
                              color: Colors.black,
                            ),
                          ),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _onClickedSaveImage,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                child: Text("Save", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _uploadPhoto(BuildContext context) async {
    if (_isPickingImage) return;

    setState(() {
      _isPickingImage = true;
    });

    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (mounted) {
        if (image != null) {
          setState(() {
            _image = image;
          });
          Get.snackbar("Success", "Image uploaded successfully");
        } else {
          Get.snackbar("Info", "No image selected");
        }
      }
    } catch (e) {
      if (mounted) {
        Get.snackbar("Error", "Failed to pick image: ${e.toString()}");
      }
    } finally {
      if (mounted) {
        setState(() {
          _isPickingImage = false;
        });
      }
    }
  }

  Future<void> _onClickedSaveImage() async {
    EasyLoading.show(status: 'Uploading...');

    final response = await Get.find<NetworkCaller>().multipartRequest(
      url:
          'https://luna3server.onrender.com/api/v1/exercise/createPersonalizeExercise',
      jsonData: {
        'name': 'barbell carl',
        'description': 'great exercise',
        'primaryMuscleGroup': 'Calves',
        'exerciseType': 'cardio',
      },
      image: _image,
    );

    if (response.isSuccess) {
      EasyLoading.showSuccess('✅ ${response.responseData['message']}');
    } else {
      EasyLoading.showError(response.errorMessage ?? 'Something went wrong');
    }

    EasyLoading.dismiss();
  }

  Future<void> _onClickedSaveImage111() async {
    EasyLoading.show(status: 'Uploading...');
    if (_image == null) {
      EasyLoading.dismiss();
      return;
    }

    try {
      final file = File(_image!.path);
      final url = Uri.parse(
        'https://luna3server.onrender.com/api/v1/exercise/createPersonalizeExercise',
      );

      // Create the multipart request
      var request = http.MultipartRequest('POST', url);

      // Add headers
      final token = StorageService.accessToken;
      if (token != null) {
        request.headers['Authorization'] = token;
      }
      request.headers['Content-Type'] = 'application/json';

      // Add file
      var stream = http.ByteStream(file.openRead());
      var length = await file.length();
      var multipartFile = http.MultipartFile(
        'file',
        stream,
        length,
        filename: file.path.split('/').last,
      );

      // Create JSON data
      final jsonData = {
        'name': 'barbell carl',
        'description': 'great exercise',
        'primaryMuscleGroup': 'Calves',
        'exerciseType': 'cardio',
      };

      // Add JSON data as a field
      request.fields['data'] = jsonEncode(jsonData);
      request.files.add(multipartFile);

      _logger.i("Sending request to: $url");
      _logger.i("Headers: ${request.headers}");
      _logger.i("JSON Data: $jsonData");

      // Send the request
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      _logger.i("Response status: ${response.statusCode}");
      _logger.i("Response body: $responseBody");

      if (response.statusCode == 200) {
        Get.snackbar(
          "Success",
          "Image uploaded successfully",
          colorText: Colors.white,
          backgroundColor: Colors.green,
          icon: const Icon(Icons.check_circle, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      } else {
        final error = jsonDecode(responseBody);
        Get.snackbar(
          "Error",
          error['message'] ??
              "Failed to upload image. Status: ${response.statusCode}",
          colorText: Colors.white,
          backgroundColor: Colors.red,
          icon: const Icon(Icons.error, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 4),
        );
      }
    } catch (e, stackTrace) {
      _logger.e("Error uploading file", error: e, stackTrace: stackTrace);
      Get.snackbar(
        "Error",
        "Failed to upload image: ${e.toString()}",
        colorText: Colors.white,
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 4),
      );
    } finally {
      EasyLoading.dismiss();
    }
  }
}
