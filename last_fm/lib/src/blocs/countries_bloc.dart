import 'package:rxdart/rxdart.dart';
import '../models/flag.dart';
import '../resources/repository.dart';

class CountriesBloc {
  final _repository = Repository();
  final _countries = PublishSubject<List<CountryModel>>();

  Observable<List<CountryModel>> get countries => _countries.stream;

  fetchAllCountries() async {
    final shouldFetchCountries = await _repository.shouldFetchCountries();
    if (shouldFetchCountries) {
      final allCountries = await _repository.getAllCountries();
      _countries.sink.add(allCountries);
    } else {
      final savedCountries = await _repository.getSavedCountries();
      _countries.sink.add(savedCountries);
    }
  }

  dispose() {
    _countries.close();
  }
}