import 'package:flutter/material.dart';
import './src/screens/countries_screen.dart';
import './src/blocs/countries_provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var countryChild = MaterialApp(
      title: "LastFM",
      onGenerateRoute: routes,
    );
    var countriesProvider = CountriesProvider(
      child: countryChild,
    );
    return countriesProvider;
  }

  Route routes(RouteSettings settings) {
    return MaterialPageRoute(builder: (BuildContext context) {
      final countriesBloc = CountriesProvider.of(context);
      countriesBloc.fetchAllCountries();
      return CountriesList();
    });
  }
}
