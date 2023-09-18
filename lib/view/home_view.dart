import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:news_app/components/category_card.dart';
import 'package:news_app/components/news_article_blog_card.dart';
import 'package:news_app/constants/appbar_text.dart';
import 'package:news_app/helper/ad_helper.dart';
import 'package:news_app/helper/data.dart';
import 'package:news_app/helper/news_data.dart';
import 'package:news_app/model/article_model.dart';
import 'package:news_app/model/category_model.dart';
import 'package:news_app/view/news_article_detail_view.dart';

const int maxFailedLoadAttempts = 3;

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int interStitialAttempt = 0;
  final _inlineIndex = 3;

  late BannerAd _bottomBannerAd;
  late BannerAd _inlineBannerAd;
  InterstitialAd? _interstitialAd;

  bool _isBannerAdLoaded = false;
  bool _isInlineBannerAdLoaded = false;

  void _createBannerAdLoaded() {
    _bottomBannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: AdHelper.bannerAdUnitId(),
        listener: BannerAdListener(onAdLoaded: (_) {
          setState(() {
            _isBannerAdLoaded = true;
          });
        }, onAdFailedToLoad: (ad, error) {
          ad.dispose();
        }),
        request: AdRequest());
    _bottomBannerAd.load();
  }

  void _createInlineBannerAd() {
    _inlineBannerAd = BannerAd(
        size: AdSize.mediumRectangle,
        adUnitId: AdHelper.interstitialAdUnitId(),
        listener: BannerAdListener(onAdLoaded: (_) {
          setState(() {
            _isInlineBannerAdLoaded = true;
          });
        }, onAdFailedToLoad: (ad, error) {
          ad.dispose();
        }),
        request: AdRequest());
    _inlineBannerAd.load(); // TO INITIALIZE
  }

  void _createInterStitialAd() {
    InterstitialAd.load(
        adUnitId: AdHelper.interstitialAdUnitId(),
        request: AdRequest(),
        adLoadCallback:
            InterstitialAdLoadCallback(onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          interStitialAttempt = 0;
        }, onAdFailedToLoad: (LoadAdError error) {
          interStitialAttempt++;
          _interstitialAd = null;
          if (interStitialAttempt >= maxFailedLoadAttempts) {
            _createInterStitialAd();
          }
        }));
  }

  _showInterstitial() {
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
          onAdDismissedFullScreenContent: (InterstitialAd ad) {
        ad.dispose();
        _createInterStitialAd();
      }, onAdFailedToShowFullScreenContent:
              (InterstitialAd ad, AdError adError) {
        ad.dispose();
        _createInterStitialAd();
      });
      _interstitialAd!.show();
      print('reklama tıklandı');
    }
  }

  int _getListIndex(int index) {
    if (index >= _inlineIndex && _isInlineBannerAdLoaded) {
      return index - 1;
    }
    return index;
  }

  List<CategoryModel>? categoryModel;
  List<ArticleModel>? articleModels;
  List<ArticleModel>? filteredNewsList;
  bool _loading = true;
  bool filtered = false;
  var categoryTitle = 'Business';
  var queriedNews;

  getNews() async {
    NewsData newsData = NewsData();
    await newsData.getNews(categoryTitle);
    articleModels = newsData.articleList;
    print('Eleman SAYISI ------ ${articleModels!.length}');
    setState(() {
      _loading = false;
      filtered = false;
    });
  }

  getFilteredNews() async {
    NewsData newsData = NewsData();
    await newsData.getFilteredNews(queriedNews);
    filteredNewsList = newsData.filteredArticleList;
    print('Eleman SAYISI ------ ${filteredNewsList!.length}');
    setState(() {
      _loading = false;
      filtered = true;
    });
  }

  @override
  void initState() {
    categoryModel = getCategories();
    getNews();
    super.initState();
    _createBannerAdLoaded();
    _createInlineBannerAd();
    _createInterStitialAd();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _bottomBannerAd.dispose();
    _inlineBannerAd.dispose();
    _interstitialAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Center(child: SpinKitFadingCircle(
            itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: index.isEven ? Colors.red : Colors.green,
                ),
              );
            },
          ))
        : Scaffold(
            bottomNavigationBar: _isBannerAdLoaded
                ? Container(
                    height: _bottomBannerAd.size.height.toDouble(),
                    width: _bottomBannerAd.size.width.toDouble(),
                    child: AdWidget(ad: _bottomBannerAd),
                  )
                : SizedBox(
                    height: 10,
                  ),
            appBar: buildAppBar(),
            body: Column(
              children: [
                Expanded(
                    flex: 2,
                    child: Stack(
                      children: [
                        ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: categoryModel?.length ?? 8,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    categoryTitle =
                                        categoryModel![_getListIndex(index)]
                                            .categoryTitle;
                                    getNews();
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(13.0),
                                  child: CategoryCard(
                                      imgUrl:
                                          categoryModel![_getListIndex(index)]
                                              .imgUrl,
                                      categoryTitle:
                                          categoryModel![_getListIndex(index)]
                                              .categoryTitle),
                                ),
                              );
                            })
                      ],
                    )),
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        child: TextField(
                          onChanged: (value) {
                            if (value == null) {
                              setState(() {
                                queriedNews = 'Business';
                              });
                            } else {
                              queriedNews = value;
                            }
                          },
                          decoration: InputDecoration(
                              prefixIcon: IconButton(
                                icon: Icon(Icons.search),
                                onPressed: () {
                                  getFilteredNews();
                                  print('clicked');
                                },
                              ),
                              //hintText: 'Search',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.0))),
                        ),
                      ),
                    )),
                Expanded(
                  flex: 7,
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: (filtered
                              ? filteredNewsList?.length
                              : articleModels?.length)! +
                          (_isInlineBannerAdLoaded ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (_isInlineBannerAdLoaded && index == _inlineIndex) {
                          return Container(
                              height: _inlineBannerAd.size.height.toDouble(),
                              width: _inlineBannerAd.size.width.toDouble(),
                              padding: EdgeInsets.only(bottom: 10),
                              child: AdWidget(
                                ad: _inlineBannerAd,
                              ));
                        }
                        return GestureDetector(
                          onTap: () {
                            _showInterstitial();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NewsArticleDetailView(
                                        newsUrl: filtered
                                            ? filteredNewsList![
                                                    _getListIndex(index)]
                                                .url
                                            : articleModels![
                                                    _getListIndex(index)]
                                                .url)));
                            print(filtered
                                ? filteredNewsList![_getListIndex(index)].url
                                : articleModels![_getListIndex(index)].url);
                          },
                          child: NewsArticleCard(
                              imgUrl: filtered
                                  ? filteredNewsList![_getListIndex(index)]
                                          .urlToImage ??
                                      ''
                                  : articleModels![_getListIndex(index)]
                                          .urlToImage ??
                                      '',
                              title: filtered
                                  ? filteredNewsList![_getListIndex(index)]
                                          .title ??
                                      ''
                                  : articleModels![_getListIndex(index)]
                                          .title ??
                                      '',
                              desc: filtered
                                  ? filteredNewsList![_getListIndex(index)]
                                          .description ??
                                      ''
                                  : articleModels![_getListIndex(index)]
                                          .description ??
                                      ''),
                        );
                      }),
                )
              ],
            ));
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
