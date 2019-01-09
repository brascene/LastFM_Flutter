import 'package:flutter/material.dart';
import 'countries_bloc.dart';
export 'countries_bloc.dart';

class CountriesProvider extends InheritedWidget {
  final CountriesBloc bloc;

  @override
    bool updateShouldNotify(InheritedWidget oldWidget) {
      return true;
    }
  
  CountriesProvider({Key key, Widget child})
    : bloc = CountriesBloc(),
      super(key: key, child: child);

  static CountriesBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(CountriesProvider) as CountriesProvider).bloc;
  }
}