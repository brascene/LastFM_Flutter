import 'package:rxdart/rxdart.dart';
import '../models/flag.dart';
import '../resources/repository.dart';

class CountriesBloc {
  // Repository and countries stream
  final _repository = Repository();
  var _countries = PublishSubject<List<CountryModel>>();

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

  filterCountries(String searchString) async {
    if (searchString == '') {
      await fetchAllCountries();
      return;
    }
    final filteredCountries = await _repository.filterCountries(searchString);
    _countries.sink.add(filteredCountries);
  }

  dispose() {
    _countries.close();
  }
}
