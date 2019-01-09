import 'dart:async';
import 'countries_api_provider.dart';
import 'countries_db_provider.dart';
import '../models/flag.dart';

class Repository {
  final apiProvider = CountriesApiProvider();

  Future<List<CountryModel>> getAllCountries() async {
    List<CountryModel> countries;
    countries = await apiProvider.fetchAllCountries();
    for(var country in countries) {
      CountriesDBProvider.sharedDB.addCountry(country);
    }
    return countries;
  }

  Future<bool> shouldFetchCountries() async {
    final localCountries = await CountriesDBProvider.sharedDB.shouldFetchCountries();
    return localCountries;
  }

  Future<List<CountryModel>> getSavedCountries() async {
    List<CountryModel> countries;
    countries = await CountriesDBProvider.sharedDB.getSavedCountries();
    return countries;
  }

  clearCache() async {
    await CountriesDBProvider.sharedDB.clearDBCountries();
  }
}