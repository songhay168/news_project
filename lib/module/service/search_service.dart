import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../model/error_model.dart';
import '../model/news_model.dart';
import '../model/respone_model.dart';

//android, change from localhost -> 10.0.2.2
const someUrl =
    "https://newsapi.org/v2/everything?apiKey=0658b2948c28497db1268413c9b3386f&q=";

class SearchService {
  static Future<ResponeModel> searchData(String query) async {
    query = query.isEmpty ? " " : query;
    http.Response response = await http.get(Uri.parse(someUrl + query));
    Map map = json.decode(response.body);
    String status = map['status'];
    bool success = status == "ok";
    if (success) {
      return compute(newsModelFromJson, response.body);
    } else {
      return compute(errorProductModelFromJson, response.body);
    }
  }
}
