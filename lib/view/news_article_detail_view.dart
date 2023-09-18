import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../constants/appbar_text.dart';

class NewsArticleDetailView extends StatelessWidget {
  final String? newsUrl;
  /*final ArticleModel articleModel;
  NewsArticleDetailView({required this.articleModel});*/
  NewsArticleDetailView({required this.newsUrl});

  final Completer<WebViewController> _completer =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WebView(
            initialUrl: newsUrl,
            onWebViewCreated: ((WebViewController webViewController) {
              _completer.complete(webViewController);
            })),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Column(
        children: [
          Text(
            'M',
            style: mText,
          ),
          Text('News')
        ],
      ),
    );
  }
}
