import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:http/http.dart' as http;
import 'package:untitled2/Objects/AttachedPeople.dart';
import 'package:untitled2/Pages/NewRegistrationsPage/ErrorText.dart';
import 'dart:developer';

import '../../Objects/Registration.dart';
import '../../Objects/User.dart';



List<User> attachedUsersList = [];
List<AttachedPeople> _attachedUsersList = [];
User? selectedOwner;
TextEditingController titleController = TextEditingController();
TextEditingController descriptionController = TextEditingController();

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
   void send() async {
     Registration registration = new Registration.rere(
         descriptionController.text, selectedOwner!.Id, 1, "program", titleController.text, _attachedUsersList);
     var response = await http.post(
         Uri.http('10.1.2.74:5009', '/DodajZgloszenie/'),
         headers: {"Content-type": "application/json"},
         body: json.encode(registration.toJson()));
     print(response.body);
   }

  @override
  void initState() {
    super.initState();
    futureUsers = fetchUsers();
  }

  void convertAttachedPeopleList()
  {
    for (int i = 0; i < attachedUsersList.length ; i++)
      {
        _attachedUsersList.add(new AttachedPeople(Id: 0, RegistrationId: 0, UserId: attachedUsersList[i].Id));
      }
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
                controller: titleController,
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
                        return ErrorText();
                    })),
            Container(
                margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                child: TextField(
                  controller: descriptionController,
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
              margin: EdgeInsets.only(bottom: 10, top: 10),
              child: MaterialButton(
                height: 40,
                minWidth: 100,
                onPressed: () {
                  convertAttachedPeopleList();
                          send();
                          if(selectedOwner != null)
                            print(selectedOwner?.Id);
                  },

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


class AddPeopleDropDownButton extends StatefulWidget {

  List<User> users = [];
  String label;

  AddPeopleDropDownButton(this.users, this.label);

  @override
  State<StatefulWidget> createState() {
    return AddPeopleDropDownButtonState(users, label);
  }
}
class AddPeopleDropDownButtonState extends State<AddPeopleDropDownButton> {
  String label;
  User? selectedValue = null;
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
            items: users
                .map((user) =>
                DropdownMenuItem<User>(
                  value: user,
                  child: Text(
                    user.getName(),
                  ),
                ))
                .toList(),
            value: selectedValue,
            onChanged: (value) {
              setState(() {
                selectedValue = value as User;
                if (!attachedUsersList.contains(value))
                  attachedUsersList.add(value);
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
            itemHeight: 40,
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
              itemCount: attachedUsersList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue[50],
                  ),

                  margin: EdgeInsets.only(left: 10, top: 10, right: 10),
                  child: Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(
                              left: 10, top: 10, bottom: 10),
                          child: Text(attachedUsersList[index].getName())),
                      Container(
                          margin: EdgeInsets.only(left: 10),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                attachedUsersList.removeAt(index);
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

class DropDownButton extends StatefulWidget {
  String label;
  List<User> users = [];


  DropDownButton(this.users, this.label);

  @override
  State<StatefulWidget> createState() {
    return DropDownButtonState(users, label);
  }
}
class DropDownButtonState extends State<DropDownButton> {
  String label;
  List<User> users = [];


  DropDownButtonState(this.users, this.label);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Text(label),
        items: users
            .map((item) => DropdownMenuItem<User>(
          value: item,
          child: Text(
            item.getName(),
          ),
        ))
            .toList(),
        value: selectedOwner,
        onChanged: (value) {
          setState(() {
            selectedOwner = value as User;
            log(value.Id.toString());


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



