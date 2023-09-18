import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/model/article_model.dart';

class NewsData {
  List<ArticleModel> articleList = [];
  List<ArticleModel> filteredArticleList = [];

  Future<void> getNews(String categoryTitle) async {
    String url =
        'http://newsapi.org/v2/top-headlines?country=us&category=${categoryTitle}&apiKey=aa4778231a6b42f6b0ff399ee20fe626';
    var response = await http.get(Uri.parse(url));
    print('Response Burada : ---- $response');
    var jsonData = jsonDecode(response.body);
    print('jsonData Burada : ---- $jsonData');

    if (jsonData['status'] == "ok") {
      jsonData['articles'].forEach((element) {
        print(element);
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
              author: element['author'],
              title: element['title'],
              description: element['description'],
              url: element['url'],
              urlToImage: element['urlToImage'],
              content: element['content']);

          articleList.add(articleModel);
        }
      });
    }
  }

  Future<void> getFilteredNews(String queriedNews) async {
    String url =
        'https://newsapi.org/v2/everything?q=$queriedNews&from=2022-04-14&to=2022-04-14&sortBy=popularity&apiKey=aa4778231a6b42f6b0ff399ee20fe626';
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData['articles'].forEach((element) {
        print(element);
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
              author: element['author'],
              title: element['title'],
              description: element['description'],
              url: element['url'],
              urlToImage: element['urlToImage'],
              content: element['content']);

          filteredArticleList.clear();
          filteredArticleList.add(articleModel);
        }
      });
    }
  }
}

// https://newsapi.org/v2/everything?q=apple&from=2022-04-14&to=2022-04-14&sortBy=popularity&apiKey=aa4778231a6b42f6b0ff399ee20fe626
