import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../../Objects/Registration.dart';

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

  List<String> userList = [
    'Mateusz Chabiński',
    'Michał Kruk',
    'Mateusz Drobiec',
    'Marek Korzec'
  ];

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
            Container(
                margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                child: ProgramsDropDownButton(items, "Wybierz projekt")),
            Container(
                margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                child: ProgramsDropDownButton(userList, "Wybierz osobę")),
            Container(
                margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                child: TextField(
                    minLines: 5,
                    maxLines: 30,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: "Opis",
                      border: OutlineInputBorder(),
                    ))),
            Container(
                margin: EdgeInsets.only(right: 10, left: 10, top: 10),
                child: AddUserDropDownButton(userList, "Dodaj użytkowników")),
            Container(
              margin: EdgeInsets.only(bottom: 10, top: 10),
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

class AddUserDropDownButton extends StatefulWidget {
  List<String> items = [];
  String label;

  AddUserDropDownButton(this.items, this.label);

  @override
  State<StatefulWidget> createState() {
    return AddUserDropDownButtonState(items, label);
  }
}

class AddUserDropDownButtonState extends State<AddUserDropDownButton> {
  String label;
  String? selectedValue = null;
  List<String> items = [];
  List<String> people = [];

  AddUserDropDownButtonState(this.items, this.label);

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
                if(!people.contains(value))
                people.add(value);
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
              itemCount: people.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(

                  decoration:   BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue[50],),
                  margin: EdgeInsets.only(left: 10, top: 10, right: 10),
                  child: Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Container(
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                              child:Text(people[index]))),
                      Container(
                          margin: EdgeInsets.only(left: 10),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                people.removeAt(index);
                              });
                            },
                            child: Icon(Icons.person_remove_rounded),
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
