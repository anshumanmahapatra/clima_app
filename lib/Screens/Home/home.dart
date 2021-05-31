import 'package:carousel_slider/carousel_slider.dart';
import 'package:clima_app/Constants/yt_video_constant.dart';
import 'package:clima_app/HelpingWidgets/drawer_helpers.dart';
import 'package:clima_app/HelpingWidgets/video_helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../Services/database.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  User user;
  var currentPage = 0;
  List<Map<String, String>> youtubeData = youtubeVideoData;
  List<Map<String, String>> carouselData = carouselVideoData;

  checkAuthentication() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.pushReplacementNamed(context, "start");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    Provider.of<DatabaseMethods>(context, listen: false).initUserData(context);
    this.checkAuthentication();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Provider.of<DrawerHelpers>(context, listen: false)
          .showDrawer(context),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            title: Text("Home"),
            backgroundColor: Color(0xFF229062),
            centerTitle: true,
            elevation: 0.0,
            leading: GestureDetector(
              child: Icon(Icons.menu, color: Colors.white,),
              onTap: () {
                scaffoldKey.currentState.openDrawer();
              },
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              children: [
                SizedBox(width: 15,),
                Text("Trending Videos",
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
              maxHeight: 310,
              child:CarouselSlider.builder(
                  itemCount: carouselData.length,
                  itemBuilder: (context, index, index2) {
                    return YoutubeVideoTile(
                        imgUrl: carouselData[index]["imgUrl"],
                        title: carouselData[index]["title"],
                        postUrl: carouselData[index]["postUrl"],
                        channelName: carouselData[index]["channelName"],
                        logoUrl: carouselData[index]["logoUrl"]);
                  },
                  options: CarouselOptions(
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    enableInfiniteScroll: true,
                    height: 310,
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
                  return YoutubeVideoTile(
                      imgUrl: youtubeData[index]["imgUrl"],
                      title: youtubeData[index]["title"],
                      postUrl: youtubeData[index]["postUrl"],
                      channelName: youtubeData[index]["channelName"],
                      logoUrl: youtubeData[index]["logoUrl"]);
                },
              childCount: youtubeData.length,
            ),
          ),
          SliverToBoxAdapter(
            child:  SizedBox(height: 20),
          ),
        ],
      ),
      );
  }
}
