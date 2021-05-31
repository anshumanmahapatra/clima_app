import 'package:flutter/material.dart';

class MLHome extends StatefulWidget {
  @override
  _MLHomeState createState() => _MLHomeState();
}

class _MLHomeState extends State<MLHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ML and Analytics"),
        backgroundColor: Color(0xFF229062),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(15),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                shadowColor: Colors.black45,
                elevation: 7,
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: <Widget>[
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width - 24,
                              child: Text(
                                "Pollution level across various states in India",
                                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ]
                      ),
                      SizedBox(height: 30,),
                      Container(
                        child: Image(
                          image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/clima-app-723ef.appspot.com/o/graph1.png?alt=media&token=b9d270c1-7237-425c-a51b-f02a23ffdc11"),
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        child: Image(
                          image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/clima-app-723ef.appspot.com/o/graph2.png?alt=media&token=1b2ae790-61f4-4810-84ab-7dab5da6a2fc"),
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        child: Image(
                          image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/clima-app-723ef.appspot.com/o/graph3.jpeg?alt=media&token=0e95db26-1cb1-4c9f-879a-ae77864fab41"),
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        child: Image(
                          image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/clima-app-723ef.appspot.com/o/graph4.jpeg?alt=media&token=2bba1c8b-f742-45a8-8a96-cf29e80bf6ef"),
                          fit: BoxFit.contain,
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
