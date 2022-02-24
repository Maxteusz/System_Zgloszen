import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/Pages/ListMyRegistrations/CardListViewRegistraion.dart';
import '../../Objects/Registration.dart';

class ListViewRegistrations extends StatelessWidget {
  List <Registration> registrations = <Registration>[];

  ListViewRegistrations(this.registrations);

  @override
  Widget build(BuildContext context) {
    return
      ListView.builder(
          itemCount: registrations.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child:  CardListViewRegistraion(registrations[index]),
            );
          });
  }
}