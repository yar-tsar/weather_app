import 'package:flutter/material.dart';
import 'package:weather_app/ui/features/forecast/forecast_view.dart';
import 'package:weather_app/ui/features/today/today_view.dart';

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
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView(
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
