import 'dart:async';
import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/Enums/Pages.dart';
import 'package:untitled2/Pages/NewRegistrationsPage/NewRegistrationsPage.dart';
import 'package:untitled2/Objects/Registration.dart';
import 'ListMyRegistrations/ListViewRegistrations.dart';
import 'package:http/http.dart' as http;

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
  List<Registration> registrations = [];
  late Future<List<Registration>> futureRegistrations;

  Future<List<Registration>> fetchRegistrations() async {
    final response = await http
        .get(Uri.parse('http://192.168.0.160:5009/PobierzListeZgloszen'))
    .timeout(Duration(seconds: 10),
      onTimeout: () => throw TimeoutException('Can\'t connect in 10 seconds.'),);;

      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);
        registrations = (responseJson as List).map((p) => Registration.fromJson(p)).toList();
        return registrations;

    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load registrations');
    }
  }

  void refresh()
  {
    registrations.clear();
    futureRegistrations = fetchRegistrations();
  }


  @override
  void initState() {
    futureRegistrations = fetchRegistrations();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Row(
          children: [
            Text(title),
            Material(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.red),
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewRegistrationPage(0))).then((_) {

          });
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
        child: setPage == Pages.ListRegistrations ? FutureBuilder<List<Registration>>(
          future: futureRegistrations,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListViewRegistrations(registrations);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ): null
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


}
