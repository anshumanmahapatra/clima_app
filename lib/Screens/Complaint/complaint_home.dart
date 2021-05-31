

import 'package:clima_app/Screens/Complaint/complaint_review.dart';
import 'package:clima_app/Services/database.dart';
import 'package:clima_app/Screens/Complaint/complaint_upload_pic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ComplaintHome extends StatefulWidget {
  @override
  _ComplaintHomeState createState() => _ComplaintHomeState();
}

class _ComplaintHomeState extends State<ComplaintHome> {

  String reason;
  String address;
  String phoneNumber;
  String additionalDescription;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildReason() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      minLines: 1,
      maxLines: 3,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Color(0xFF229062),
              )
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Color(0xFF229062),
              )
          ),
          labelText: 'Reason for Complaint',
          labelStyle: TextStyle(
            color: Color(0xFF229062),
          ),
          ),
      // decoration: InputDecoration(labelText: 'Reason for Complaint'),
      maxLength: 200,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Reason for Complaint is Required';
        }

        return null;
      },
      onSaved: (String value) {
        reason = value;
      },
    );

  }

  Widget _buildAddress() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: 5,
      minLines: 1,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Color(0xFF229062),
              )
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Color(0xFF229062),
              )
          ),
          labelText: 'Address',
          labelStyle: TextStyle(
            color: Color(0xFF229062),
          ),
          ),
      // decoration: InputDecoration(labelText: 'Address'),
      maxLength: 100,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Address is Required';
        }

        return null;
      },
      onSaved: (String value) {
        address = value;
      },
    );
  }

  Widget _buildPhoneNumber() {
    return TextFormField(
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Color(0xFF229062),
              )
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Color(0xFF229062),
              )
          ),
          labelText: 'Phone Number',
          labelStyle: TextStyle(
            color: Color(0xFF229062),
          ),
          ),
      // decoration: InputDecoration(labelText: 'Phone number'),
      keyboardType: TextInputType.phone,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Phone Number is Required';
        }

        return null;
      },
      onSaved: (String value) {
        phoneNumber = value;
      },
    );
  }

  Widget _buildAdditionalDescription() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: 7,
      minLines: 1,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Color(0xFF229062),
              )
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Color(0xFF229062),
              )),
          labelText: 'Additional Description',
          labelStyle: TextStyle(
            color: Color(0xFF229062),
          ),
          ),
      // decoration: InputDecoration(
      //     labelText: 'Additional description'),
      maxLength: 300,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Additional Description is Required';
        }

        return null;
      },
      onSaved: (String value) {
        additionalDescription = value;
      },
    );
  }

  Future<bool> onBackPressed() async {
    setState(() {
      Provider.of<DatabaseMethods>(context, listen: false)
          .initComplaintPost = null;
    });
    return true;
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
          appBar: AppBar(
            title: Text("Complaint Page"),
            backgroundColor: Color(0xFF229062),
            centerTitle: true,
            elevation: 0.0,
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(24),
              child: Column(
                  children: <Widget>[
                    Container(
                      height: 300,
                      child: Image(
                        image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/clima-app-723ef.appspot.com/o/complaint.jpg?alt=media&token=3ac08390-6559-407c-9eda-e06ed3fe4693"),
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
                    SizedBox(height: 20,),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Text(
                        "Complaint Form",
                        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 5,),
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ComplaintUploadPic()));
                            },
                            child: Container(
                              height: 250,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Provider.of<DatabaseMethods>(context, listen: false)
                                    .initComplaintPost ==
                                    null
                                    ? Container(
                                  width: MediaQuery.of(context).size.width - 25,
                                  height: 250,
                                  color: Color(0xFF229062) ,
                                  child:
                                  Center(child: Icon(Icons.add_a_photo_outlined, color: Colors.white,),),
                                )
                                    : Image.network(
                                  Provider.of<DatabaseMethods>(context, listen: false)
                                      .getInitComplaintPost,
                                  width: MediaQuery.of(context).size.width - 25,
                                  height: 250,
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
                            ),
                          ),
                          SizedBox(height: 30,),
                          _buildAddress(),
                          SizedBox(height: 10,),
                          _buildPhoneNumber(),
                          SizedBox(height: 20,),
                          _buildReason(),
                          SizedBox(height: 10,),
                          _buildAdditionalDescription(),
                          SizedBox(height: 50),
                          ElevatedButton(
                            child: Text(
                              'Upload Post',
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
                              if(_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                                    ComplaintReview(address: address, phoneNumber: phoneNumber, reason: reason, additional: additionalDescription)));
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ]
              ),
            ),
          ),
        ),
    );
  }
}
