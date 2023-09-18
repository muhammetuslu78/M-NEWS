import 'package:flutter/material.dart';
import 'package:news_app/view/home_view.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: HomeView(),
      duration: 3000,
      imageSize: 130,
      imageSrc: "assets/images/logo.png",
      text: "M - News",
      textType: TextType.ScaleAnimatedText,
      textStyle: TextStyle(
        fontSize: 30.0,
      ),
      backgroundColor: Colors.white,
    );
  }
}
