import 'package:flutter/material.dart';
import 'package:energore_design_system/energore_design_system.dart' as ds;
import '../../../home/data/mock_data.dart';
import '../../../shared/presentation/widgets/tier_badge.dart';
import '../../../quotes/presentation/screens/quote_request_screen.dart';

class ModuleDetailScreen extends StatelessWidget {
  final String moduleId;

  const ModuleDetailScreen({super.key, required this.moduleId});

  MockModule? get _module {
    return MockModule.sampleModules.firstWhere(
      (m) => m.id == moduleId,
      orElse: () => MockModule.sampleModules.first,
    );
  }

  @override
  Widget build(BuildContext context) {
    final module = _module!;

    return Scaffold(
      backgroundColor: ds.EnerstoreColors.background,
      appBar: AppBar(
        title: Text(module.name),
        backgroundColor: ds.EnerstoreColors.surface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Module Image
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

            // Module Details
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      TierBadge(tier: module.qualityTier),
                      const SizedBox(width: 12),
                      Text(
                        module.category,
                        style: ds.EnerstoreTypography.bodyMedium?.copyWith(
                          color: ds.EnerstoreColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    module.name,
                    style: ds.EnerstoreTypography.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    module.company,
                    style: ds.EnerstoreTypography.bodyMedium?.copyWith(
                      color: ds.EnerstoreColors.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Description',
                    style: ds.EnerstoreTypography.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    module.description,
                    style: ds.EnerstoreTypography.bodyMedium,
                  ),
                  const SizedBox(height: 16),

                  // Specifications
                  Text(
                    'Specifications',
                    style: ds.EnerstoreTypography.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _SpecItem(
                    label: 'Power Output',
                    value: module.category == 'Panels' ? '540W' : 'N/A',
                  ),
                  _SpecItem(
                    label: 'Warranty',
                    value: '25 Years',
                  ),
                  _SpecItem(
                    label: 'Efficiency',
                    value: '22%',
                  ),
                  _SpecItem(
                    label: 'Certifications',
                    value: 'IEC, ISO, TUV',
                  ),
                  const SizedBox(height: 24),

                  // Request Quotation Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => QuoteRequestScreen(
                              moduleIds: [module.id],
                              setupType: 'specific_modules',
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

class _SpecItem extends StatelessWidget {
  final String label;
  final String value;

  const _SpecItem({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: ds.EnerstoreTypography.bodyMedium?.copyWith(
              color: ds.EnerstoreColors.textSecondary,
            ),
          ),
          Text(
            value,
            style: ds.EnerstoreTypography.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}