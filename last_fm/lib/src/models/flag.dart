class CountryModel {
  final String name;
  final String flag;
  final String nativeName;
  final String countryCode;

  CountryModel.fromJSON(Map<String, dynamic> parsedResponse)
    : name = parsedResponse["name"],
      flag = parsedResponse["flag"],
      countryCode = parsedResponse["alpha2Code"],
      nativeName = parsedResponse["nativeName"];

  CountryModel.fromDB(Map<String, dynamic> parsedJson)
    : name = parsedJson["name"],
      flag = parsedJson["flag"],
      countryCode = parsedJson["countryCode"],
      nativeName = parsedJson["nativeName"];

  Map<String, dynamic> toMapForDB() {
    return <String, dynamic>{
      "name": name,
      "flag": flag,
      "nativeName": nativeName,
      "countryCode": countryCode
    };
  }
}