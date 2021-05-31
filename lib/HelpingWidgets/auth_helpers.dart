
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthHelpers with ChangeNotifier {

  showErrorMessage(BuildContext context, String errorMessage) {
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text('ERROR'),
        content: Text(errorMessage),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text('OK')),
        ],
      );
    });
  }

  showUserData(BuildContext context, dynamic snapshot) {
    return SizedBox(
      child: Column(
        children: [
          TextFormField(
            initialValue: snapshot.data.data()["name"],
            readOnly: true,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Color(0xFF229062),
                  )
              ),
                focusedBorder:  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Color(0xFF229062),
                    )
                ),
                labelText: 'Name',
                labelStyle: TextStyle(
                  color: Color(0xFF229062),
                ),
                prefixIcon: Icon(Icons.person,color: Color(0xFF229062),)),
          ),
          SizedBox(height: 10,),
          TextFormField(
            initialValue: snapshot.data.data()["email"],
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
                prefixIcon: Icon(Icons.email, color: Color(0xFF229062),)),
          )
        ],
      ),
    );
  }
}