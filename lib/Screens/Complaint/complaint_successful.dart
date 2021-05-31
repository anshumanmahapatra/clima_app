import 'package:flutter/material.dart';

class ComplaintSuccessful extends StatefulWidget {
  @override
  _ComplaintSuccessfulState createState() => _ComplaintSuccessfulState();
}

class _ComplaintSuccessfulState extends State<ComplaintSuccessful> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complaint Successful"),
        backgroundColor: Color(0xFF229062),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 75),
              Container(
                height: 300,
                child: Image(
                  image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/clima-app-723ef.appspot.com/o/check_success.gif?alt=media&token=dbf2effd-1a48-4edf-8e65-955e4c978e2b"),
                  fit: BoxFit.cover,
                  loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null ?
                        loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                            : null,
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                child: Text(
                  'Go Back',
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
                 Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
