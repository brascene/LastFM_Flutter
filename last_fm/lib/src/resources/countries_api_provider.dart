import 'dart:convert';
import 'package:http/http.dart' show Client;
import '../models/flag.dart';

final _baseURL = "https://restcountries.eu/rest/v2/";

class CountriesApiProvider {
  Client client = Client();

  Future<List<CountryModel>> fetchAllCountries() async {
    final response = await client.get("${_baseURL}all");
    final flags = json.decode(response.body);
     
    List<CountryModel> flagList = [];
  
    for(Map<String, dynamic> flag in flags) {
      final newFlag = CountryModel.fromJSON(flag);
      flagList.add(newFlag);
    }
    return flagList;
  }
}