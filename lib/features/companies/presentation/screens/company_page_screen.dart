import 'package:flutter/material.dart';
import 'package:energore_design_system/energore_design_system.dart' as ds;
import '../../../home/data/mock_data.dart';
import '../../../modules/presentation/screens/module_detail_screen.dart';
import '../../../shared/presentation/widgets/tier_badge.dart';

/// Company page showing company details and their product listings.
class CompanyPageScreen extends StatelessWidget {
  final String companyId;

  const CompanyPageScreen({super.key, required this.companyId});

  MockCompany? get _company {
    return MockCompany.sampleCompanies.firstWhere(
      (c) => c.id == companyId,
      orElse: () => MockCompany.sampleCompanies.first,
    );
  }

  List<MockModule> get _companyModules {
    return MockModule.sampleModules.where((m) => m.company == _company!.name).toList();
  }

  @override
  Widget build(BuildContext context) {
    final company = _company!;

    return Scaffold(
      backgroundColor: ds.EnerstoreColors.background,
      appBar: AppBar(
        title: Text(company.name),
        backgroundColor: ds.EnerstoreColors.surface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Company Banner
            Container(
              height: 200,
              color: ds.EnerstoreColors.primary.withValues(alpha: 0.1),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ds.EnerstoreColors.primary,
                      ),
                      child: Center(
                        child: Text(
                          company.name.substring(0, 2).toUpperCase(),
                          style: ds.EnerstoreTypography.displayLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: ds.EnerstoreColors.success,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'VERIFIED PARTNER',
                        style: ds.EnerstoreTypography.bodySmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Company Details
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    company.name,
                    style: ds.EnerstoreTypography.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    company.description,
                    style: ds.EnerstoreTypography.bodyMedium?.copyWith(
                      color: ds.EnerstoreColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Stats
                  Row(
                    children: [
                      _StatCard(
                        label: 'Products',
                        value: _companyModules.length.toString(),
                        icon: Icons.category,
                      ),
                      const SizedBox(width: 12),
                      _StatCard(
                        label: 'Rating',
                        value: '4.8',
                        icon: Icons.star,
                      ),
                      const SizedBox(width: 12),
                      _StatCard(
                        label: 'On-time %',
                        value: '96%',
                        icon: Icons.schedule,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Products Section
                  Text(
                    'Products Offered',
                    style: ds.EnerstoreTypography.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Product Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemCount: _companyModules.length,
                itemBuilder: (context, index) {
                  final module = _companyModules[index];
                  return _ProductCard(
                    module: module,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ModuleDetailScreen(moduleId: module.id),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: ds.EnerstoreColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ds.EnerstoreColors.border),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: ds.EnerstoreColors.primary,
              size: 20,
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: ds.EnerstoreTypography.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: ds.EnerstoreTypography.bodySmall?.copyWith(
                color: ds.EnerstoreColors.textSecondary,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final MockModule module;
  final VoidCallback onTap;

  const _ProductCard({required this.module, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 80,
              decoration: BoxDecoration(
                color: ds.EnerstoreColors.primary.withValues(alpha: 0.2),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.solar_power,
                  size: 40,
                  color: ds.EnerstoreColors.primary,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TierBadge(tier: module.qualityTier, isSmall: true),
                  const SizedBox(height: 6),
                  Text(
                    module.name,
                    style: ds.EnerstoreTypography.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    module.category,
                    style: ds.EnerstoreTypography.bodySmall?.copyWith(
                      color: ds.EnerstoreColors.textSecondary,
                      fontSize: 10,
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