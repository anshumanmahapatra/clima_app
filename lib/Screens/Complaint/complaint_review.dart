import 'package:clima_app/Screens/Complaint/complaint_successful.dart';
import 'package:clima_app/Services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'complaint_home.dart';


class ComplaintReview extends StatefulWidget {

  final String address, phoneNumber, reason, additional;
  ComplaintReview({@required this.address, @required this.phoneNumber,
    @required this.reason, @required this.additional});
  @override
  _ComplaintReviewState createState() => _ComplaintReviewState();
}

class _ComplaintReviewState extends State<ComplaintReview> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  Widget _buildName() {
    return TextFormField(
      initialValue: Provider.of<DatabaseMethods>(context, listen: false).getInitUserName,
      readOnly: true,
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
        labelText: 'Name',
        labelStyle: TextStyle(
          color: Color(0xFF229062),
        ),
      ),
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      initialValue: Provider.of<DatabaseMethods>(context, listen: false).getInitUserEmail,
      readOnly: true,
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
        labelText: 'Email',
        labelStyle: TextStyle(
          color: Color(0xFF229062),
        ),
      ),
    );
  }

  Widget _buildReason() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      minLines: 1,
      maxLines: 3,
      initialValue: widget.reason,
      readOnly: true,
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
    );

  }

  Widget _buildAddress() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: 5,
      minLines: 1,
      initialValue: widget.address,
      readOnly: true,
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
    );
  }

  Widget _buildPhoneNumber() {
    return TextFormField(
      initialValue: widget.phoneNumber,
      readOnly: true,
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
      keyboardType: TextInputType.phone,
    );
  }

  Widget _buildAdditionalDescription() {
    return TextFormField(
      initialValue: widget.additional,
      readOnly: true,
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
            )
        ),
        labelText: 'Additional Description',
        labelStyle: TextStyle(
          color: Color(0xFF229062),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complaint Review"),
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
                  height: 250,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(Provider.of<DatabaseMethods>(context, listen: false).getInitComplaintPost,
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
                SizedBox(height: 20,),
                 Form(
                   key: _formKey,
                   child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _buildName(),
                        SizedBox(height: 10,),
                        _buildEmail(),
                        SizedBox(height: 10,),
                        _buildAddress(),
                        SizedBox(height: 10,),
                        _buildPhoneNumber(),
                        SizedBox(height: 10,),
                        _buildReason(),
                        SizedBox(height: 10,),
                        _buildAdditionalDescription(),
                        SizedBox(height: 50),
                            ElevatedButton(
                              child: Text(
                                'Confirm',
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 15),
                                primary:  Color(0xFF229062),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              onPressed: () {
                                if(_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  Provider.of<DatabaseMethods>(context, listen: false)
                                      .createComplaintCollection(context, {
                                        "complaintUrl": Provider.of<DatabaseMethods>(context, listen: false).getInitComplaintPost,
                                    "name" : Provider.of<DatabaseMethods>(context, listen: false).getInitUserName,
                                    "email" : Provider.of<DatabaseMethods>(context, listen: false).getInitUserEmail,
                                    "address" : widget.address,
                                    "phoneNumber" : widget.phoneNumber,
                                    "reason" : widget.reason,
                                    "additionalInfo" : widget.additional,
                                  });
                                }
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ComplaintSuccessful()));
                              },
                            ),
                      ],
                    ),
                 ),
              ]
          ),
        ),
      ),
    );
  }
}
