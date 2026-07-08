import 'package:flutter/material.dart';
import 'package:energore_design_system/energore_design_system.dart' as ds;

/// Profile & Settings screen for editing user details.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'John Doe');
  final _emailController = TextEditingController(text: 'john.doe@example.com');
  final _phoneController = TextEditingController(text: '+91 98765 43210');
  final _companyController = TextEditingController(text: 'ABC Enterprises');

  bool _notificationsEnabled = true;
  bool _marketingEnabled = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _companyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ds.EnerstoreColors.background,
      appBar: AppBar(
        title: const Text('Profile & Settings'),
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
              // Profile Header
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ds.EnerstoreColors.primary.withValues(alpha: 0.2),
                      ),
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: ds.EnerstoreColors.primary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'John Doe',
                      style: ds.EnerstoreTypography.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'john.doe@example.com',
                      style: ds.EnerstoreTypography.bodyMedium?.copyWith(
                        color: ds.EnerstoreColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Personal Information
              Text(
                'Personal Information',
                style: ds.EnerstoreTypography.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(),
                ),
                enabled: false,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone_outlined),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _companyController,
                decoration: const InputDecoration(
                  labelText: 'Company Name',
                  prefixIcon: Icon(Icons.business_outlined),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),

              // Saved Addresses
              Text(
                'Saved Addresses',
                style: ds.EnerstoreTypography.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.location_on_outlined),
                  title: const Text('Add New Address'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // TODO: Add address feature
                  },
                ),
              ),
              const SizedBox(height: 24),

              // Notification Preferences
              Text(
                'Notification Preferences',
                style: ds.EnerstoreTypography.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: Column(
                  children: [
                    SwitchListTile(
                      title: const Text('Order Updates'),
                      subtitle: const Text('Receive status updates for your orders'),
                      value: _notificationsEnabled,
                      onChanged: (value) {
                        setState(() {
                          _notificationsEnabled = value;
                        });
                      },
                      activeColor: ds.EnerstoreColors.primary,
                    ),
                    SwitchListTile(
                      title: const Text('Marketing Communications'),
                      subtitle: const Text('Promotions and product updates'),
                      value: _marketingEnabled,
                      onChanged: (value) {
                        setState(() {
                          _marketingEnabled = value;
                        });
                      },
                      activeColor: ds.EnerstoreColors.primary,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Action Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Profile updated')),
                      );
                    }
                  },
                  child: const Text('Save Changes'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    // TODO: Connect to logout
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Logged out')),
                    );
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Logout'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: ds.EnerstoreColors.error,
                    side: BorderSide(color: ds.EnerstoreColors.error),
                  ),
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}

/// Notifications screen showing in-app notification center.
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  static final List<MockNotification> _notifications = [
    MockNotification(
      id: '1',
      title: 'Quotation Received',
      message: 'SolarTech Industries sent you a quotation for your request',
      time: '2 hours ago',
      type: 'quotation',
      isRead: false,
    ),
    MockNotification(
      id: '2',
      title: 'Order Update',
      message: 'Your order ORD-001 is now in progress',
      time: '1 day ago',
      type: 'order',
      isRead: false,
    ),
    MockNotification(
      id: '3',
      title: 'Payment Due',
      message: 'Payment milestone #2 is due tomorrow',
      time: '2 days ago',
      type: 'payment',
      isRead: true,
    ),
    MockNotification(
      id: '4',
      title: 'Delivery Scheduled',
      message: 'Your installation is scheduled for tomorrow 10:00 AM',
      time: '3 days ago',
      type: 'delivery',
      isRead: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ds.EnerstoreColors.background,
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: ds.EnerstoreColors.surface,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              // TODO: Mark all as read
            },
            child: const Text('Mark All Read'),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final notification = _notifications[index];
          return _NotificationCard(notification: notification);
        },
      ),
    );
  }
}

class MockNotification {
  final String id;
  final String title;
  final String message;
  final String time;
  final String type;
  final bool isRead;

  MockNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    required this.type,
    required this.isRead,
  });
}

class _NotificationCard extends StatelessWidget {
  final MockNotification notification;

  const _NotificationCard({required this.notification});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: notification.isRead
          ? ds.EnerstoreColors.surface
          : ds.EnerstoreColors.primary.withValues(alpha: 0.05),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: _getNotificationColor(notification.type).withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(
            _getNotificationIcon(notification.type),
            color: _getNotificationColor(notification.type),
            size: 20,
          ),
        ),
        title: Text(
          notification.title,
          style: ds.EnerstoreTypography.bodyMedium?.copyWith(
            fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notification.message,
              style: ds.EnerstoreTypography.bodySmall?.copyWith(
                color: ds.EnerstoreColors.textSecondary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              notification.time,
              style: ds.EnerstoreTypography.bodySmall?.copyWith(
                color: ds.EnerstoreColors.textSecondary,
                fontSize: 10,
              ),
            ),
          ],
        ),
        trailing: notification.isRead
            ? null
            : Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: ds.EnerstoreColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
      ),
    );
  }

  IconData _getNotificationIcon(String type) {
    switch (type) {
      case 'quotation':
        return Icons.request_quote;
      case 'order':
        return Icons.receipt_long;
      case 'payment':
        return Icons.payment;
      case 'delivery':
        return Icons.delivery_dining;
      default:
        return Icons.notifications;
    }
  }

  Color _getNotificationColor(String type) {
    switch (type) {
      case 'quotation':
        return ds.EnerstoreColors.success;
      case 'order':
        return ds.EnerstoreColors.info;
      case 'payment':
        return ds.EnerstoreColors.warning;
      case 'delivery':
        return ds.EnerstoreColors.secondary;
      default:
        return ds.EnerstoreColors.primary;
    }
  }
}