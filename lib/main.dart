import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/Enums/Pages.dart';
import 'package:untitled2/NewRegistrationsPage.dart';
import 'package:untitled2/Objects/Registration.dart';
import 'ListViewRegistrations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Zgłoszenia',),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => MainPage();
}


class MainPage extends State<MyHomePage> {

  Pages setPage = Pages.ListRegistrations;
  String title = "Zgłoszenia";
  List<Registration> registrations = <Registration>[];

  void testaddRegistrations() {
    for (int i = 1; i < 4450; i++)
      registrations.add(new Registration(
          i, "opis", "Mateusz Chabiński", "MTomanek", "IOffice", "temat"));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    testaddRegistrations();
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewRegistrationPage()));
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
        elevation: 2.0,
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 3.0,
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(5),
              child: IconButton(
                icon: Icon(Icons.list_alt),
                iconSize: 30,
                color: setPage == Pages.ListRegistrations ? Colors.blue : Colors.black26,
                onPressed: () {
                  setState(() {
                    setPage = Pages.ListRegistrations;
                  });
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: IconButton(
                icon: Icon(Icons.backup_table_sharp),
                iconSize: 30,
                color: setPage == Pages.ListOfProjects ? Colors.blue : Colors.black26,
                onPressed: () {
                  setState(() {
                    setPage = Pages.ListOfProjects;
                  });
                },
              ),
            ),
          ],
        ),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: setPage == Pages.ListRegistrations ? ListViewRegistrations(registrations) : null,
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


}
