import 'package:flutter/material.dart';
import 'package:weather_app/ui/widgets/paged_navigation.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const SafeArea(
        child: PagedNavigation(),
      ),
    );
  }
}
