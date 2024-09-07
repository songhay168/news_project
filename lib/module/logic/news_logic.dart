import 'package:flutter/material.dart';
import 'package:news_project/module/model/news_model.dart';
import 'package:news_project/module/service/news_service.dart';

class NewsLogic extends ChangeNotifier {
  NewsModel _allNews = NewsModel(
    status: "",
    totalResults: 0,
    articles: [],
  );
  NewsModel get allNews => _allNews;

  bool _loading = false;
  bool get loading => _loading;
  bool _view = false;
  bool get view => _view;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void toggleView() {
    _view = !_view;
    notifyListeners();
  }

  void enableLoading() {
    _loading = true;
    notifyListeners();
  }

  void disableLoading() {
    _loading = false;
    notifyListeners();
  }

  void fetch1() async {
    enableLoading();
    try {
      _allNews = await NewsService.fetchData();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }
    disableLoading();
    notifyListeners();
  }

  void fetch() async {
    enableLoading(); // Start loading state
    try {
      // Fetch the news data from the service
      NewsModel newsData = await NewsService.fetchData();

      // Filter out articles where content is "[Removed]" or urlToImage is null
      newsData.articles = newsData.articles
          .where((article) =>
              article.content != "[Removed]" && article.urlToImage != null)
          .toList();

      // Assign the filtered data to _fakeUser or your appropriate variable
      _allNews = newsData;

      _errorMessage = null; // Clear any error messages
    } catch (e) {
      _errorMessage = e.toString(); // Set error message if an exception occurs
    }

    disableLoading(); // End loading state
    notifyListeners(); // Notify listeners to update the UI
  }
}
