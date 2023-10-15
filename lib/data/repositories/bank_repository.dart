import 'dart:convert';

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
    var headers = await getHeaders();
    final response = await http.post(
        Uri.parse(MetaStrings.baseUrl + MetaStrings.updatebank),
        body: jsonEncode(params),
        headers: headers);
    if (response.statusCode == 201) {
      return BankModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<List<TransactionModel>> getAlltransactions() async {
    try {
      var headers = await getHeaders();
      final response = await http.get(
          Uri.parse(MetaStrings.baseUrl + MetaStrings.getAllTransactions),
          headers: headers);
      if (response.statusCode == 200) {
        return (jsonDecode(response.body) as List)
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
    var headers = await getHeaders();
    final response = await http.post(
        Uri.parse(MetaStrings.baseUrl + MetaStrings.addFunds),
        body: jsonEncode({"amount": amount}),
        headers: headers);
    if (response.statusCode == 201) {
      return TransactionModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<TransactionModel> withdrawFunds(double amount) async {
    var headers = await getHeaders();
    final response = await http.post(
        Uri.parse(MetaStrings.baseUrl + MetaStrings.withdrawFunds),
        body: jsonEncode({"amount": amount}),
        headers: headers);
    if (response.statusCode == 201) {
      return TransactionModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }
}
