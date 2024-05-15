import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/geo/bloc/geo_bloc.dart';
import 'package:weather_app/features/geo/bloc/geo_state.dart';

class ForecastScreen extends StatelessWidget {
  const ForecastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GeoBloc, GeoState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(state.city),
          ),
          body: Center(
            child: Text(state.city),
          ),
        );
      },
    );
  }
}
