import 'package:flutter/material.dart';
import 'package:energore_design_system/energore_design_system.dart' as ds;
import '../../../home/data/mock_data.dart';
import '../../../modules/presentation/screens/module_detail_screen.dart';
import '../../../quotes/presentation/screens/quote_request_screen.dart';
import '../../../shared/presentation/widgets/tier_badge.dart';

/// Step-by-step setup builder where users customize their own solar setup.
/// Users pick each component category individually and can swap providers.
class SetupBuilderScreen extends StatefulWidget {
  const SetupBuilderScreen({super.key});

  @override
  State<SetupBuilderScreen> createState() => _SetupBuilderScreenState();
}

class _SetupBuilderScreenState extends State<SetupBuilderScreen> {
  int _currentStep = 0;
  final Map<String, String?> _selectedModules = {
    'Panels': null,
    'Mounting': null,
    'Inverters': null,
    'Cables': null,
    'Hardware': null,
  };

  final List<String> _steps = ['Panels', 'Mounting', 'Inverters', 'Cables', 'Hardware', 'Review'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ds.EnerstoreColors.background,
      appBar: AppBar(
        title: const Text('Customize Setup'),
        backgroundColor: ds.EnerstoreColors.surface,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: List.generate(_steps.length, (index) {
                final isActive = index == _currentStep;
                final isCompleted = index < _currentStep;
                return Expanded(
                  child: Row(
                    children: [
                      if (index > 0)
                        Expanded(
                          child: Container(
                            height: 2,
                            color: isCompleted || (index <= _currentStep)
                                ? ds.EnerstoreColors.primary
                                : ds.EnerstoreColors.border,
                          ),
                        ),
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isActive
                              ? ds.EnerstoreColors.primary
                              : isCompleted
                                  ? ds.EnerstoreColors.success
                                  : ds.EnerstoreColors.border,
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: ds.EnerstoreTypography.bodySmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
      body: _buildStepContent(),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildStepContent() {
    final currentCategory = _steps[_currentStep];

    if (currentCategory == 'Review') {
      return _buildReviewStep();
    }

    final modules = MockModule.sampleModules
        .where((m) => m.category == currentCategory)
        .toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select $currentCategory',
            style: ds.EnerstoreTypography.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Choose from available options',
            style: ds.EnerstoreTypography.bodyMedium?.copyWith(
              color: ds.EnerstoreColors.textSecondary,
            ),
          ),
          const SizedBox(height: 24),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.8,
            ),
            itemCount: modules.length,
            itemBuilder: (context, index) {
              final module = modules[index];
              final isSelected = _selectedModules[currentCategory] == module.id;
              return _ModuleSelectorCard(
                module: module,
                isSelected: isSelected,
                onTap: () {
                  setState(() {
                    _selectedModules[currentCategory] = module.id;
                  });
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildReviewStep() {
    final selectedModules = _selectedModules.entries.where((e) => e.value != null).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Review Your Setup',
            style: ds.EnerstoreTypography.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Verify your selected components',
            style: ds.EnerstoreTypography.bodyMedium?.copyWith(
              color: ds.EnerstoreColors.textSecondary,
            ),
          ),
          const SizedBox(height: 24),
          ...selectedModules.map((entry) {
            final module = MockModule.sampleModules.firstWhere(
              (m) => m.id == entry.value,
              orElse: () => MockModule.sampleModules.first,
            );
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
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
                trailing: TierBadge(tier: module.qualityTier),
              ),
            );
          }),
          const SizedBox(height: 24),
          Card(
            color: ds.EnerstoreColors.success.withValues(alpha: 0.1),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: ds.EnerstoreColors.success,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '${selectedModules.length} components selected',
                    style: ds.EnerstoreTypography.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    final isLastStep = _currentStep == _steps.length - 1;
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ds.EnerstoreColors.surface,
          border: Border(
            top: BorderSide(color: ds.EnerstoreColors.border),
          ),
        ),
        child: Row(
          children: [
            if (_currentStep > 0)
              TextButton(
                onPressed: () {
                  setState(() {
                    _currentStep--;
                  });
                },
                child: const Text('Back'),
              ),
            const Spacer(),
            if (!isLastStep)
              ElevatedButton(
                onPressed: _selectedModules[_steps[_currentStep]] != null
                    ? () {
                        setState(() {
                          _currentStep++;
                        });
                      }
                    : null,
                child: const Text('Continue'),
              )
            else
              ElevatedButton.icon(
                onPressed: () {
                  final selectedModuleIds = _selectedModules.values
                      .where((id) => id != null)
                      .cast<String>()
                      .toList();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => QuoteRequestScreen(
                        moduleIds: selectedModuleIds,
                        setupType: 'custom_setup',
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.request_quote),
                label: const Text('Request Quotation'),
              ),
          ],
        ),
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

class _ModuleSelectorCard extends StatelessWidget {
  final MockModule module;
  final bool isSelected;
  final VoidCallback onTap;

  const _ModuleSelectorCard({
    required this.module,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isSelected ? 4 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isSelected
            ? BorderSide(color: ds.EnerstoreColors.primary, width: 2)
            : BorderSide.none,
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
                  TierBadge(tier: module.qualityTier),
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
                    module.company,
                    style: ds.EnerstoreTypography.bodySmall?.copyWith(
                      color: ds.EnerstoreColors.textSecondary,
                      fontSize: 10,
                    ),
                    maxLines: 1,
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