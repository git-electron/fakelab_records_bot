// ignore_for_file: constant_identifier_names

import '../../../../../../core/di/di.dart';
import '../../../../../../core/extensions/double_extensions.dart';
import '../../../../../../core/i18n/app_localization.g.dart';

enum OrderType {
  MIX(totalCost: 2500, costFrom: true),
  MASTERING(totalCost: 500, costFrom: false),
  MIX_AND_MASTERING(totalCost: 3000, costFrom: true),
  BEAT(totalCost: 10000, costFrom: true);

  const OrderType({
    required this.totalCost,
    required this.costFrom,
  });
  final double totalCost;
  final bool costFrom;

  String get totalCostFormatted {
    final Translations translations = injector.get();

    return costFrom
        ? translations.cards.order
            .total_cost_from(totalCost: totalCost.inCurrencyRounded)
        : totalCost.inCurrencyRounded;
  }
}
