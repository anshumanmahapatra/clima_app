import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class YoutubeVideoTile extends StatefulWidget {

  final String imgUrl,logoUrl,title,channelName,postUrl;

  YoutubeVideoTile({@required this.imgUrl,@required this.title,@required this.postUrl,@required this.channelName, @required this.logoUrl});


  @override
  _YoutubeVideoTileState createState() => _YoutubeVideoTileState();
}

class _YoutubeVideoTileState extends State<YoutubeVideoTile> {

  Future<void> _launched;

  Future<void> _launchInYoutube (String url) async {
    if(await canLaunch(url)) {
      final bool launchSucceeded = await launch(
        url,
        forceSafariVC: false,
        universalLinksOnly: true,
      );
      if(!launchSucceeded) {
        await launch(url, forceSafariVC: true);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.postUrl != null) {
          _launched = _launchInYoutube(widget.postUrl);
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
              height: 180,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(widget.imgUrl,
                  width: MediaQuery.of(context).size.width - 25,
                  height: 180,
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
            Row(
              children: <Widget>[
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.network(widget.logoUrl,
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,),
                  ),
                ),
                SizedBox(width: 5,),
                Container(
                  padding: EdgeInsets.all(7),
                  width: MediaQuery.of(context).size.width / 1.25 - 15,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.title,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text(
                        widget.channelName,
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
            )
          ],
        ),
      ),
    );
  }
}
