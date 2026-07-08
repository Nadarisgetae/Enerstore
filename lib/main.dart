import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:energore_customer/core/theme/theme.dart';
import 'package:energore_customer/features/auth/presentation/screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: EnerstoreCustomerApp()));
}

class EnerstoreCustomerApp extends ConsumerWidget {
  const EnerstoreCustomerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Enerstore',
      debugShowCheckedModeBanner: false,
      theme: EnerstoreTheme.light,
      home: const SplashScreen(),
    );
  }
}