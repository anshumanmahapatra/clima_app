import 'package:carousel_slider/carousel_slider.dart';
import 'package:clima_app/Constants/articles_constant.dart';
import 'package:clima_app/HelpingWidgets/article_helpers.dart';
import 'package:flutter/material.dart';

class ArticleHome extends StatefulWidget {
  @override
  _ArticleHomeState createState() => _ArticleHomeState();
}

class _ArticleHomeState extends State<ArticleHome> {
  List<Map<String, String>> articleData = articleBlogData;
  List<Map<String, String>> carouselData = carouselArticleData;
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            title: Text("Articles"),
            backgroundColor: Color(0xFF229062),
            centerTitle: true,
            elevation: 0.0,
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 10,),
          ),
          SliverToBoxAdapter(
            child: Row(
              children: [
                SizedBox(width: 15,),
                Text("Trending Articles",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
            ),
          ),
          SliverToBoxAdapter(
            child: LimitedBox(
              maxHeight: 365,
              child:CarouselSlider.builder(
                  itemCount: carouselData.length,
                  itemBuilder: (context, index, index2) {
                    return ArticleTile(
                        imgUrl: carouselData[index]["imgUrl"],
                        title: carouselData[index]["title"],
                        postUrl: carouselData[index]["postUrl"],
                        source: carouselData[index]["source"],);
                  },
                  options: CarouselOptions(
                      autoPlay: true,
                      enableInfiniteScroll: true,
                      height: 365,
                      viewportFraction: 1,
                      onPageChanged: (index, CarouselPageChangedReason text) {
                        setState(() {
                          currentPage = index;
                        });
                      }
                  )),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 15,),),
          SliverToBoxAdapter(
            child: LimitedBox(
              maxHeight: 10,
              maxWidth: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: carouselData.length,
                      itemBuilder: (context, index){
                        return Row(
                          children: [
                            Container(
                              height: 8,
                              width: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: currentPage == index ? Colors.black45 : Colors.black26,
                              ),
                            ),
                            SizedBox(width: 5,),
                          ],
                        );
                      }),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 20,),),
          SliverToBoxAdapter(
            child: Row(
              children: [
                SizedBox(width: 15,),
                Text("Recommended For You",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  return ArticleBlogTile(
                      imgUrl: articleData[index]['imgUrl'],
                      title: articleData[index]['title'],
                      source: articleData[index]['source'],
                      desc: articleData[index]['desc'],
                      postUrl: articleData[index]['postUrl']);
                },
              childCount: articleData.length,
                ),
            ),
          SliverToBoxAdapter(
            child: SizedBox(height: 20,),
          ),
        ],
      ),
    );
  }
}
