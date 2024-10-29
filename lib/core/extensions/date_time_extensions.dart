import '../di/di.dart';
import '../i18n/app_localization.g.dart';

extension DateTimeExtensions on DateTime {
  String get dayFormatted {
    return '${day > 10 ? day : '0$day'}';
  }

  String get monthFormatted {
    final Translations translations = injector.get();

    return [
      translations.months.january,
      translations.months.february,
      translations.months.march,
      translations.months.april,
      translations.months.may,
      translations.months.june,
      translations.months.july,
      translations.months.august,
      translations.months.september,
      translations.months.october,
      translations.months.november,
      translations.months.december,
    ][month];
  }

  String get dateFormatted => '$dayFormatted $monthFormatted $year';
}
