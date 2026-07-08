import 'package:flutter/material.dart';
import 'package:energore_design_system/energore_design_system.dart' as ds;
import '../../../home/data/mock_data.dart';
import '../../../shared/presentation/widgets/tier_badge.dart';

class ModuleComparisonScreen extends StatefulWidget {
  const ModuleComparisonScreen({super.key});

  @override
  State<ModuleComparisonScreen> createState() => _ModuleComparisonScreenState();
}

class _ModuleComparisonScreenState extends State<ModuleComparisonScreen> {
  List<String> _selectedModuleIds = [];

  void _toggleSelection(String moduleId) {
    setState(() {
      if (_selectedModuleIds.contains(moduleId)) {
        _selectedModuleIds.remove(moduleId);
      } else {
        if (_selectedModuleIds.length < 3) {
          _selectedModuleIds.add(moduleId);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('You can compare up to 3 modules at a time')),
          );
        }
      }
    });
  }

  List<MockModule> get _selectedModules {
    return MockModule.sampleModules
        .where((m) => _selectedModuleIds.contains(m.id))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ds.EnerstoreColors.background,
      appBar: AppBar(
        title: const Text('Compare Modules'),
        backgroundColor: ds.EnerstoreColors.surface,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Selected modules header
          Container(
            color: ds.EnerstoreColors.surface,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selected for Comparison (${_selectedModuleIds.length}/3)',
                  style: ds.EnerstoreTypography.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 12,
                  children: MockModule.sampleModules.map((module) {
                    final isSelected = _selectedModuleIds.contains(module.id);
                    return ChoiceChip(
                      label: Text(module.name),
                      selected: isSelected,
                      onSelected: (selected) => _toggleSelection(module.id),
                      labelStyle: ds.EnerstoreTypography.bodySmall?.copyWith(
                        color: isSelected ? Colors.white : ds.EnerstoreColors.textPrimary,
                      ),
                      selectedColor: ds.EnerstoreColors.primary,
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          if (_selectedModules.isEmpty)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.compare_arrows,
                      size: 64,
                      color: ds.EnerstoreColors.textSecondary.withValues(alpha: 0.3),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Select modules to compare',
                      style: ds.EnerstoreTypography.bodyLarge?.copyWith(
                        color: ds.EnerstoreColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: _buildComparisonTable(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildComparisonTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: MaterialStateProperty.all(
          ds.EnerstoreColors.primary.withValues(alpha: 0.1),
        ),
        columns: [
          const DataColumn(label: Text('Feature')),
          ..._selectedModules.map((m) => DataColumn(
                label: SizedBox(
                  width: 120,
                  child: Text(
                    m.name,
                    style: ds.EnerstoreTypography.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )),
        ],
        rows: [
          DataRow(
            cells: [
              const DataCell(Text('Quality Tier')),
              ..._selectedModules.map((m) => DataCell(
                    TierBadge(tier: m.qualityTier, isSmall: true),
                  )),
            ],
          ),
          DataRow(
            cells: [
              const DataCell(Text('Company')),
              ..._selectedModules.map((m) => DataCell(
                    Text(
                      m.company,
                      style: ds.EnerstoreTypography.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )),
            ],
          ),
          DataRow(
            cells: [
              const DataCell(Text('Category')),
              ..._selectedModules.map((m) => DataCell(
                    Text(
                      m.category,
                      style: ds.EnerstoreTypography.bodySmall,
                    ),
                  )),
            ],
          ),
          DataRow(
            cells: [
              const DataCell(Text('Warranty')),
              ..._selectedModules.map((m) => DataCell(
                    const Text('25 Years'),
                  )),
            ],
          ),
          DataRow(
            cells: [
              const DataCell(Text('Efficiency')),
              ..._selectedModules.map((m) => DataCell(
                    const Text('22%'),
                  )),
            ],
          ),
          DataRow(
            cells: [
              const DataCell(Text('Certifications')),
              ..._selectedModules.map((m) => DataCell(
                    const Text('IEC, ISO, TUV'),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}