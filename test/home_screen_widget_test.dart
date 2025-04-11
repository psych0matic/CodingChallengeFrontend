import 'package:flag_explorer/generated_code/openapi3_0.models.swagger.dart';
import 'package:flag_explorer/repository/ApiRepository.dart';
import 'package:flag_explorer/screens/details_screen.dart';
import 'package:flag_explorer/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class FakeCountry {
  static List<Country> list = [
    Country(name: 'France', flag: 'https://flagcdn.com/fr.png'),
    Country(name: 'Germany', flag: 'https://flagcdn.com/de.png'),
  ];
}

class MockApiRepository extends Mock implements ApiRepository {
  @override
  Future<List<Country>> getCountries() async {
    return FakeCountry.list;
  }
}

void main() {
  testWidgets('HomeScreen loads countries and navigates on tap', (
    tester,
  ) async {
    final mockRepo = MockApiRepository();

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            return FutureBuilder(
              future: mockRepo.getCountries(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return HomeScreen(); // Your real widget
                }
                return CircularProgressIndicator();
              },
            );
          },
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('France'), findsOneWidget);
    expect(find.text('Germany'), findsOneWidget);

    // Tap on a country card
    await tester.tap(find.text('France'));
    await tester.pumpAndSettle();

    // Check if DetailsScreen is pushed (can be verified by checking UI or navigator)
    expect(find.byType(DetailsScreen), findsOneWidget);
  });
}
