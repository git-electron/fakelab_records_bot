// ignore_for_file: constant_identifier_names

import '../../../../../../core/extensions/double_extensions.dart';

import '../../../../../../core/di/di.dart';
import '../../../../../../core/i18n/app_localization.g.dart';

enum OrderServiceType {
  MIX(totalCost: 2500, costFrom: true),
  MASTERING(totalCost: 500, costFrom: false),
  BEAT(totalCost: 10000, costFrom: true);

  const OrderServiceType({
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
