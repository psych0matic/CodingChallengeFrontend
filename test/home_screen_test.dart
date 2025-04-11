import 'package:flag_explorer/generated_code/openapi3_0.models.swagger.dart';
import 'package:flag_explorer/repository/ApiRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockApiRepository extends Mock implements ApiRepository {}

void main() {
  group("HomeScreen Unit Test", () {
    testWidgets("Displays a list of countries when data is loaded", (
      tester,
    ) async {
      final mockRepo = MockApiRepository();
      when(mockRepo.getCountries()).thenAnswer(
        (_) async => [
          Country(name: 'France', flag: ''),
          Country(name: 'Germany', flag: ''),
        ],
      );

      await tester.pumpWidget(
        MaterialApp(
          home: FutureBuilder(
            future: mockRepo.getCountries(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children:
                      snapshot.data!.map<Widget>((country) {
                        return Text(country.name!);
                      }).toList(),
                );
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      );

      await tester.pump();

      expect(find.text('France'), findsOneWidget);
      expect(find.text('Germany'), findsOneWidget);
    });
  });
}
