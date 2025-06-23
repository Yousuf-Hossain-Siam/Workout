import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:luna_3/core/models/response_data.dart';
import 'package:luna_3/core/services/storage_service.dart';

class NetworkCaller {
  final Logger _logger = Logger();

  //? ------------------------------------------------
  //* Get Request
  //? ------------------------------------------------
  Future<ResponseData> getRequest({
    required String url,
    String? accessToken,
  }) async {
    try {
      // parse url
      final uri = Uri.parse(url);
      // create header
      Map<String, String> headers = {"content-type": "application/json"};
      if (accessToken != null) {
        headers["Authorization"] = accessToken; // Use the provided token
      } else {
        if (StorageService.accessToken != null) {
          headers["Authorization"] = StorageService.accessToken!;
        }
      }
      _logger.i("url: $url \n headers: $headers");
      // call http get
      final response = await http.get(uri, headers: headers);
      _logger.i(
        "url: $url \n statusCode: ${response.statusCode} \n headers: $headers \n body: ${response.body}",
      );

      // check is success
      if (response.statusCode == 200) {
        return ResponseData(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: jsonDecode(response.body),
        );
      } else {
        return ResponseData(
          statusCode: response.statusCode,
          isSuccess: false,
          errorMessage: jsonDecode(response.body)["message"] ?? "Unknown error",
        );
      }
    } catch (e) {
      _logger.e("url: $url \n status code: -1 \n error: $e");
      return ResponseData(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  //? ------------------------------------------------
  //* Post Request
  //? ------------------------------------------------
  Future<ResponseData> postRequest({
    required String url,
    Map<String, dynamic>? body,
    String? accessToken,
    bool needToken = true,
  }) async {
    try {
      final uri = Uri.parse(url);
      Map<String, String> headers = {"content-type": "application/json"};
      if (accessToken != null) {
        headers["Authorization"] = accessToken;
      } else if (StorageService.accessToken != null) {
        headers["Authorization"] = StorageService.accessToken!;
      } else if (needToken) {
        return ResponseData(
          statusCode: -1,
          isSuccess: false,
          errorMessage: "No token found",
        );
      }
      _logger.i("url: $url \n headers: $headers \n body: $body");
      // call http post
      final response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );
      _logger.i(
        "url: $url \n statusCode: ${response.statusCode} \n headers: $headers \n response: ${response.body}",
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ResponseData(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: data,
          errorMessage: data["message"],
        );
      } else {
        return ResponseData(
          statusCode: response.statusCode,
          isSuccess: false,
          errorMessage: data["message"] ?? "Unknown error",
        );
      }
    } catch (e) {
      _logger.e("url: $url \n status code: -1 \n error: $e");
      return ResponseData(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  //? ------------------------------------------------
  //* Multipart Request
  //? ------------------------------------------------
  Future<ResponseData> multipartRequest({
    required String url,
    required Map<String, dynamic> jsonData,
    required XFile? image,
    String? accessToken,
    bool? isPatchRequest = false,
    String fileName = "file",
    String fieldName = "data",
  }) async {
    if (image == null) {
      return ResponseData(
        isSuccess: false,
        statusCode: -1,
        errorMessage: "Image is null",
      );
    }
    try {
      final file = File(image.path);
      final uri = Uri.parse(url);

      // Create the multipart request
      var request = http.MultipartRequest('POST', uri);

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
        fileName,
        stream,
        length,
        filename: file.path.split('/').last,
      );

      // Add JSON data as a field
      request.fields[fieldName] = jsonEncode(jsonData);
      request.files.add(multipartFile);

      _logger.i("Sending request to: $url");
      _logger.i("Headers: ${request.headers}");
      _logger.i("JSON Data: $jsonData");

      // Send the request
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      _logger.i("Response status: ${response.statusCode}");
      _logger.i("Response body: $responseBody");

      if (response.statusCode >= 200 && response.statusCode < 300) {
        _logger.i('Url => $url\nResponse => $responseBody');
        return ResponseData(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: jsonDecode(responseBody),
        );
      } else {
        _logger.e('Url => $url\nResponse => $responseBody');
        return ResponseData(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: responseBody,
        );
      }
    } catch (e) {
      _logger.e('Url => $url\nError => $e');
      return ResponseData(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  //? ------------------------------------------------
  //* patch request
  //? ------------------------------------------------
  Future<ResponseData> patchRequest({
    required String url,
    required Map<String, dynamic> body,
    String? accessToken,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      final headers = {"Content-Type": "application/json"};

      if (accessToken != null) {
        headers['Authorization'] = accessToken;
      } else if (StorageService.accessToken != null) {
        headers['Authorization'] = StorageService.accessToken!;
      }

      http.Response response = await http.patch(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );
      _logger.i(
        "url: $url \n statusCode: ${response.statusCode} \n headers: $headers \n response: ${response.body}",
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ResponseData(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: jsonDecode(response.body),
        );
      } else {
        return ResponseData(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: jsonDecode(response.body)["message"] ?? "Unknown error",
        );
      }
    } catch (e) {
      _logger.e("url: $url \n status code: -1 \n error: $e");
      return ResponseData(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  //? ------------------------------------------------
  //! delete request
  //? ------------------------------------------------
  Future<ResponseData> deleteRequest(String url) async {
    try {
      Uri uri = Uri.parse(url);
      final headers = {"Content-Type": "application/json"};
      if (StorageService.accessToken != null) {
        headers['Authorization'] = "Bearer ${StorageService.accessToken}";
      }
      _logger.i("url: $url \n headers: $headers");
      http.Response response = await http.delete(uri, headers: headers);
      _logger.i(
        "url: $url \n statusCode: ${response.statusCode} \n headers: $headers \n body: ${response.body}",
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ResponseData(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: jsonDecode(response.body),
        );
      } else {
        return ResponseData(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: jsonDecode(response.body)["message"] ?? "Unknown error",
        );
      }
    } catch (e) {
      _logger.e("url: $url \n status code: -1 \n error: $e");
      return ResponseData(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }
}
