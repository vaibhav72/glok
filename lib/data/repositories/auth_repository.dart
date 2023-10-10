import 'dart:convert';

import 'package:glok/data/models/user_model.dart';
import 'package:glok/utils/meta_strings.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AuthRepository {
  Future<bool> registerUser(var params, XFile file) async {
    try {
      String url = MetaStrings.baseUrl + MetaStrings.userRegistrationUrl;
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields.addAll(params);
      request.files.add(await http.MultipartFile.fromPath('photo', file.path));
      var response = await request.send();
      if (response.statusCode == 200) {
        return true;
      } else {
        var responseBody = jsonDecode(response.stream.toString());
        throw responseBody['error'] ?? "Failed to register user";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> login(String phone) async {
    try {
      String url = MetaStrings.baseUrl + MetaStrings.generateOtp;
      var response = await http.post(Uri.parse(url),
          body: jsonEncode({'mobile_number': phone}));
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 400) {
        throw 400;
      } else {
        var responseBody = jsonDecode(response.body);
        throw responseBody['error'] ?? "Failed to send OTP";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> verifyOtp(String phone, String otp) async {
    try {
      String url = MetaStrings.baseUrl + MetaStrings.loginVerifyOTP;
      var response = await http.post(Uri.parse(url),
          body: jsonEncode({'mobile_number': phone, 'otp': otp}));
      if (response.statusCode == 200) {
        UserModel data = userModelFromJson(response.body);
        if (data.accessToken != null) {
          await Hive.box('app').put("token", data.accessToken);
          return data;
        } else {
          throw "Failed to verify OTP!! access token missing";
        }
      } else {
        var responseBody = jsonDecode(response.body);
        throw responseBody['error'] ?? "Failed to verify OTP";
      }
    } catch (e) {
      rethrow;
    }
  }
}
