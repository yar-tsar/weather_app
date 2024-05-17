import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

abstract class Injection {
  Injection({
    required this.serviceLocator,
  });

  final GetIt serviceLocator;

  void setup(GetIt serviceLocator);
}
