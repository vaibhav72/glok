import 'dart:convert';
import 'dart:developer';

import 'package:glok/data/models/glocker_model.dart';
import 'package:glok/utils/meta_strings.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:socket_io_client/socket_io_client.dart';
import '../../utils/helpers.dart';
import '../models/stats_model.dart';
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

  Future<GlockerModel> getGlockerDetails() async {
    try {
      var headers = await getHeaders();
      final response = await http.get(
          Uri.parse(MetaStrings.baseUrl + MetaStrings.getCurrentGlocker),
          headers: headers);
      if (response.statusCode == 200) {
        return glockerModelFromJson(response.body);
      } else {
        throw Exception('Failed to load user');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<GlockerModel> getGlockerDetailsById(int id) async {
    try {
      var headers = await getHeaders();
      final response = await http.get(
          Uri.parse(
              MetaStrings.baseUrl + MetaStrings.getGlocker + id.toString()),
          headers: headers);
      if (response.statusCode == 200) {
        return GlockerModel.fromJson(jsonDecode(response.body));
      } else {
        var parsedResponse = jsonDecode(response.body);
        throw parsedResponse["message"] ??
            parsedResponse["error"] ??
            "Failed to load glocker";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<GlockerModel>> getGlockerList({
    String? filters,
    int? index,
  }) async {
    var headers = await getHeaders();
    print(headers);
    String url =
        "${MetaStrings.baseUrl}${MetaStrings.getFilteredGlocker}${filters != null ? "?$filters" : ''}&page=$index&limit=10";
    final response = await http.get(Uri.parse(url.trim()), headers: headers);
    log(url);
    log(response.body);
    if (response.statusCode == 200) {
      var parsedResponse = jsonDecode(response.body);

      return (parsedResponse["glocker"] as List)
          .map((e) => GlockerModel.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to fetch glockers ${response.body}');
    }
  }

  Future<List<GlockerModel>> getTrendingGlockerList({
    int? index,
  }) async {
    var headers = await getHeaders();
    String url =
        MetaStrings.baseUrl + (MetaStrings.getFilteredGlocker) + ("/trending");
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      var parsedResponse = jsonDecode(response.body);
      log(parsedResponse.toString());

      return (parsedResponse["glocker"] as List)
          .map((e) => GlockerModel.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<bool> applyAsGlocker(
      {required Map<String, String> params,
      required XFile coverImage,
      required XFile profileImage}) async {
    Map<String, String> headers = await getHeaders(isForm: true);
    print(headers);
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

  Future<GlockerModel> updateGlockerDetails(GlockerModel data) async {
    var headers = await getHeaders();
    var params = {
      "name": data.name,
      "category": data.category,
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
      var fileExtension = getFileExtension(video.path);
      if (fileExtension.isEmpty) {
        throw "Invalid file extension";
      }
      var headers = await getHeaders(isForm: true);
      String url = MetaStrings.baseUrl + MetaStrings.updateVideKYC;
      var request = http.MultipartRequest(
        'PATCH',
        Uri.parse(url),
      );
      request.headers.addAll(headers);
      request.files.add(await http.MultipartFile.fromPath(
          'video_kyc', video.path,
          contentType: MediaType('application', fileExtension.toLowerCase())));
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

  favorite(int id) async {
    try {
      var headers = await getHeaders();
      final response = await http.patch(
          Uri.parse(MetaStrings.baseUrl + MetaStrings.getFavorites),
          body: jsonEncode({"glocker_id": id}),
          headers: headers);
      if (response.statusCode == 200) {
        return true;
      } else {
        var parsedResponse = jsonDecode(response.body);
        throw parsedResponse['error'] ??
            parsedResponse['message'] ??
            "Failed to add to favorites";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> createBid(int amount, int glockerId) async {
    try {
      var headers = await getHeaders();

      final response = await http.post(
          Uri.parse(MetaStrings.baseUrl + MetaStrings.bidNew),
          body: jsonEncode({"amount": amount, "glocker_id": glockerId}),
          headers: headers);
      if (response.statusCode == 200) {
        return true;
      } else {
        var parsedResponse = jsonDecode(response.body);
        throw parsedResponse['error'] ??
            parsedResponse['message'] ??
            "Failed to create bid";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> cancelBid(int userId, int glockerId) async {
    try {
      var headers = await getHeaders();

      final response = await http.patch(
          Uri.parse(MetaStrings.baseUrl + MetaStrings.cancelBid),
          body: jsonEncode({"user_id": userId, "glocker_id": glockerId}),
          headers: headers);
      if (response.statusCode == 200) {
        return true;
      } else {
        var parsedResponse = jsonDecode(response.body);
        throw parsedResponse['error'] ??
            parsedResponse['message'] ??
            "Failed to create bid";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> cancelAllBid() async {
    try {
      var headers = await getHeaders();

      final response = await http.patch(
          Uri.parse(MetaStrings.baseUrl + MetaStrings.cancelAllBid),
          headers: headers);
      if (response.statusCode == 200) {
        return true;
      } else {
        var parsedResponse = jsonDecode(response.body);
        throw parsedResponse['error'] ??
            parsedResponse['message'] ??
            "Failed to create bid";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> acceptCall(int userId) async {
    try {
      var headers = await getHeaders();
      final response = await http.patch(
          Uri.parse(MetaStrings.baseUrl + MetaStrings.acceptCall),
          body: jsonEncode({"user_id": userId}),
          headers: headers);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Couldnt accept call');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> startCallTrack(int callerId) async {
    try {
      var headers = await getHeaders();
      final response = await http.post(
          Uri.parse(MetaStrings.baseUrl + MetaStrings.startCall),
          body: jsonEncode({"caller_id": callerId}),
          headers: headers);
      if (response.statusCode == 200) {
        return true;
      } else {
        var parsedResponse = jsonDecode(response.body);
        throw parsedResponse['error'] ??
            parsedResponse['message'] ??
            "Couldnt start call";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> endCallTrack() async {
    try {
      var headers = await getHeaders();
      final response = await http.get(
          Uri.parse(MetaStrings.baseUrl + MetaStrings.endCall),
          headers: headers);
      if (response.statusCode == 200) {
        return true;
      } else {
        var parsedResponse = jsonDecode(response.body);
        throw parsedResponse['error'] ??
            parsedResponse['message'] ??
            "Couldnt end call";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<GlockerStatsModel> getStats() async {
    try {
      var headers = await getHeaders();
      final response = await http.get(
          Uri.parse(MetaStrings.baseUrl + MetaStrings.glockerUserStatistics),
          headers: headers);
      if (response.statusCode == 200) {
        return glockerStatsModelFromJson(response.body);
      } else {
        var parsedResponse = jsonDecode(response.body);
        throw parsedResponse['error'] ??
            parsedResponse['message'] ??
            "Couldnt get stats";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateonline() async {
    try {
      var headers = await getHeaders();
      final response = await http.patch(
          Uri.parse(MetaStrings.baseUrl + MetaStrings.updateOnlineStatus),
          headers: headers);
      if (response.statusCode == 200) {
        return jsonDecode(response.body)['online'];
      } else {
        var parsedResponse = jsonDecode(response.body);
        throw parsedResponse['error'] ??
            parsedResponse['message'] ??
            "Couldnt update status";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateGlockerRating(
      {required int userRating,
      required int callRate,
      required String comment,
      required int fanUserId}) async {
    try {
      var headers = await getHeaders();
      var params = {
        "user_rate": userRating,
        "call_rate": callRate,
        "comment": comment,
        "fan_user_id": fanUserId
      };
      final response = await http.post(
          Uri.parse(MetaStrings.baseUrl + MetaStrings.updateGlockerRating),
          body: jsonEncode(params),
          headers: headers);
      if (response.statusCode == 200) {
        return true;
      } else {
        var parsedResponse = jsonDecode(response.body);
        throw parsedResponse['error'] ??
            parsedResponse['message'] ??
            "Couldnt update rating";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateUserRating(
      {required int personRating,
      required int callRate,
      required String comment,
      required int glockerId}) async {
    try {
      var headers = await getHeaders();
      var params = {
        "person_rate": personRating,
        "call_rate": callRate,
        "comment": comment,
        "glocker_id": glockerId
      };
      final response = await http.post(
          Uri.parse(MetaStrings.baseUrl + MetaStrings.updateUserRating),
          body: jsonEncode(params),
          headers: headers);
      if (response.statusCode == 200) {
        return true;
      } else {
        var parsedResponse = jsonDecode(response.body);
        throw parsedResponse['error'] ??
            parsedResponse['message'] ??
            "Couldnt update rating";
      }
    } catch (e) {
      rethrow;
    }
  }
}
