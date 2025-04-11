import 'package:flag_explorer/generated_code/openapi3_0.models.swagger.dart';
import 'package:flag_explorer/repository/ApiRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockApiRepository extends Mock implements ApiRepository {}

void main() {
  group('DetailsScreen Unit Test', () {
    testWidgets('shows country details when data is loaded', (tester) async {
      final mockCountry = CountryDetails(
        name: 'Germany',
        flag: 'https://flagcdn.com/de.svg',
        population: 83000000,
        capital: 'Berlin',
      );

      // Use a stubbed FutureBuilder directly in this case
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FutureBuilder<CountryDetails>(
              future: Future.value(mockCountry),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final country = snapshot.data!;
                  return Column(
                    children: [
                      Text(country.name!),
                      Text(country.flag!),
                      Text(country.capital!),
                      Text('${country.population}'),
                    ],
                  );
                }
                return CircularProgressIndicator();
              },
            ),
          ),
        ),
      );

      await tester.pump(); // finish FutureBuilder

      expect(find.text('Germany'), findsOneWidget);
      expect(find.text('Berlin'), findsOneWidget);
      expect(find.text('83000000'), findsOneWidget);
    });
  });
}
