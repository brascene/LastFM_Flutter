import 'package:flutter/material.dart';
import '../models/flag.dart';
import '../utils/flags_helper.dart';

class CountryCell extends StatelessWidget {
  final CountryModel country;
  CountryCell({this.country});

  @override
    Widget build(BuildContext context) {
      return createCell(country);
    }
  
  Widget createCell(CountryModel c) {
    final imageAsset = flagsHelper.getFlagByCode(c.countryCode);

    final roundedImage = Container(
      width: 80.0,
      height: 80.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: ExactAssetImage(imageAsset)
        )
      ),
    );

    final cell = Row(
      children: <Widget>[
        Container(
          width: 100,
          height: 100,
          padding: EdgeInsets.all(10.0),
          child: roundedImage,
        ),
        Container(
          height: 100,
          padding: EdgeInsets.only(left: 20.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(c.name),
                Text(c.nativeName),
                Text(c.countryCode)
            ],
            ),
          ),
        )
      ],
    );

    final cellAndSeparator = Column(children: <Widget>[
      cell,
      Divider(height: 8.0, color: Colors.blueAccent,)
    ],);

    return cellAndSeparator;
  }
}