import 'package:clima_app/Screens/Article/article_desc.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class ArticleBlogTile extends StatefulWidget {
  final String imgUrl,title,source, postUrl,desc;
  ArticleBlogTile({@required this.imgUrl, @required this.title, @required this.source, @required this.desc, @required this.postUrl});
  @override
  _ArticleBlogTileState createState() => _ArticleBlogTileState();
}

class _ArticleBlogTileState extends State<ArticleBlogTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>ArticleDescription(
            imgUrl: widget.imgUrl,
            title: widget.title,
            source: widget.source,
            desc: widget.desc,
            postUrl: widget.postUrl)));
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              height: 220,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    offset: Offset(0, 18),
                    blurRadius: 40,
                    spreadRadius: -12,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(widget.imgUrl,
                  width: MediaQuery.of(context).size.width - 25,
                  height: 220,
                  fit: BoxFit.cover,
                  loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null ?
                          loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                              : null,
                        )
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 15.0),
                Container(
                  padding: EdgeInsets.all(7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.title,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        widget.source,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
          ],
        ),
      ),
    );
  }
}

class ArticleTile extends StatefulWidget {
  final String imgUrl,title,source, postUrl;
  ArticleTile({@required this.imgUrl, @required this.title, @required this.source, @required this.postUrl});
  @override
  _ArticleTileState createState() => _ArticleTileState();
}

class _ArticleTileState extends State<ArticleTile> {

  Future<void> _launched;
  Future<void> _launchInBrowser( String url) async {
    if(await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    }
    else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.postUrl != null) {
          _launched = _launchInBrowser(widget.postUrl);
        }
        else {
          return;
        }
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              height: 220,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    offset: Offset(0, 18),
                    blurRadius: 40,
                    spreadRadius: -12,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(widget.imgUrl,
                  width: MediaQuery.of(context).size.width - 25,
                  height: 220,
                  fit: BoxFit.cover,
                  loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                        child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null ?
                        loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                            : null,
                    )
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 15.0),
            Container(
              padding: EdgeInsets.all(7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    widget.source,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

