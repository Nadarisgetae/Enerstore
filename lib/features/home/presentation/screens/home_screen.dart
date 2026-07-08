import 'package:flutter/material.dart';
import 'package:energore_design_system/energore_design_system.dart' as ds;
import '../../data/mock_data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ds.EnerstoreColors.background,
      appBar: AppBar(
        title: const Text('Enerstore'),
        backgroundColor: ds.EnerstoreColors.surface,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // TODO: Navigate to notifications
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Primary action buttons (compact)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: _ActionButton(
                      icon: Icons.settings,
                      label: 'Complete Setup',
                      color: ds.EnerstoreColors.primary,
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _ActionButton(
                      icon: Icons.shopping_cart,
                      label: 'Buy Modules',
                      color: ds.EnerstoreColors.secondary,
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: _ActionButton(
                      icon: Icons.support_agent,
                      label: 'Contact Sales',
                      color: ds.EnerstoreColors.info,
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _ActionButton(
                      icon: Icons.search,
                      label: 'Browse',
                      color: ds.EnerstoreColors.tierPremium,
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Featured Companies
            _SectionHeader(
              title: 'Featured Companies',
              onViewAll: () {},
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: MockCompany.sampleCompanies.length,
                itemBuilder: (context, index) {
                  final company = MockCompany.sampleCompanies[index];
                  return _CompanyCard(company: company);
                },
              ),
            ),

            const SizedBox(height: 24),

            // Featured Modules
            _SectionHeader(
              title: 'Featured Modules',
              onViewAll: () {},
            ),
            SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: MockModule.sampleModules.length,
                itemBuilder: (context, index) {
                  final module = MockModule.sampleModules[index];
                  return _ModuleCard(module: module);
                },
              ),
            ),

            const SizedBox(height: 24),

            // Category: Panels
            _SectionHeader(
              title: 'Panels',
              onViewAll: () {},
            ),
            SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: MockModule.sampleModules
                    .where((m) => m.category == 'Panels')
                    .length,
                itemBuilder: (context, index) {
                  final module = MockModule.sampleModules
                      .where((m) => m.category == 'Panels')
                      .toList()[index];
                  return _ModuleCard(module: module);
                },
              ),
            ),

            const SizedBox(height: 24),

            // Category: Mounting Structures
            _SectionHeader(
              title: 'Mounting Structures',
              onViewAll: () {},
            ),
            SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: MockModule.sampleModules
                    .where((m) => m.category == 'Mounting')
                    .length,
                itemBuilder: (context, index) {
                  final module = MockModule.sampleModules
                      .where((m) => m.category == 'Mounting')
                      .toList()[index];
                  return _ModuleCard(module: module);
                },
              ),
            ),

            const SizedBox(height: 24),

            // Latest Orders
            _SectionHeader(
              title: 'My Recent Requests',
              onViewAll: () {},
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: MockOrder.sampleOrders.length,
              itemBuilder: (context, index) {
                final order = MockOrder.sampleOrders[index];
                return _OrderCard(order: order);
              },
            ),

            const SizedBox(height: 24),
            const SizedBox(height: 80), // Bottom padding for nav bar
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: ds.EnerstoreTypography.bodySmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onViewAll;

  const _SectionHeader({
    required this.title,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: ds.EnerstoreTypography.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: onViewAll,
            child: const Text('View All'),
          ),
        ],
      ),
    );
  }
}

class _CompanyCard extends StatelessWidget {
  final MockCompany company;

  const _CompanyCard({required this.company});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ds.EnerstoreColors.primary.withValues(alpha: 0.1),
              border: Border.all(color: ds.EnerstoreColors.primary),
            ),
            child: Center(
              child: Text(
                company.name.substring(0, 2).toUpperCase(),
                style: ds.EnerstoreTypography.titleMedium?.copyWith(
                  color: ds.EnerstoreColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            company.name,
            style: ds.EnerstoreTypography.bodySmall,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _ModuleCard extends StatelessWidget {
  final MockModule module;

  const _ModuleCard({required this.module});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: ds.EnerstoreColors.primary.withValues(alpha: 0.2),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.solar_power,
                  size: 48,
                  color: ds.EnerstoreColors.primary,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: _getTierColor(module.qualityTier),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      module.qualityTier.name.toUpperCase(),
                      style: ds.EnerstoreTypography.bodySmall?.copyWith(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
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
                    module.company,
                    style: ds.EnerstoreTypography.bodySmall?.copyWith(
                      color: ds.EnerstoreColors.textSecondary,
                      fontSize: 11,
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

  Color _getTierColor(QualityTier tier) {
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

class _OrderCard extends StatelessWidget {
  final MockOrder order;

  const _OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const Icon(
          Icons.receipt_long_outlined,
          color: ds.EnerstoreColors.primary,
        ),
        title: Text(
          order.moduleName,
          style: ds.EnerstoreTypography.bodyMedium,
        ),
        subtitle: Text(
          'Order #${order.id} • ${_formatDate(order.date)}',
          style: ds.EnerstoreTypography.bodySmall?.copyWith(
            color: ds.EnerstoreColors.textSecondary,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: _getStatusColor(order.status),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            order.status,
            style: ds.EnerstoreTypography.bodySmall?.copyWith(
              color: Colors.white,
              fontSize: 11,
            ),
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    if (status.contains('Completed')) return ds.EnerstoreColors.success;
    if (status.contains('Received')) return ds.EnerstoreColors.info;
    return ds.EnerstoreColors.warning;
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}