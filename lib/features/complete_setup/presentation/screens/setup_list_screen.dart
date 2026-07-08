import 'package:flutter/material.dart';
import 'package:energore_design_system/energore_design_system.dart' as ds;
import '../../../home/data/mock_data.dart';
import 'setup_builder_screen.dart';
import 'bundle_detail_screen.dart';

class SetupListScreen extends StatelessWidget {
  const SetupListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ds.EnerstoreColors.background,
      appBar: AppBar(
        title: const Text('Complete Solar Setups'),
        backgroundColor: ds.EnerstoreColors.surface,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pre-configured Solar Solutions',
                  style: ds.EnerstoreTypography.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Choose a complete setup or customize your own',
                  style: ds.EnerstoreTypography.bodyMedium?.copyWith(
                    color: ds.EnerstoreColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: MockBundle.sampleBundles.length + 1, // +1 for customize option
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _CustomizeBanner(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const SetupBuilderScreen(),
                        ),
                      );
                    },
                  );
                }
                final bundle = MockBundle.sampleBundles[index - 1];
                return _BundleCard(
                  bundle: bundle,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => BundleDetailScreen(bundleId: bundle.id),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomizeBanner extends StatelessWidget {
  final VoidCallback onTap;

  const _CustomizeBanner({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: ds.EnerstoreColors.primary.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: ds.EnerstoreColors.primary.withValues(alpha: 0.3),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: ds.EnerstoreColors.primary.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.build,
                  size: 30,
                  color: ds.EnerstoreColors.primary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Customize Your Own Setup',
                      style: ds.EnerstoreTypography.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Mix and match components from different providers',
                      style: ds.EnerstoreTypography.bodySmall?.copyWith(
                        color: ds.EnerstoreColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward,
                color: ds.EnerstoreColors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BundleCard extends StatelessWidget {
  final MockBundle bundle;
  final VoidCallback onTap;

  const _BundleCard({required this.bundle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 140,
              decoration: BoxDecoration(
                color: ds.EnerstoreColors.primary.withValues(alpha: 0.2),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.solar_power,
                  size: 60,
                  color: ds.EnerstoreColors.primary,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (bundle.isFeatured)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: ds.EnerstoreColors.success,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'FEATURED',
                            style: ds.EnerstoreTypography.bodySmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      const SizedBox(width: 8),
                      Text(
                        bundle.name,
                        style: ds.EnerstoreTypography.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    bundle.description,
                    style: ds.EnerstoreTypography.bodySmall?.copyWith(
                      color: ds.EnerstoreColors.textSecondary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                        Icons.business,
                        size: 16,
                        color: ds.EnerstoreColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        bundle.company,
                        style: ds.EnerstoreTypography.bodySmall?.copyWith(
                          color: ds.EnerstoreColors.textSecondary,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${bundle.moduleIds.length} components',
                        style: ds.EnerstoreTypography.bodySmall?.copyWith(
                          color: ds.EnerstoreColors.primary,
                        ),
                      ),
                    ],
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