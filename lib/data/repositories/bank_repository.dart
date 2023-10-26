import 'dart:convert';
import 'dart:developer';

import 'package:glok/data/models/transaction_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import '../../utils/meta_strings.dart';
import '../models/bank_model.dart';
import '../models/wallet_model.dart';

class BankRepository {
  Future<String> getToken() async {
    return Hive.box("app").get("token");
  }

  Future<Map<String, String>> getHeaders({bool isForm = false}) async {
    return {
      "Authorization": "Bearer ${await getToken()}",
      if (!isForm) "Content-Type": "application/json"
    };
  }

  Future<BankModel> addBank(Map<String, String> params) async {
    try {
      var headers = await getHeaders();
      final response = await http.post(
          Uri.parse(MetaStrings.baseUrl + MetaStrings.updatebank),
          body: jsonEncode(params),
          headers: headers);
      if (response.statusCode == 200) {
        return BankModel.fromJson(jsonDecode(response.body));
      } else {
        var parsedResponse = jsonDecode(response.body);
        throw parsedResponse["message"] ??
            parsedResponse['error'] ??
            Exception('Failed to add bank');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TransactionModel>> getAlltransactions({
    required int page,
  }) async {
    try {
      var headers = await getHeaders();
      final response = await http.get(
          Uri.parse(MetaStrings.baseUrl +
              MetaStrings.getAllTransactions +
              "?page=$page&limit=10"),
          headers: headers);
      if (response.statusCode == 200) {
        return (jsonDecode(response.body)["transaction"] as List)
            .map((e) => TransactionModel.fromJson(e))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<TransactionModel> addFunds(double amount) async {
    try {
      var headers = await getHeaders();
      final response = await http.post(
          Uri.parse(MetaStrings.baseUrl + MetaStrings.addFunds),
          body: jsonEncode({"amount": amount}),
          headers: headers);
      if (response.statusCode == 200) {
        return TransactionModel.fromJson(jsonDecode(response.body));
      } else {
        var parsedResponse = jsonDecode(response.body);
        throw parsedResponse["message"] ??
            parsedResponse['error'] ??
            Exception('Failed to add funds');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<TransactionModel> withdrawFunds(double amount) async {
    try {
      var headers = await getHeaders();
      final response = await http.post(
          Uri.parse(MetaStrings.baseUrl + MetaStrings.withdrawFunds),
          body: jsonEncode({"amount": amount}),
          headers: headers);
      if (response.statusCode == 200) {
        return TransactionModel.fromJson(jsonDecode(response.body));
      } else {
        var parsedResponse = jsonDecode(response.body);
        throw parsedResponse["message"] ??
            parsedResponse['error'] ??
            Exception('Failed to withdraw funds');
      }
    } catch (e) {
      rethrow;
    }
  }
}
