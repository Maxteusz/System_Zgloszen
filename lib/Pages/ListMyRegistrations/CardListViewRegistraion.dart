import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Objects/Registration.dart';

class CardListViewRegistraion extends StatelessWidget {
  Registration registraion;

  CardListViewRegistraion(this.registraion);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Container(
            margin: EdgeInsets.only(bottom: 10, top: 10),
            child: Row(
              children: [
                    Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(registraion.id.toString())),
                    Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(child: Text(registraion.owner.Name)),
                            Container(child: Text(registraion.owner.Surname)),
                          ],
                        )),
                    Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Text(registraion.title)),


              ],
            )));
  }
}
