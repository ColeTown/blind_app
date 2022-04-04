import 'package:flutter/material.dart';
import 'API.dart';
import 'dart:convert';
import 'navBar.dart';

class PythonPage extends StatefulWidget {
  @override
  _PythonPageState createState() => _PythonPageState();
}

class _PythonPageState extends State<PythonPage> {
  String url = "";

  var data = "";

  String queryText = 'Query';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('PYTHON AND FLUTTER'),
        ),
        body: Center(
          child: Column(children: [
            TextField(
              onChanged: (value) {
                url = 'http://10.0.2.2:5000/api?query=' + value.toString();
              },
            ),
            TextButton(onPressed: () async {
              data = await getData(url);
              var decoded = jsonDecode(data);
              setState(() {
                queryText = decoded['query'];
              });
            }, child: Text('Fetch ASCII Value')),
            Text(queryText)
          ]),
        ),
      ),
    );
  }
}