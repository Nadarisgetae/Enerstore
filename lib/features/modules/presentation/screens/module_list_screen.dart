import 'package:flutter/material.dart';
import 'package:energore_design_system/energore_design_system.dart' as ds;
import '../../../home/data/mock_data.dart';
import '../../../shared/presentation/widgets/tier_badge.dart';
import 'module_detail_screen.dart';
import 'module_comparison_screen.dart';

class ModuleListScreen extends StatefulWidget {
  final String? category;

  const ModuleListScreen({super.key, this.category});

  @override
  State<ModuleListScreen> createState() => _ModuleListScreenState();
}

class _ModuleListScreenState extends State<ModuleListScreen> {
  String? _selectedCategory;
  String? _selectedTier;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.category;
  }

  List<MockModule> get _filteredModules {
    var modules = MockModule.sampleModules;
    if (_selectedCategory != null) {
      modules = modules.where((m) => m.category == _selectedCategory).toList();
    }
    if (_selectedTier != null) {
      modules = modules.where((m) => m.qualityTier.name == _selectedTier).toList();
    }
    return modules;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ds.EnerstoreColors.background,
      appBar: AppBar(
        title: Text(_selectedCategory ?? 'All Modules'),
        backgroundColor: ds.EnerstoreColors.surface,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.compare_arrows),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const ModuleComparisonScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filters
          Container(
            color: ds.EnerstoreColors.surface,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedTier,
                    decoration: const InputDecoration(
                      labelText: 'Quality Tier',
                      isDense: true,
                    ),
                    items: [
                      const DropdownMenuItem(
                        value: null,
                        child: Text('All Tiers'),
                      ),
                      ...QualityTier.values.map((tier) {
                        return DropdownMenuItem(
                          value: tier.name,
                          child: Text(tier.name.toUpperCase()),
                        );
                      }),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedTier = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

          // Module Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
              itemCount: _filteredModules.length,
              itemBuilder: (context, index) {
                final module = _filteredModules[index];
                return _ModuleGridCard(module: module);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ModuleGridCard extends StatelessWidget {
  final MockModule module;

  const _ModuleGridCard({required this.module});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ModuleDetailScreen(moduleId: module.id),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
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
                  size: 40,
                  color: ds.EnerstoreColors.primary,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TierBadge(tier: module.qualityTier),
                  const SizedBox(height: 8),
                  Text(
                    module.name,
                    style: ds.EnerstoreTypography.bodyMedium?.copyWith(
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
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    module.description,
                    style: ds.EnerstoreTypography.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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