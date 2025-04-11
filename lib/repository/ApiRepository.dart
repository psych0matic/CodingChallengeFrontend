import 'package:flag_explorer/generated_code/openapi3_0.models.swagger.dart';
import 'package:flag_explorer/generated_code/openapi3_0.swagger.dart'
    as swagger;

class ApiRepository {
  final swagger.Openapi30 _client;

  ApiRepository(Uri baseUrl)
    : _client = swagger.Openapi30.create(baseUrl: baseUrl);

  Future<List<Country>> getCountries() async {
    final response = await _client.countriesGet();
    return response.body!;
  }

  Future<CountryDetails> getCountryDetails(String countryName) async {
    final response = await _client.countriesNameGet(name: countryName);
    return response.body!;
  }
}
