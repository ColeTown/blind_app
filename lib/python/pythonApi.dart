import 'package:flutter/material.dart';
import 'api.dart';
import 'dart:convert';


class Python {

  String url = "";

  var data = "";

  getResponse(value) async {

    url = 'http://10.0.2.2:5000/api?query=' + value.toString();
    data =  await getData(url);
    print(data);
    var decoded = jsonDecode(data);

    print(decoded['output']);

    return decoded['output'];

  }

}