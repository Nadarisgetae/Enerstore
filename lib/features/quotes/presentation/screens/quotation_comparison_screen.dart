import 'package:flutter/material.dart';
import 'package:energore_design_system/energore_design_system.dart' as ds;
import '../../../home/data/mock_data.dart';
import '../../../shared/presentation/widgets/tier_badge.dart';

/// Screen for comparing multiple quotations and accepting one.
/// When customer accepts a quotation, they're prompted to contact sales team.
class QuotationComparisonScreen extends StatefulWidget {
  final String quoteRequestId;

  const QuotationComparisonScreen({
    super.key,
    required this.quoteRequestId,
  });

  @override
  State<QuotationComparisonScreen> createState() => _QuotationComparisonScreenState();
}

class _QuotationComparisonScreenState extends State<QuotationComparisonScreen> {
  MockQuotation? _selectedQuotation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ds.EnerstoreColors.background,
      appBar: AppBar(
        title: const Text('Compare Quotations'),
        backgroundColor: ds.EnerstoreColors.surface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Received Quotations',
              style: ds.EnerstoreTypography.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Choose the best offer and proceed with our sales team',
              style: ds.EnerstoreTypography.bodyMedium?.copyWith(
                color: ds.EnerstoreColors.textSecondary,
              ),
            ),
            const SizedBox(height: 24),
            ...MockQuotation.sampleQuotations.map((quotation) => _QuotationCard(
                  quotation: quotation,
                  isSelected: _selectedQuotation?.id == quotation.id,
                  onSelect: () {
                    setState(() {
                      _selectedQuotation = quotation;
                    });
                  },
                )),
            const SizedBox(height: 24),
            if (_selectedQuotation != null) _buildComparisonSummary(),
          ],
        ),
      ),
      bottomNavigationBar: _selectedQuotation != null
          ? SafeArea(
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
                    _showContactSalesDialog();
                  },
                  icon: const Icon(Icons.chat),
                  label: const Text('Proceed - Contact Sales Team'),
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildComparisonSummary() {
    final quotation = _selectedQuotation!;
    return Card(
      color: ds.EnerstoreColors.info.withValues(alpha: 0.1),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selected: ${quotation.providerName}',
              style: ds.EnerstoreTypography.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(
                  Icons.check_circle,
                  color: ds.EnerstoreColors.success,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  'Price: ₹${quotation.price.toStringAsFixed(0)}',
                  style: ds.EnerstoreTypography.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.access_time,
                  color: ds.EnerstoreColors.primary,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  quotation.validity,
                  style: ds.EnerstoreTypography.bodyMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showContactSalesDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Contact Sales Team'),
        content: Text(
          'You selected ${_selectedQuotation!.providerName}.\n\n'
          'Would you like to proceed with our sales team?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ChatScreen(
                    providerName: _selectedQuotation!.providerName,
                  ),
                ),
              );
            },
            child: const Text('Contact Sales'),
          ),
        ],
      ),
    );
  }
}

class _QuotationCard extends StatelessWidget {
  final MockQuotation quotation;
  final bool isSelected;
  final VoidCallback onSelect;

  const _QuotationCard({
    required this.quotation,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isSelected
            ? const BorderSide(color: ds.EnerstoreColors.primary, width: 2)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: onSelect,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      quotation.providerName,
                      style: ds.EnerstoreTypography.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (isSelected)
                    const Icon(
                      Icons.check_circle,
                      color: ds.EnerstoreColors.primary,
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                '₹${quotation.price.toStringAsFixed(0)}',
                style: ds.EnerstoreTypography.headlineMedium?.copyWith(
                  color: ds.EnerstoreColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                quotation.terms,
                style: ds.EnerstoreTypography.bodyMedium?.copyWith(
                  color: ds.EnerstoreColors.textSecondary,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: ds.EnerstoreColors.info.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      quotation.validity,
                      style: ds.EnerstoreTypography.bodySmall,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}