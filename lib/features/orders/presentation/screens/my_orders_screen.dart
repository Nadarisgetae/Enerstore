import 'package:flutter/material.dart';
import 'package:energore_design_system/energore_design_system.dart' as ds;
import '../../../home/data/mock_data.dart';

/// My Orders screen showing all quote requests and their statuses.
class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: ds.EnerstoreColors.background,
        appBar: AppBar(
          title: const Text('My Requests & Orders'),
          backgroundColor: ds.EnerstoreColors.surface,
          elevation: 0,
          bottom: TabBar(
            labelColor: ds.EnerstoreColors.primary,
            unselectedLabelColor: ds.EnerstoreColors.textSecondary,
            indicatorColor: ds.EnerstoreColors.primary,
            tabs: const [
              Tab(text: 'All'),
              Tab(text: 'Quotes'),
              Tab(text: 'Quotations'),
              Tab(text: 'Active'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildOrdersList(MockOrder.sampleOrders),
            _buildOrdersList(MockOrder.sampleOrders.where((o) => o.status != 'Completed').toList()),
            _buildQuotationsTab(),
            _buildOrdersList(MockOrder.sampleOrders.where((o) => o.status != 'Completed').toList()),
          ],
        ),
      ),
    );
  }

  Widget _buildOrdersList(List<MockOrder> orders) {
    if (orders.isEmpty) {
      return Center(
        child: Text(
          'No orders yet',
          style: ds.EnerstoreTypography.bodyLarge?.copyWith(
            color: ds.EnerstoreColors.textSecondary,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return _OrderListItem(
          order: order,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => OrderTrackingScreen(orderId: order.id),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildQuotationsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Received Quotations',
            style: ds.EnerstoreTypography.headlineMedium,
          ),
          const SizedBox(height: 16),
          ...MockQuotation.sampleQuotations.map((quotation) => _QuotationCard(
                quotation: quotation,
                onTap: () {},
              )),
        ],
      ),
    );
  }
}

class _OrderListItem extends StatelessWidget {
  final MockOrder order;
  final VoidCallback onTap;

  const _OrderListItem({required this.order, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        onTap: onTap,
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

class _QuotationCard extends StatelessWidget {
  final MockQuotation quotation;
  final VoidCallback onTap;

  const _QuotationCard({required this.quotation, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    quotation.providerName,
                    style: ds.EnerstoreTypography.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '₹${quotation.price.toStringAsFixed(0)}',
                    style: ds.EnerstoreTypography.titleMedium?.copyWith(
                      color: ds.EnerstoreColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                quotation.terms,
                style: ds.EnerstoreTypography.bodySmall?.copyWith(
                  color: ds.EnerstoreColors.textSecondary,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: ds.EnerstoreColors.info.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      quotation.validity,
                      style: ds.EnerstoreTypography.bodySmall,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Proceed'),
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

/// Order tracking screen with live timeline view.
class OrderTrackingScreen extends StatelessWidget {
  final String orderId;

  const OrderTrackingScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    final order = MockOrder.sampleOrders.firstWhere(
      (o) => o.id == orderId,
      orElse: () => MockOrder.sampleOrders.first,
    );

    return Scaffold(
      backgroundColor: ds.EnerstoreColors.background,
      appBar: AppBar(
        title: Text('Order #${order.id}'),
        backgroundColor: ds.EnerstoreColors.surface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Header
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
                    Text(
                      order.status,
                      style: ds.EnerstoreTypography.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Timeline
            Text(
              'Order Timeline',
              style: ds.EnerstoreTypography.headlineMedium,
            ),
            const SizedBox(height: 16),
            _TimelineItem(
              icon: Icons.request_quote,
              title: 'Quote Request Sent',
              subtitle: 'Waiting for provider responses',
              date: 'Jul 5, 2026',
              isCompleted: true,
              isLast: false,
            ),
            _TimelineItem(
              icon: Icons.done,
              title: 'Quotation Received',
              subtitle: '2 quotations received from providers',
              date: 'Jul 6, 2026',
              isCompleted: true,
              isLast: false,
            ),
            _TimelineItem(
              icon: Icons.chat,
              title: 'Sales Discussion',
              subtitle: 'In progress',
              date: 'Pending',
              isCompleted: false,
              isLast: false,
            ),
            _TimelineItem(
              icon: Icons.description,
              title: 'Plan Creation',
              subtitle: 'Payment & delivery schedule',
              date: 'Pending',
              isCompleted: false,
              isLast: false,
            ),
            _TimelineItem(
              icon: Icons.delivery_dining,
              title: 'Delivery',
              subtitle: 'Items dispatched',
              date: 'Pending',
              isCompleted: false,
              isLast: false,
            ),
            _TimelineItem(
              icon: Icons.build,
              title: 'Installation',
              subtitle: 'Installation scheduled',
              date: 'Pending',
              isCompleted: false,
              isLast: true,
            ),
            const SizedBox(height: 24),

            // Quotation comparison
            if (order.status.contains('Received')) _buildQuotationCompare(),
          ],
        ),
      ),
    );
  }

  Widget _buildQuotationCompare() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Received Quotations',
          style: ds.EnerstoreTypography.headlineMedium,
        ),
        const SizedBox(height: 16),
        ...MockQuotation.sampleQuotations.map((quotation) => _QuotationCard(
              quotation: quotation,
              onTap: () {},
            )),
      ],
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String date;
  final bool isCompleted;
  final bool isLast;

  const _TimelineItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.isCompleted,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final lineColor = isCompleted ? ds.EnerstoreColors.success : ds.EnerstoreColors.border;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isCompleted
                    ? ds.EnerstoreColors.success
                    : ds.EnerstoreColors.border.withValues(alpha: 0.3),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: lineColor,
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: ds.EnerstoreTypography.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: ds.EnerstoreTypography.bodySmall?.copyWith(
                    color: ds.EnerstoreColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: ds.EnerstoreTypography.bodySmall?.copyWith(
                    color: ds.EnerstoreColors.textSecondary,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}