import 'package:jiffy/jiffy.dart';

bool isSameDateChecker({required int current, required int next}) {
  bool isSameDate = true;
  final currentDate = Jiffy.parseFromMillisecondsSinceEpoch(
    current * 1000,
  ).toLocal();
  final nextDate = Jiffy.parseFromMillisecondsSinceEpoch(
    next * 1000,
  ).toLocal();

  if (!currentDate.isSame(
    nextDate,
    unit: Unit.day,
  )) {
    isSameDate = false;
  }

  return isSameDate;
}
