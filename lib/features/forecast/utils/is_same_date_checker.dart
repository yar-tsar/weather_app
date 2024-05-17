import 'package:jiffy/jiffy.dart';

bool isSameDateChecker({required int current, required int next}) {
  bool isSameDate = true;
  final currentDate = Jiffy.parseFromMillisecondsSinceEpoch(
    current * 1000,
  );
  final nextDate = Jiffy.parseFromMillisecondsSinceEpoch(
    next * 1000,
  );

  if (!currentDate.isSame(
    nextDate,
    unit: Unit.day,
  )) {
    isSameDate = false;
  }

  return isSameDate;
}
