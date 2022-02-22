import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled2/ListViewRegistrations.dart';

class NewRegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Nowe zgłoszenie"),
        ),
        body:Column(
          children: [
            Container(
          margin: EdgeInsets.only(top: 10, left: 10, right: 10),
          child:  TextField(
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
          ),
            ),
      ],
        ));
  }
}
