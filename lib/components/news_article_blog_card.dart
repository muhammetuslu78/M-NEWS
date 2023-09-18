import 'package:flutter/material.dart';
import 'package:news_app/constants/article_card_text_style.dart';

class NewsArticleCard extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String desc;

  NewsArticleCard(
      {required this.imgUrl, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.network(imgUrl),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Text(
              title,
              style: textOfNewsArticleTitle,
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Text(
              desc,
              style: textOfNewsArticleDesc,
            ),
          )
        ],
      ),
    );
  }
}
