import 'package:flutter/material.dart';
import 'package:energore_design_system/energore_design_system.dart' as ds;

/// Chat screen for contacting sales team after selecting a quotation.
class ChatScreen extends StatefulWidget {
  final String? providerName;

  const ChatScreen({
    super.key,
    this.providerName,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageController = TextEditingController();
  final List<ChatMessage> _messages = [
    ChatMessage(
      text: 'Hello! I\'m Sarah from Enercore Sales. I see you accepted a quotation from ${'widget.providerName' ?? 'a provider'}. How can I help you?',
      isFromCustomer: false,
      time: '10:00 AM',
    ),
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ds.EnerstoreColors.background,
      appBar: AppBar(
        title: Text(widget.providerName ?? 'Sales Team'),
        backgroundColor: ds.EnerstoreColors.surface,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.call_outlined),
            onPressed: () {
              // TODO: Implement call functionality
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _ChatBubble(message: message);
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      color: ds.EnerstoreColors.surface,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                hintStyle: ds.EnerstoreTypography.bodyMedium?.copyWith(
                  color: ds.EnerstoreColors.textSecondary,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: ds.EnerstoreColors.border),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            onPressed: _sendMessage,
            mini: true,
            backgroundColor: ds.EnerstoreColors.primary,
            child: const Icon(
              Icons.send,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add(
        ChatMessage(
          text: _messageController.text.trim(),
          isFromCustomer: true,
          time: '${TimeOfDay.now().hour}:${TimeOfDay.now().minute.toString().padLeft(2, '0')}',
        ),
      );
    });

    _messageController.clear();

    // Simulate response
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _messages.add(
            ChatMessage(
              text: 'Thanks for your message! Our sales consultant will review and get back to you shortly.',
              isFromCustomer: false,
              time: '${TimeOfDay.now().hour}:${TimeOfDay.now().minute.toString().padLeft(2, '0')}',
            ),
          );
        });
      }
    });
  }
}

class ChatMessage {
  final String text;
  final bool isFromCustomer;
  final String time;

  ChatMessage({
    required this.text,
    required this.isFromCustomer,
    required this.time,
  });
}

class _ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const _ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment:
            message.isFromCustomer ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isFromCustomer)
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: ds.EnerstoreColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.support_agent,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          if (!message.isFromCustomer) const SizedBox(width: 8),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: message.isFromCustomer
                    ? ds.EnerstoreColors.primary
                    : ds.EnerstoreColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: message.isFromCustomer
                    ? null
                    : Border.all(color: ds.EnerstoreColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: ds.EnerstoreTypography.bodyMedium?.copyWith(
                      color: message.isFromCustomer
                          ? Colors.white
                          : ds.EnerstoreColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message.time,
                    style: ds.EnerstoreTypography.bodySmall?.copyWith(
                      color: message.isFromCustomer
                          ? Colors.white.withValues(alpha: 0.7)
                          : ds.EnerstoreColors.textSecondary,
                      fontSize: 10,
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
}