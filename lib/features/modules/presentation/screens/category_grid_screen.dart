import 'package:flutter/material.dart';
import 'package:energore_design_system/energore_design_system.dart' as ds;
import '../../../home/data/mock_data.dart';
import 'module_list_screen.dart';

class CategoryGridScreen extends StatelessWidget {
  const CategoryGridScreen({super.key});

  static final List<ModuleCategory> _categories = [
    ModuleCategory(
      name: 'Panels',
      icon: Icons.solar_power,
      description: 'Solar panels & modules',
      color: ds.EnerstoreColors.tierPremium,
    ),
    ModuleCategory(
      name: 'Mounting Structures',
      icon: Icons.foundation,
      description: 'Rails, brackets & roof fittings',
      color: ds.EnerstoreColors.tierExcellent,
    ),
    ModuleCategory(
      name: 'Inverters',
      icon: Icons.electric_bolt,
      description: 'String & micro inverters',
      color: ds.EnerstoreColors.tierGood,
    ),
    ModuleCategory(
      name: 'Cables',
      icon: Icons.cable,
      description: 'DC & AC cables',
      color: ds.EnerstoreColors.info,
    ),
    ModuleCategory(
      name: 'Hardware',
      icon: Icons.settings,
      description: 'Nuts, bolts, connectors',
      color: ds.EnerstoreColors.warning,
    ),
    ModuleCategory(
      name: 'Batteries',
      icon: Icons.battery_std,
      description: 'Energy storage solutions',
      color: ds.EnerstoreColors.success,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ds.EnerstoreColors.background,
      appBar: AppBar(
        title: const Text('Buy Specific Modules'),
        backgroundColor: ds.EnerstoreColors.surface,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select a Category',
              style: ds.EnerstoreTypography.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Choose the component you need for your solar setup',
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
                childAspectRatio: 0.9,
                children: _categories.map((category) {
                  return _CategoryCard(
                    category: category,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ModuleListScreen(category: category.name),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ModuleCategory {
  final String name;
  final IconData icon;
  final String description;
  final Color color;

  ModuleCategory({
    required this.name,
    required this.icon,
    required this.description,
    required this.color,
  });
}

class _CategoryCard extends StatelessWidget {
  final ModuleCategory category;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.category,
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
                  color: category.color.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  category.icon,
                  size: 32,
                  color: category.color,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                category.name,
                style: ds.EnerstoreTypography.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                category.description,
                style: ds.EnerstoreTypography.bodySmall?.copyWith(
                  color: ds.EnerstoreColors.textSecondary,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}