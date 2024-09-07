import 'package:flutter/material.dart';
import 'package:news_project/module/model/error_model.dart';
import 'package:news_project/module/model/news_model.dart';
import 'package:news_project/module/service/search_service.dart';

import '../model/respone_model.dart';

class SearchLogic extends ChangeNotifier {
  NewsModel _foundProduct =
      NewsModel(status: "error", totalResults: 0, articles: []);
  NewsModel get foundProduct => _foundProduct;

  bool _loading = false;
  bool get loading => _loading;

  void enableLoading() {
    _loading = true;
    notifyListeners();
  }

  void disableLoading() {
    _loading = false;
    notifyListeners();
  }

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetch(String query) async {
    enableLoading();
    try {
      ResponeModel response = await SearchService.searchData(query);

      if (response.getStatus() == 'ok') {
        _foundProduct = response as NewsModel;

        // Remove articles with content "[Removed]" and urlToImage null
        _foundProduct.articles = _foundProduct.articles
            .where((article) =>
                article.content != "[Removed]" &&
                article.urlToImage != null &&
                article.urlToImage != "")
            .toList();

        _errorMessage = null;
      } else {
        ErrorModel errorMessage = response as ErrorModel;
        _errorMessage = errorMessage.message;
      }
    } catch (e) {
      _errorMessage = e.toString();
    }

    disableLoading();
    notifyListeners();
  }
}
