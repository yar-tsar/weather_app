import 'package:flutter/material.dart';
import 'package:weather_app/features/forecast/presentation/forecast_screen.dart';
import 'package:weather_app/features/today/presentation/today_screen.dart';

class PagedNavigation extends StatefulWidget {
  const PagedNavigation({super.key});

  @override
  State<PagedNavigation> createState() => _PagedNavigationState();
}

class _PagedNavigationState extends State<PagedNavigation> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(
      initialPage: currentIndex,
    );
    super.initState();
  }

  void syncPage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void changePage(int index) {
    setState(() {
      _controller.jumpToPage(index);
      currentIndex = index;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView(
            physics: const AlwaysScrollableScrollPhysics(),
            onPageChanged: syncPage,
            controller: _controller,
            children: const [
              TodayView(),
              ForecastView(),
            ],
          ),
        ),
        BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: changePage,
          items: const [
            BottomNavigationBarItem(
              icon: Text(
                'Today',
              ),
              label: 'Today',
            ),
            BottomNavigationBarItem(
              icon: Text('Forecast'),
              label: 'Forecast',
            ),
          ],
        ),
      ],
    );
  }
}
