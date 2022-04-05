import 'navBar.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';


class GeoLocation {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position currentPosition = Position();
  String currentAddress = "";

  getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {

        currentPosition = position;

     // getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          currentPosition.latitude, currentPosition.longitude);

      Placemark place = p[0];

      currentAddress = "${place.locality}, ${place.postalCode}, ${place.country}";

    } catch (e) {
      print(e);
    }
  }

}
