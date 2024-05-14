import 'package:flutter/material.dart';

class ForecastView extends StatelessWidget {
  const ForecastView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forecast'),
      ),
      body: const Center(
        child: Text('Forecast'),
      ),
    );
  }
}
