import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import '../models/flag.dart';

class CountriesDBProvider {
  CountriesDBProvider._();

  static final CountriesDBProvider sharedDB = CountriesDBProvider._();
  Database _db;

  Future<Database> get db async {
    if (_db != null ) return _db;
    _db = await init();
    return _db;
  }

  init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "countries.db");
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDB, int version) async {
        await newDB.execute("""
          CREATE TABLE Countries
          (
            id INTEGER PRIMARY KEY,
            name TEXT,
            nativeName TEXT,
            flag TEXT,
            countryCode TEXT
          )
        """);
      }
    );
  }

  Future<CountryModel> fetchCountry(String countryCode) async {
    final flagMaps = await _db.query(
      "Countries",
      columns: null,
      where: "countryCode = ?",
      whereArgs: [countryCode]
    );

    if (flagMaps.length > 0) {
      return CountryModel.fromDB(flagMaps.first);
    }
    
    return null;
  }

  Future<List<CountryModel>> getSavedCountries() async {
    final thisDB = await db;
    final countriesMap = await thisDB.rawQuery("SELECT * FROM Countries");
    List<CountryModel> countries = [];
    if (countriesMap.length > 0) {
      for (var countryMap in countriesMap) {
        final newCountry = CountryModel.fromDB(countryMap);
        countries.add(newCountry);
      }
    }
    return countries;
  }

  Future<bool> shouldFetchCountries() async {
    final thisDB = await db;
    final countriesMap = await thisDB.rawQuery("SELECT * FROM Countries");
    return !(countriesMap.length > 0);
  }

  Future<int> addCountry(CountryModel flag) {
    final result = _db.insert("Countries", flag.toMapForDB(), conflictAlgorithm: ConflictAlgorithm.ignore);
    return result;
  }

  Future<int> clearDBCountries() {
    return _db.delete("Countries");
  }
}