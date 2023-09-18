import 'package:flutter/material.dart';
import 'package:news_app/constants/category_textStyle.dart';

class CategoryCard extends StatelessWidget {
  final String imgUrl;
  final String categoryTitle;

  CategoryCard({required this.imgUrl, required this.categoryTitle});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Image.network(imgUrl),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0), color: Colors.black26),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.35,
          alignment: Alignment.center,
          child: Text(
            categoryTitle,
            style: textOfCategories,
          ),
        )
      ],
    );
  }
}
