import 'package:flutter/material.dart';

import '../repository/ApiRepository.dart';
import 'details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: ApiRepository(Uri.parse("http://10.0.2.2:3000")).getCountries(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.count(
              crossAxisCount: 2,
              children:
                  snapshot.data!.map((country) {
                    return GestureDetector(
                      onTap: () {
                        print("Tapped on ${country.name}");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    DetailsScreen(countryName: country.name!),
                          ),
                        );
                      },
                      child: Card(
                        child: Column(
                          children: [
                            Image.network(
                              country.flag!,
                              width: 100,
                              height: 100,
                            ),
                            Text(country.name!, style: TextStyle(fontSize: 18)),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong!"));
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
