import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/geo/bloc/geo_bloc.dart';
import 'package:weather_app/features/geo/bloc/geo_events.dart';
import 'package:weather_app/features/geo/bloc/geo_state.dart';

class TodayView extends StatelessWidget {
  const TodayView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Today'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<GeoBloc>().add(CheckConnection());
          context.read<GeoBloc>().add(GetGeoData());
        },
        child: BlocBuilder<GeoBloc, GeoState>(
          builder: (context, state) {
            return ListView(
              children: [
                Center(
                  child: Text(
                    state.locationInfo,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
