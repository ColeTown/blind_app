import 'package:flutter/material.dart';
import 'api.dart';
import 'dart:convert';


class Python {

  String url = "";

  var data = "";

  String queryText = '';

  getResponse(value) async {

    url = 'http://10.0.2.2:5000/api?query=' + value.toString();
    data = await getData(url);
    var decoded = jsonDecode(data);

    queryText = decoded['client'];

    print(queryText);

    return queryText;

  }

}