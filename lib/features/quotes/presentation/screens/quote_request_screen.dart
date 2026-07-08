import 'package:flutter/material.dart';
import 'package:energore_design_system/energore_design_system.dart' as ds;
import '../../../home/data/mock_data.dart';
import '../../../shared/presentation/widgets/tier_badge.dart';

/// Quote request screen shown after selecting modules/bundles.
/// Displays summary of selected items and allows submission.
class QuoteRequestScreen extends StatefulWidget {
  final List<String> moduleIds;
  final String? bundleId;
  final String? setupType; // complete_setup, custom_setup, specific_modules

  const QuoteRequestScreen({
    super.key,
    required this.moduleIds,
    this.bundleId,
    this.setupType,
  });

  @override
  State<QuoteRequestScreen> createState() => _QuoteRequestScreenState();
}

class _QuoteRequestScreenState extends State<QuoteRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  List<MockModule> get _selectedModules {
    return MockModule.sampleModules
        .where((m) => widget.moduleIds.contains(m.id))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ds.EnerstoreColors.background,
      appBar: AppBar(
        title: const Text('Request Quotation'),
        backgroundColor: ds.EnerstoreColors.surface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Selection',
              style: ds.EnerstoreTypography.headlineMedium,
            ),
            const SizedBox(height: 16),
            ..._selectedModules.map((module) => _SelectedItemCard(module: module)),
            const SizedBox(height: 24),
            Text(
              'Additional Notes (Optional)',
              style: ds.EnerstoreTypography.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _notesController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Any specific requirements or questions?',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Card(
              color: ds.EnerstoreColors.info.withValues(alpha: 0.1),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: ds.EnerstoreColors.info,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Quotation prices will be provided by providers. You\'ll receive multiple quotes to compare.',
                        style: ds.EnerstoreTypography.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: ds.EnerstoreColors.surface,
            border: Border(
              top: BorderSide(color: ds.EnerstoreColors.border),
            ),
          ),
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => const QuoteRequestStatusScreen(),
                ),
              );
            },
            icon: const Icon(Icons.send),
            label: const Text('Submit Request'),
          ),
        ),
      ),
    );
  }
}

class _SelectedItemCard extends StatelessWidget {
  final MockModule module;

  const _SelectedItemCard({required this.module});

  @override
  Widget build(BuildContext context) {
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
            Icons.solar_power,
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
  }
}

/// Status screen shown after quotation request submission.
class QuoteRequestStatusScreen extends StatelessWidget {
  const QuoteRequestStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ds.EnerstoreColors.background,
      appBar: AppBar(
        title: const Text('Request Sent'),
        backgroundColor: ds.EnerstoreColors.surface,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: ds.EnerstoreColors.success.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle,
                  size: 64,
                  color: ds.EnerstoreColors.success,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Request Submitted!',
                style: ds.EnerstoreTypography.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Your quotation request has been sent to providers. You\'ll be notified once they respond.',
                style: ds.EnerstoreTypography.bodyMedium?.copyWith(
                  color: ds.EnerstoreColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Reference: QR-${DateTime.now().year}-${DateTime.now().millisecond.toString().padLeft(4, '0')}',
                style: ds.EnerstoreTypography.bodySmall?.copyWith(
                  color: ds.EnerstoreColors.textSecondary,
                ),
              ),
              const SizedBox(height: 32),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'What happens next?',
                        style: ds.EnerstoreTypography.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _StepItem(
                        step: 1,
                        title: 'Providers review your request',
                        description: 'Matching providers will review your requirements',
                      ),
                      _StepItem(
                        step: 2,
                        title: 'Receive quotations',
                        description: 'Multiple quotations with pricing & terms',
                      ),
                      _StepItem(
                        step: 3,
                        title: 'Compare & proceed',
                        description: 'Select the best offer and we\'ll connect you',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: const Text('Back to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StepItem extends StatelessWidget {
  final int step;
  final String title;
  final String description;

  const _StepItem({
    required this.step,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: ds.EnerstoreColors.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$step',
                style: ds.EnerstoreTypography.bodySmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: ds.EnerstoreTypography.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  description,
                  style: ds.EnerstoreTypography.bodySmall?.copyWith(
                    color: ds.EnerstoreColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}