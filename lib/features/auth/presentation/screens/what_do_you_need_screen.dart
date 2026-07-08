import 'package:flutter/material.dart';
import 'package:energore_design_system/energore_design_system.dart' as ds;
import '../../../complete_setup/presentation/screens/setup_list_screen.dart';
import '../../../modules/presentation/screens/category_grid_screen.dart';
import '../../../sales_leads/presentation/screens/sales_lead_screen.dart';
import '../../../home/presentation/screens/home_screen.dart';

/// First screen shown after login/registration.
/// Presents 4 large option cards for the customer to choose their path.
class WhatDoYouNeedScreen extends StatelessWidget {
  const WhatDoYouNeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ds.EnerstoreColors.background,
      appBar: AppBar(
        title: const Text('What do you need?'),
        backgroundColor: ds.EnerstoreColors.surface,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How can we help you today?',
              style: ds.EnerstoreTypography.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Choose one of the options below to get started',
              style: ds.EnerstoreTypography.bodyMedium?.copyWith(
                color: ds.EnerstoreColors.textSecondary,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.85,
                children: [
                  _OptionCard(
                    icon: Icons.settings,
                    title: 'Complete Setup',
                    description: 'Get a bundled solar solution with all components',
                    color: ds.EnerstoreColors.primary,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const SetupListScreen()),
                      );
                    },
                  ),
                  _OptionCard(
                    icon: Icons.shopping_cart,
                    title: 'Buy Specific Modules',
                    description: 'Pick individual components for your project',
                    color: ds.EnerstoreColors.secondary,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const CategoryGridScreen()),
                      );
                    },
                  ),
                  _OptionCard(
                    icon: Icons.support_agent,
                    title: 'Contact Sales',
                    description: 'Talk to our team about your requirements',
                    color: ds.EnerstoreColors.info,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const SalesLeadScreen()),
                      );
                    },
                  ),
                  _OptionCard(
                    icon: Icons.search,
                    title: 'Just Browse',
                    description: 'Explore modules and providers anytime',
                    color: ds.EnerstoreColors.tierPremium,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const HomeScreen()),
                      );
                    },
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

class _OptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final VoidCallback onTap;

  const _OptionCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: color,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: ds.EnerstoreTypography.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: ds.EnerstoreTypography.bodySmall?.copyWith(
                  color: ds.EnerstoreColors.textSecondary,
                ),
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}