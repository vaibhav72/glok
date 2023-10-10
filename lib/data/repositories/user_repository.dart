import 'package:glok/utils/meta_strings.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';

class UserRepository {
  Future<String> getToken() async {
    return Hive.box("app").get("token");
  }

  Future<UserModel> getUserDetails() async {
    var headers = {"Authorization": "Bearer ${await getToken()}"};
    final response = await http.get(
        Uri.parse(MetaStrings.baseUrl + MetaStrings.getCurrentuser),
        headers: headers);
    if (response.statusCode == 200) {
      return userModelFromJson(response.body);
    } else {
      throw Exception('Failed to load user');
    }
  }
}
