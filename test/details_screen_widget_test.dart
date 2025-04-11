import 'package:flag_explorer/generated_code/openapi3_0.models.swagger.dart';
import 'package:flag_explorer/repository/ApiRepository.dart';
import 'package:flag_explorer/screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockApiRepository extends Mock implements ApiRepository {
  @override
  Future<CountryDetails> getCountryDetails(String name) async {
    return CountryDetails(
      name: 'France',
      flag: "",
      population: 67000000,
      capital: 'Paris',
    );
  }
}

void main() {
  testWidgets('DetailsScreen displays data from API and renders it', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: DetailsScreen(countryName: 'France')),
    );

    // wait for FutureBuilder to resolve
    await tester.pumpAndSettle();

    expect(find.text('France'), findsOneWidget);
    expect(find.text('Paris'), findsOneWidget);
    expect(find.text('67000000'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });
}
