import 'dart:convert';

import 'package:glok/data/models/glocker_model.dart';
import 'package:glok/utils/meta_strings.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../models/user_model.dart';

class GlockerRepository {
  Future<String> getToken() async {
    return Hive.box("app").get("token");
  }

  Future<Map<String, String>> getHeaders({bool isForm = false}) async {
    return {
      "Authorization": "Bearer ${await getToken()}",
      if (!isForm) "Content-Type": "application/json"
    };
  }

  Future<bool> applyAsGlocker(
      {required Map<String, String> params,
      required XFile coverImage,
      required XFile profileImage}) async {
    Map<String, String> headers = await getHeaders(isForm: true);
    try {
      String url = MetaStrings.baseUrl + MetaStrings.glockerNew;
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll(headers);
      request.fields.addAll(params);
      request.files.add(await http.MultipartFile.fromPath(
          'glocker_profile', profileImage.path));
      request.files.add(
          await http.MultipartFile.fromPath('cover_photo', coverImage.path));
      var response = await request.send();
      if (response.statusCode == 201) {
        return true;
      } else {
        var parsedResponse = await http.Response.fromStream(response);
        var responseBody = jsonDecode(parsedResponse.body);
        throw responseBody['error'] ?? "Failed to register user";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<GlockerModel> updateGlockerDetails(GlockerModel data) async {
    var headers = await getHeaders();
    var params = {
      "name": data.name,
      "category": data..category,
      "about_me": data.aboutMe,
      "price": data.price
    };
    final response = await http.patch(
        Uri.parse(MetaStrings.baseUrl + MetaStrings.glockerUpdate),
        body: jsonEncode(params),
        headers: headers);
    if (response.statusCode == 200) {
      return GlockerModel.fromJson(jsonDecode(response.body)["glocker"]);
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<bool> updateGlockerProfile(XFile file) async {
    try {
      var headers = await getHeaders(isForm: true);
      String url = MetaStrings.baseUrl + MetaStrings.updateGlockerPhoto;
      var request = http.MultipartRequest('PATCH', Uri.parse(url));
      request.headers.addAll(headers);
      request.files
          .add(await http.MultipartFile.fromPath('profile_photo', file.path));
      var response = await request.send();
      if (response.statusCode == 200) {
        return true;
      } else {
        var parsedResponse = await http.Response.fromStream(response);
        var responseBody = jsonDecode(parsedResponse.body);
        throw responseBody['error'] ?? "Failed to register user";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateGlockerCover(XFile file) async {
    try {
      var headers = await getHeaders(isForm: true);
      String url = MetaStrings.baseUrl + MetaStrings.updateGlockerCoverPhoto;
      var request = http.MultipartRequest('PATCH', Uri.parse(url));
      request.headers.addAll(headers);
      request.files
          .add(await http.MultipartFile.fromPath('cover_photo', file.path));
      var response = await request.send();
      if (response.statusCode == 200) {
        return true;
      } else {
        var parsedResponse = await http.Response.fromStream(response);
        var responseBody = jsonDecode(parsedResponse.body);
        throw responseBody['error'] ?? "Failed to register user";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateGlockerAdhaarPhotos(
      {required XFile aadhaarFront, required XFile aadhaarBack}) async {
    try {
      var headers = await getHeaders(isForm: true);
      String url = MetaStrings.baseUrl + MetaStrings.updateAadharFile;
      var request = http.MultipartRequest('PATCH', Uri.parse(url));
      request.headers.addAll(headers);
      request.files.add(
          await http.MultipartFile.fromPath('aadhar_front', aadhaarFront.path));
      request.files.add(
          await http.MultipartFile.fromPath('aadhar_back', aadhaarBack.path));
      var response = await request.send();
      if (response.statusCode == 200) {
        return true;
      } else {
        var parsedResponse = await http.Response.fromStream(response);
        var responseBody = jsonDecode(parsedResponse.body);
        throw responseBody['error'] ?? "Failed to register user";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateGlockerVideoKYC({required XFile video}) async {
    try {
      var headers = await getHeaders(isForm: true);
      String url = MetaStrings.baseUrl + MetaStrings.updateVideKYC;
      var request = http.MultipartRequest('PATCH', Uri.parse(url));
      request.headers.addAll(headers);
      request.files
          .add(await http.MultipartFile.fromPath('video_kyc', video.path));
      var response = await request.send();
      if (response.statusCode == 200) {
        return true;
      } else {
        var parsedResponse = await http.Response.fromStream(response);
        var responseBody = jsonDecode(parsedResponse.body);
        throw responseBody['error'] ?? "Failed to register user";
      }
    } catch (e) {
      rethrow;
    }
  }
}
