import 'dart:convert';
import 'dart:developer';

import 'package:glok/utils/meta_strings.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../models/user_model.dart';
import '../models/wallet_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class UserRepository {
  Future<String> getToken() async {
    return Hive.box("app").get("token");
  }

  Future<Map<String, String>> getHeaders({bool isForm = false}) async {
    return {
      "Authorization": "Bearer ${await getToken()}",
      if (!isForm) "Content-Type": "application/json"
    };
  }

  Future<UserModel> getUserDetails() async {
    var headers = await getHeaders();
    final response = await http.get(
        Uri.parse(MetaStrings.baseUrl + MetaStrings.getCurrentuser),
        headers: headers);
    if (response.statusCode == 200) {
      log(response.body);
      return UserModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      throw 401;
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<UserModel> updateUserDetails(UserModel data) async {
    var headers = await getHeaders();
    var params = {
      "name": data.name,
      "gender": data.gender,
      "mobile_number": data.mobileNumber,
      "email": data.email,
      "photo": data.photo
    };
    final response = await http.patch(
        Uri.parse(MetaStrings.baseUrl + MetaStrings.updateUser),
        body: jsonEncode(params),
        headers: headers);
    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body)["user"]);
    } else {
      var parsedResponse = jsonDecode(response.body);
      throw parsedResponse["error"] ??
          parsedResponse["message"] ??
          "Failed to update user";
    }
  }

  Future<bool> updateUserPhoto(XFile file) async {
    try {
      var headers = await getHeaders(isForm: true);
      String url = MetaStrings.baseUrl + MetaStrings.updateUserPhoto;
      var request = http.MultipartRequest('PATCH', Uri.parse(url));
      request.headers.addAll(headers);
      request.files.add(await http.MultipartFile.fromPath('photo', file.path));
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

  Future<WalletModel> getMyWallet() async {
    var headers = await getHeaders();
    final response = await http.get(
        Uri.parse(MetaStrings.baseUrl + MetaStrings.getWalletDetails),
        headers: headers);
    if (response.statusCode == 200) {
      return WalletModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<bool> updateGlockerMode(bool isGlocker) async {
    try {
      var headers = await getHeaders();
      var params = {"is_glocker": isGlocker};
      final response = await http.patch(
          Uri.parse(MetaStrings.baseUrl + MetaStrings.changeGlockerMode),
          body: jsonEncode(params),
          headers: headers);
      if (response.statusCode == 200) {
        return true;
      } else {
        var parsedResponse = jsonDecode(response.body);
        throw parsedResponse["error"] ??
            parsedResponse["message"] ??
            "Failed to update user";
      }
    } catch (e) {
      rethrow;
    }
  }

  getSocket() async {
    try {
      IO.Socket socket = IO.io(
          MetaStrings.baseUrl + "/glok",
          OptionBuilder()
              .setExtraHeaders(await getHeaders())
              .setTransports(['websocket'])
              .disableAutoConnect() // for Flutter or Dart VM
              .build());
      return socket;
    } catch (e) {
      rethrow;
    }
  }
}
