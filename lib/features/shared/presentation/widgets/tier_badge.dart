import 'package:flutter/material.dart';
import '../../../home/data/mock_data.dart';
import 'package:energore_design_system/energore_design_system.dart' as ds;

class TierBadge extends StatelessWidget {
  final QualityTier tier;
  final bool isSmall;

  const TierBadge({
    super.key,
    required this.tier,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = _getTierColor(tier);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 6 : 8,
        vertical: isSmall ? 2 : 4,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(isSmall ? 8 : 12),
      ),
      child: Text(
        tier.name.toUpperCase(),
        style: (isSmall
            ? ds.EnerstoreTypography.bodySmall
            : ds.EnerstoreTypography.bodyMedium
        )?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  static Color _getTierColor(QualityTier tier) {
    switch (tier) {
      case QualityTier.premium:
        return ds.EnerstoreColors.tierPremium;
      case QualityTier.excellent:
        return ds.EnerstoreColors.tierExcellent;
      case QualityTier.good:
        return ds.EnerstoreColors.tierGood;
      case QualityTier.normal:
        return ds.EnerstoreColors.tierNormal;
    }
  }
}