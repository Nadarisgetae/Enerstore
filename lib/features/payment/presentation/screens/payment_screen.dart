import 'package:flutter/material.dart';
import 'package:energore_design_system/energore_design_system.dart' as ds;

/// Payment screen for handling payments against Plan payment schedule.
/// Integrates with Razorpay for in-app payments (sandbox/test mode for Phase 1).
class PaymentScreen extends StatefulWidget {
  final String orderId;
  final String planId;

  const PaymentScreen({
    super.key,
    required this.orderId,
    required this.planId,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int selectedPaymentMethod = 0; // 0: Razorpay, 1: Bank Transfer

  final List<PaymentScheduleItem> scheduleItems = [
    PaymentScheduleItem(
      id: 'ps1',
      milestone: 'Advance Payment (20%)',
      amount: 49000,
      dueDate: DateTime.now().add(const Duration(days: 2)),
      status: 'pending',
    ),
    PaymentScheduleItem(
      id: 'ps2',
      milestone: 'Delivery Payment (50%)',
      amount: 122500,
      dueDate: DateTime.now().add(const Duration(days: 14)),
      status: 'upcoming',
    ),
    PaymentScheduleItem(
      id: 'ps3',
      milestone: 'Final Payment (30%)',
      amount: 73500,
      dueDate: DateTime.now().add(const Duration(days: 30)),
      status: 'upcoming',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ds.EnerstoreColors.background,
      appBar: AppBar(
        title: const Text('Payment'),
        backgroundColor: ds.EnerstoreColors.surface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Info
            _buildOrderInfo(),
            const SizedBox(height: 24),

            // Payment Schedule
            Text(
              'Payment Schedule',
              style: ds.EnerstoreTypography.headlineMedium,
            ),
            const SizedBox(height: 16),
            ...scheduleItems.map((item) => PaymentScheduleCard(
                  item: item,
                  onPay: item.status == 'pending' ? () => _showPaymentDialog(item) : null,
                )),
            const SizedBox(height: 24),

            // Payment Methods
            Text(
              'Payment Method',
              style: ds.EnerstoreTypography.headlineMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            PaymentMethodSelector(
              selectedIndex: selectedPaymentMethod,
              onChanged: (index) {
                setState(() {
                  selectedPaymentMethod = index;
                });
              },
            ),
            const SizedBox(height: 24),

            // Payment Summary
            const PaymentSummary(),
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
              final pendingItems = scheduleItems.where((i) => i.status == 'pending');
              if (pendingItems.isNotEmpty) {
                _showPaymentDialog(pendingItems.first);
              }
            },
            icon: const Icon(Icons.payment),
            label: const Text('Pay Pending Amount'),
          ),
        ),
      ),
    );
  }

  Widget _buildOrderInfo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order #${widget.orderId}',
              style: ds.EnerstoreTypography.headlineMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Commercial Pro Package',
              style: ds.EnerstoreTypography.bodyMedium.copyWith(
                color: ds.EnerstoreColors.textSecondary,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Amount',
                  style: ds.EnerstoreTypography.bodyMedium,
                ),
                Text(
                  '₹${_getTotalAmount().toStringAsFixed(0)}',
                  style: ds.EnerstoreTypography.headlineMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: ds.EnerstoreColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Paid',
                  style: ds.EnerstoreTypography.bodyMedium,
                ),
                Text(
                  '₹0',
                  style: ds.EnerstoreTypography.bodyMedium.copyWith(
                    color: ds.EnerstoreColors.success,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  double _getTotalAmount() {
    return scheduleItems.fold(0, (sum, item) => sum + item.amount);
  }

  void _showPaymentDialog(PaymentScheduleItem item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Payment'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Milestone: ${item.milestone}'),
            const SizedBox(height: 8),
            Text('Amount: ₹${item.amount.toStringAsFixed(0)}'),
            const SizedBox(height: 16),
            const Text(
              'You will be redirected to Razorpay secure payment gateway.',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _processPayment(item);
            },
            child: const Text('Pay Now'),
          ),
        ],
      ),
    );
  }

  void _processPayment(PaymentScheduleItem item) {
    // TODO: Integrate with Razorpay SDK in Phase 3
    // For Phase 1, simulate payment success
    setState(() {
      scheduleItems.firstWhere((i) => i.id == item.id).status = 'paid';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Payment of ₹${item.amount.toStringAsFixed(0)} successful!'),
        backgroundColor: ds.EnerstoreColors.success,
      ),
    );
  }
}

// Model for payment schedule items
class PaymentScheduleItem {
  final String id;
  final String milestone;
  final double amount;
  final DateTime dueDate;
  String status; // pending, upcoming, paid

  PaymentScheduleItem({
    required this.id,
    required this.milestone,
    required this.amount,
    required this.dueDate,
    required this.status,
  });
}

class PaymentScheduleCard extends StatelessWidget {
  final PaymentScheduleItem item;
  final VoidCallback? onPay;

  const PaymentScheduleCard({
    super.key,
    required this.item,
    this.onPay,
  });

  @override
  Widget build(BuildContext context) {
    final isPaid = item.status == 'paid';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item.milestone,
                  style: ds.EnerstoreTypography.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(item.status),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    item.status.toUpperCase(),
                    style: ds.EnerstoreTypography.bodySmall.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Amount',
                  style: ds.EnerstoreTypography.bodyMedium.copyWith(
                    color: ds.EnerstoreColors.textSecondary,
                  ),
                ),
                Text(
                  '₹${item.amount.toStringAsFixed(0)}',
                  style: ds.EnerstoreTypography.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Due Date',
                  style: ds.EnerstoreTypography.bodyMedium.copyWith(
                    color: ds.EnerstoreColors.textSecondary,
                  ),
                ),
                Text(
                  _formatDate(item.dueDate),
                  style: ds.EnerstoreTypography.bodyMedium,
                ),
              ],
            ),
            if (!isPaid) ...[
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: onPay,
                  child: const Text('Pay Now'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'paid':
        return ds.EnerstoreColors.success;
      case 'pending':
        return ds.EnerstoreColors.warning;
      case 'upcoming':
        return ds.EnerstoreColors.info;
      default:
        return ds.EnerstoreColors.border;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

class PaymentMethodSelector extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const PaymentMethodSelector({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PaymentOption(
          icon: Icons.payment,
          title: 'Razorpay (UPI, Cards, Netbanking)',
          isSelected: selectedIndex == 0,
          onTap: () => onChanged(0),
        ),
        PaymentOption(
          icon: Icons.account_balance,
          title: 'Bank Transfer',
          isSelected: selectedIndex == 1,
          onTap: () => onChanged(1),
        ),
      ],
    );
  }
}

class PaymentOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentOption({
    super.key,
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? ds.EnerstoreColors.primary : ds.EnerstoreColors.border,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                icon,
                color: isSelected ? ds.EnerstoreColors.primary : ds.EnerstoreColors.textSecondary,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: ds.EnerstoreTypography.bodyMedium.copyWith(
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
              if (isSelected)
                const Icon(
                  Icons.check_circle,
                  color: ds.EnerstoreColors.primary,
                  size: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentSummary extends StatelessWidget {
  const PaymentSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ds.EnerstoreColors.info.withValues(alpha: 0.1),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment Summary',
              style: ds.EnerstoreTypography.headlineMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Amount', style: ds.EnerstoreTypography.bodyMedium),
                Text('₹72500', style: ds.EnerstoreTypography.bodyMedium),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Paid', style: ds.EnerstoreTypography.bodyMedium),
                Text('₹0', style: ds.EnerstoreTypography.bodyMedium.copyWith(
                  color: ds.EnerstoreColors.success,
                )),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Pending', style: ds.EnerstoreTypography.bodyMedium),
                Text('₹49000', style: ds.EnerstoreTypography.bodyMedium.copyWith(
                  color: ds.EnerstoreColors.warning,
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}