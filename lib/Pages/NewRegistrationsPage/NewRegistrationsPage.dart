import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:http/http.dart' as http;
import 'package:untitled2/Pages/NewRegistrationsPage/ErrorText.dart';
import 'dart:developer';

import '../../Objects/Registration.dart';
import '../../Objects/User.dart';
import 'AddPeopleDropDownButton.dart';
import 'DropDownButton.dart';

Registration? registration = null;

class NewRegistrationPage extends StatefulWidget {
  NewRegistrationPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NewRegistrationPage();
  }
}

class _NewRegistrationPage extends State<NewRegistrationPage> {

   late Future<List<User>> futureUsers;
   late List<User> users = [];


  Future<List<User>> fetchUsers() async {
    final response = await http
        .get(Uri.parse('http://10.1.2.74:5009/PobierzListeUzytkownikow'));

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      log("Response Body: $responseJson" );
      users = (responseJson as List).map((p) => User.fromJson(p)).toList();
      return users;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    super.initState();
    futureUsers = fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Nowe zgłoszenie"),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10, left: 10, right: 10),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Temat',
                ),
              ),
            ),
           /* Container(
                margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                //child: ProgramsDropDownButton(items, "Wybierz projekt")),*/
            Container(
                margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                child: FutureBuilder<List<User>>(
                    future: futureUsers,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return DropDownButton(snapshot.data!, "Wybierz użytkownika");
                      } else
                        return Text('${snapshot.error}');
                    })),
            Container(
                margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                child: TextField(
                    minLines: 10,
                    maxLines: 30,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: "Opis",
                      border: OutlineInputBorder(),
                    ))),
            Container(
                margin: EdgeInsets.only(right: 10, left: 10, top: 10),
                child: FutureBuilder<List<User>>(
                    future: futureUsers,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return AddPeopleDropDownButton(snapshot.data!, "Dodaj użytkownika");
                      } else
                        return  ErrorText();
                    })
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: MaterialButton(
                height: 40,
                minWidth: 100,
                onPressed: () {},
                child: Text(
                  "Dodaj",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.blue,
              ),
            )
          ],
        )));
  }
}



