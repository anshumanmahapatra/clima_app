import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleDescription extends StatefulWidget {
  final String imgUrl,title,source, postUrl,desc;
  ArticleDescription({@required this.imgUrl, @required this.title, @required this.source, @required this.desc, @required this.postUrl});
  @override
  _ArticleDescriptionState createState() => _ArticleDescriptionState();
}

class _ArticleDescriptionState extends State<ArticleDescription> {

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Articles Page"),
        backgroundColor: Color(0xFF229062),
        centerTitle: true,
        elevation: 0.0,
      ),
      backgroundColor: Color(0xFFE9F6F4),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
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
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.all(7),
                child: Column(
                  children: <Widget>[
                    Text(
                      widget.title,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      widget.desc,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.source,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30,),
                    ElevatedButton(
                      child: Text(
                        'Read Full Article',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                        primary:  Color(0xFF229062),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onPressed: () {
                        if (widget.postUrl != null) {
                          _launched = _launchInBrowser(widget.postUrl);
                        }
                        else {
                          return;
                        }
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
