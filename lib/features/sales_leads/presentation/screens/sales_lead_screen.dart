import 'package:flutter/material.dart';
import 'package:energore_design_system/energore_design_system.dart' as ds;

/// Contact Sales screen for customers to talk to Enercore sales team.
/// Includes structured form with scenario, requirements, budget, timeline.
class SalesLeadScreen extends StatefulWidget {
  const SalesLeadScreen({super.key});

  @override
  State<SalesLeadScreen> createState() => _SalesLeadScreenState();
}

class _SalesLeadScreenState extends State<SalesLeadScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scenarioController = TextEditingController();
  final _requirementController = TextEditingController();
  final _budgetMinController = TextEditingController();
  final _budgetMaxController = TextEditingController();

  String? _selectedTimeline;

  final List<String> _timelineOptions = [
    'Immediately',
    'Within 1 month',
    'Within 3 months',
    'Within 6 months',
    'Just exploring options',
  ];

  @override
  void dispose() {
    _scenarioController.dispose();
    _requirementController.dispose();
    _budgetMinController.dispose();
    _budgetMaxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ds.EnerstoreColors.background,
      appBar: AppBar(
        title: const Text('Contact Sales'),
        backgroundColor: ds.EnerstoreColors.surface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tell Us About Your Project',
                style: ds.EnerstoreTypography.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Our sales team will get back to you with options',
                style: ds.EnerstoreTypography.bodyMedium?.copyWith(
                  color: ds.EnerstoreColors.textSecondary,
                ),
              ),
              const SizedBox(height: 24),

              // Current Setup/Scenario
              Text(
                'Current Setup / Scenario',
                style: ds.EnerstoreTypography.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _scenarioController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Describe your current situation (e.g., new construction, existing grid-tied system, etc.)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please describe your scenario';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Requirement Description
              Text(
                'What do you need?',
                style: ds.EnerstoreTypography.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _requirementController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Describe your solar requirements in detail',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please describe your requirements';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Budget Range
              Text(
                'Budget Range (Optional)',
                style: ds.EnerstoreTypography.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _budgetMinController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Min (₹)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _budgetMaxController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Max (₹)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Timeline
              Text(
                'Timeline Expectation',
                style: ds.EnerstoreTypography.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedTimeline,
                decoration: const InputDecoration(
                  labelText: 'When do you need this?',
                  border: OutlineInputBorder(),
                ),
                items: _timelineOptions.map((option) {
                  return DropdownMenuItem(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedTimeline = value;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Contact Preference
              Text(
                'Preferred Contact Method',
                style: ds.EnerstoreTypography.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 12,
                children: [
                  ChoiceChip(
                    label: const Text('Email'),
                    selected: true,
                    onSelected: (_) {},
                    selectedColor: ds.EnerstoreColors.primary,
                  ),
                  ChoiceChip(
                    label: const Text('Phone'),
                    selected: false,
                    onSelected: (_) {},
                    selectedColor: ds.EnerstoreColors.primary,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Submit info card
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
                          'This will create a sales lead for the Enercore team to follow up.',
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
            onPressed: _handleSubmit,
            icon: const Icon(Icons.send),
            label: const Text('Submit to Sales Team'),
          ),
        ),
      ),
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Request Submitted'),
          content: const Text(
            'Your sales lead has been submitted. The sales team will contact you within 24 hours.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}