import 'package:flutter/material.dart';
import '../blocs/countries_provider.dart';
import '../models/flag.dart';
import '../widgets/country_cell.dart';

class CountriesList extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      final bloc = CountriesProvider.of(context);
      return Scaffold(
        appBar: AppBar(
          title: Text("Countries List"),
        ),
        body: buildCountryList(bloc),
      );
    }

  Widget buildCountryList(CountriesBloc bloc) {
    return StreamBuilder(
      stream: bloc.countries,
      builder: (context, AsyncSnapshot<List<CountryModel>> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator(),);
        }

        var countriesList = ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, int index) {
            return CountryCell(country: snapshot.data[index]);
          },
        );

        TextEditingController editingController = TextEditingController();
        final searchField = TextField(
          controller: editingController,
          decoration: InputDecoration(
            labelText: "Search country",
            hintText: "Search country",
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))
            )
          ),
        );

        var content = Column(
          children: <Widget>[
            Padding(
              child: searchField,
              padding: EdgeInsets.all(10.0),
            ),
            Expanded(
              child: countriesList,
            )
          ],
        );

        return Container(
          child: content,
        );
      },
    );
  }
}
