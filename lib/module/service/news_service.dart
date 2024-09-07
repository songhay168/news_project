import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:news_project/module/model/news_model.dart';

class NewsService {
  static Future<NewsModel> fetchData() async {
    http.Response response = await http.get(Uri.parse(
        "https://newsapi.org/v2/everything?q=all&apiKey=0658b2948c28497db1268413c9b3386f"));
    // return compute(_convertData, response.body);
    return compute(newsModelFromJson, response.body);
  }
}
