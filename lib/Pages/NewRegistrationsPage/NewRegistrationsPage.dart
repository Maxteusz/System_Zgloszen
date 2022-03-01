import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:http/http.dart' as http;
import '../../Objects/Registration.dart';
import '../../Objects/User.dart';

Registration? registration = null;

class NewRegistrationPage extends StatefulWidget {
  NewRegistrationPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NewRegistrationPage();
  }
}

class _NewRegistrationPage extends State<NewRegistrationPage> {
  List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
    'Item10'
  ];

  List<String> items2 = [
    'Item6',
    'Item35',
    'Item4',
    'Item5',
    'Item7',
    'Item8',
    'Item10'
  ];


  List<User> users = [];
  late Future<List<User>> futureUsers;



  Future<List<User>> getUserList() async {
    final response = await http.get(
        Uri.parse('http://192.168.1.133:5009/PobierzListeUzytkownikow'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      users = body.map((e) => User.fromJson(e)).toList();
      return users;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to list Suit');
    }
  }


  @override
  void initState() {
    super.initState();
    futureUsers = getUserList();

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
        child:Column(
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
            FutureBuilder<List<User>>(
              future: futureUsers,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: AddPeopleDropDownButton(snapshot.data!, "Wybierz projekt"));
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return Text("Nie pobrano użytkowników");
              },
            ),
            Container(
                margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                child: ProgramsDropDownButton(items2, "Wybierz osobę")),
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
                child: AddPeopleDropDownButton(items, "Dodaj użytkowników")),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: MaterialButton(
                height: 40,
                minWidth: 100,
                onPressed: () {  },
                child: Text("Dodaj",
                  style: TextStyle(
                  color: Colors.white,
                ),),
                color: Colors.blue,

              ),
            )
          ],
        )));
  }
}

class ProgramsDropDownButton extends StatefulWidget {
  List<String> items = [];
  String label;

  ProgramsDropDownButton(this.items, this.label);

  @override
  State<StatefulWidget> createState() {
    return ProgramsDropDownButtonState(items, label);
  }
}

class ProgramsDropDownButtonState extends State<ProgramsDropDownButton> {
  String label;
  String? selectedValue = null;
  List<String> items = [];

  ProgramsDropDownButtonState(this.items, this.label);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Text(label),
        items: items
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                  ),
                ))
            .toList(),
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            selectedValue = value as String;
          });
        },
        icon: const Icon(
          Icons.arrow_forward_ios_outlined,
        ),
        iconSize: 14,
        iconEnabledColor: Colors.black,
        iconDisabledColor: Colors.grey,
        buttonHeight: 60,
        buttonPadding: const EdgeInsets.only(left: 14, right: 14),
        buttonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        itemHeight: 60,
        itemPadding: const EdgeInsets.only(left: 14, right: 14),
        dropdownMaxHeight: 200,
        dropdownPadding: null,
        dropdownElevation: 8,
        scrollbarThickness: 6,
        scrollbarAlwaysShow: true,
      ),
    );
  }
}

class AddPeopleDropDownButton extends StatefulWidget {
  List<User> items = [];
  String label;

  AddPeopleDropDownButton(this.items, this.label);

  @override
  State<StatefulWidget> createState() {
    return AddPeopleDropDownButtonState(items, label);
  }
}

class AddPeopleDropDownButtonState extends State<AddPeopleDropDownButton> {
  String label;
  String? selectedValue = null;
  List<String> items = [];

  List<User> users = [];
  AddPeopleDropDownButtonState(this.users, this.label);


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonHideUnderline(
          child: DropdownButton2(
            isExpanded: true,
            hint: Text(label),
            items: items
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                      ),
                    ))
                .toList(),
            value: selectedValue,
            onChanged: (value) {
              setState(() {
                selectedValue = value as String;

                selectedValue = null;
              });
            },
            icon: const Icon(
              Icons.arrow_forward_ios_outlined,
            ),
            iconSize: 14,
            iconEnabledColor: Colors.black,
            iconDisabledColor: Colors.grey,
            buttonHeight: 60,
            buttonPadding: const EdgeInsets.only(left: 14, right: 14),
            buttonDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            itemHeight: 60,
            itemPadding: const EdgeInsets.only(left: 14, right: 14),
            dropdownMaxHeight: 200,
            dropdownPadding: null,
            dropdownElevation: 8,
            scrollbarThickness: 6,
            scrollbarAlwaysShow: true,
          ),
        ),
        Container(
          height: 150,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: users.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  color: Colors.orange[50],
                  margin: EdgeInsets.only(left: 10, top: 10, right: 10),
                  child: Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(users[index].Name)),
                      Container(
                          margin: EdgeInsets.only(left: 10),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                users.removeAt(index);
                              });
                            },
                            child: Icon(Icons.remove_circle_outline),
                          )),
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }
}
