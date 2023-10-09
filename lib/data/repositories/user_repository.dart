// import 'package:glok/utils/meta_strings.dart';
// import 'package:http/http.dart' as http;

// import '../models/user_model.dart';

// class UserRepository {
//   Future<UserModel> getUser() async {
//     final response = await http
//         .get(Uri.parse(MetaStrings.baseUrl + MetaStrings.userEndpoint));
//     if (response.statusCode == 200) {
//       return userModelFromJson(response.body);
//     } else {
//       throw Exception('Failed to load user');
//     }
//   }
// }
