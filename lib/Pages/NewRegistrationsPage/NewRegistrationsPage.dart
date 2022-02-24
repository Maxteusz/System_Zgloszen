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

  List<String> items2 = [
    'Item6',
    'Item6',
    'Item35',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
    'Item10'
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
        body: Column(
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
                child: ProgramsDropDownButton(items2,"Wybierz osobę")),
            Expanded(
                child: Container(
                    margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: TextField(
                        minLines: 10,
                        maxLines: 30,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: "Opis",
                      border: OutlineInputBorder(),
                    )))),
          ],
        ));
  }
}

class ProgramsDropDownButton extends StatefulWidget {
  List<String> items = [];
  String label;
  ProgramsDropDownButton(this.items,this.label);
  @override
  State<StatefulWidget> createState() {
    return ProgramsDropDownButtonState(items, label);
  }
}

class ProgramsDropDownButtonState extends State<ProgramsDropDownButton> {
String label;
  String? selectedValue = null;
  List<String> items = [];
  ProgramsDropDownButtonState(this.items,this.label);

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
