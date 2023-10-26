import 'dart:convert';
import 'dart:developer';

import 'package:glok/data/models/glocker_model.dart';
import 'package:glok/utils/meta_strings.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../models/gallery_model.dart';
import '../models/user_model.dart';

class GalleryRepository {
  Future<String> getToken() async {
    return Hive.box("app").get("token");
  }

  Future<Map<String, String>> getHeaders({bool isForm = false}) async {
    return {
      "Authorization": "Bearer ${await getToken()}",
      if (!isForm) "Content-Type": "application/json"
    };
  }

  Future<List<GalleryItem?>> getMyGallery(int page) async {
    try {
      var headers = await getHeaders();
      final response = await http.get(
          Uri.parse(
              "${MetaStrings.baseUrl}${MetaStrings.getMyGallery}?page=$page&limit=10"),
          headers: headers);
      if (response.statusCode == 200) {
        return (jsonDecode(response.body) as Map).values.map((e) {
          if (e is Map<String, dynamic>) return GalleryItem.fromJson(e);
        }).toList()
          ..remove(null);
      } else {
        throw Exception('Failed to load gallery');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<GalleryItem?>> getGlockerGallery(
      {required int glockerId,
      required int page,
      required String category}) async {
    try {
      var headers = await getHeaders();
      String url =
          "${MetaStrings.baseUrl}${MetaStrings.getGlockerGallery}?id=$glockerId&page=$page&limit=10&category=$category";
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        log(response.body);
        return (jsonDecode(response.body)["gallery"] as List).map((e) {
          return GalleryItem.fromJson(e);
        }).toList();
      } else {
        throw Exception('Failed to load gallery');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> uploadPhoto(XFile file) async {
    try {
      var headers = await getHeaders(isForm: true);
      String url = MetaStrings.baseUrl + MetaStrings.updateGalleryPhoto;
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll(headers);
      request.files.add(await http.MultipartFile.fromPath('photo', file.path));
      var response = await request.send();
      if (response.statusCode == 200) {
        return true;
      } else {
        var parsedResponse = await http.Response.fromStream(response);
        var responseBody = jsonDecode(parsedResponse.body);
        throw responseBody['error'] ?? "Failed to upload photo";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> uploadVideo(XFile file) async {
    try {
      var headers = await getHeaders(isForm: true);
      String url = MetaStrings.baseUrl + MetaStrings.updateGalleryVideo;
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll(headers);
      request.files.add(await http.MultipartFile.fromPath('vidoe', file.path));
      var response = await request.send();
      if (response.statusCode == 200) {
        return true;
      } else {
        var parsedResponse = await http.Response.fromStream(response);
        var responseBody = jsonDecode(parsedResponse.body);
        throw responseBody['error'] ?? "Failed to upload photo";
      }
    } catch (e) {
      rethrow;
    }
  }

  deleteGalleryItem(String i) async {
    try {
      var headers = await getHeaders();
      String url = MetaStrings.baseUrl + MetaStrings.getMyGallery + "/$i";
      final response = await http.delete(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        return true;
      } else {
        var responseBody = jsonDecode(response.body);
        throw responseBody['error'] ?? "Failed to delete item";
      }
    } catch (e) {
      rethrow;
    }
  }
}
