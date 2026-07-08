import 'package:flutter/material.dart';
import 'package:energore_design_system/energore_design_system.dart' as ds;
import '../../../home/data/mock_data.dart';
import '../../../shared/presentation/widgets/tier_badge.dart';
import '../../../quotes/presentation/screens/quote_request_screen.dart';

class BundleDetailScreen extends StatelessWidget {
  final String bundleId;

  const BundleDetailScreen({super.key, required this.bundleId});

  MockBundle? get _bundle {
    return MockBundle.sampleBundles.firstWhere(
      (b) => b.id == bundleId,
      orElse: () => MockBundle.sampleBundles.first,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bundle = _bundle!;

    return Scaffold(
      backgroundColor: ds.EnerstoreColors.background,
      appBar: AppBar(
        title: Text(bundle.name),
        backgroundColor: ds.EnerstoreColors.surface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bundle Image
            Container(
              height: 200,
              color: ds.EnerstoreColors.surface,
              child: Center(
                child: Icon(
                  Icons.solar_power,
                  size: 100,
                  color: ds.EnerstoreColors.primary,
                ),
              ),
            ),

            // Bundle Details
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bundle.name,
                    style: ds.EnerstoreTypography.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    bundle.description,
                    style: ds.EnerstoreTypography.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Includes Components',
                    style: ds.EnerstoreTypography.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Component list
                  ...bundle.moduleIds.map((moduleId) {
                    final module = MockModule.sampleModules.firstWhere(
                      (m) => m.id == moduleId,
                      orElse: () => MockModule.sampleModules.first,
                    );
                    return _ComponentItem(module: module);
                  }),

                  const SizedBox(height: 24),
                  Text(
                    'Provider',
                    style: ds.EnerstoreTypography.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ds.EnerstoreColors.primary.withValues(alpha: 0.2),
                        ),
                        child: Center(
                          child: Text(
                            bundle.company.substring(0, 2).toUpperCase(),
                            style: ds.EnerstoreTypography.titleMedium?.copyWith(
                              color: ds.EnerstoreColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        bundle.company,
                        style: ds.EnerstoreTypography.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => QuoteRequestScreen(
                              moduleIds: bundle.moduleIds,
                              bundleId: bundle.id,
                              setupType: 'complete_setup',
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.request_quote),
                      label: const Text('Request Quotation'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ComponentItem extends StatelessWidget {
  final MockModule module;

  const _ComponentItem({required this.module});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: ds.EnerstoreColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            _getCategoryIcon(module.category),
            size: 20,
            color: ds.EnerstoreColors.primary,
          ),
        ),
        title: Text(
          module.name,
          style: ds.EnerstoreTypography.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          module.company,
          style: ds.EnerstoreTypography.bodySmall?.copyWith(
            color: ds.EnerstoreColors.textSecondary,
          ),
        ),
        trailing: TierBadge(tier: module.qualityTier, isSmall: true),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Panels':
        return Icons.solar_power;
      case 'Mounting':
        return Icons.foundation;
      case 'Inverters':
        return Icons.electric_bolt;
      case 'Cables':
        return Icons.cable;
      case 'Hardware':
        return Icons.settings;
      default:
        return Icons.category;
    }
  }
}