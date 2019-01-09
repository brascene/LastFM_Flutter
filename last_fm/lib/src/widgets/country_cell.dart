import 'package:flutter/material.dart';
import '../models/flag.dart';

class CountryCell extends StatelessWidget {
  final CountryModel country;
  CountryCell({this.country});

  @override
    Widget build(BuildContext context) {
      var listTile = ListTile(
        title: Text(country.name),
        subtitle: Text(country.countryCode),
      );
      return Column(
        children: <Widget>[
          listTile,
          Divider(height: 8.0,)
        ],
      );
    }
}