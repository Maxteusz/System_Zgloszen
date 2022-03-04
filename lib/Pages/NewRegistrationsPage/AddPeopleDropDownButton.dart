

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../Objects/User.dart';

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
  List<User> attachedUsers = [];

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
                .map((user) => DropdownMenuItem<User>(
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
                if(!attachedUsers.contains(value))
                  attachedUsers.add(value);
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
              itemCount: attachedUsers.length,
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
                          margin: EdgeInsets.only(left: 10,top: 10, bottom: 10),
                          child: Text(attachedUsers[index].getName())),
                      Container(
                          margin: EdgeInsets.only(left: 10),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                attachedUsers.removeAt(index);
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