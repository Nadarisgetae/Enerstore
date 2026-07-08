import 'package:flutter/material.dart';
import 'package:energore_customer/features/auth/presentation/screens/what_do_you_need_screen.dart';
import 'package:energore_design_system/energore_design_system.dart' as ds;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        // TODO: Check if user is logged in, navigate accordingly
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const WhatDoYouNeedScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ds.EnerstoreColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.solar_power,
              size: 80,
              color: Colors.white,
            ),
            const SizedBox(height: 24),
            Text(
              'ENERSTORE',
              style: ds.EnerstoreTypography.headlineLarge.copyWith(
                color: Colors.white,
                fontSize: 32,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'B2B Solar Marketplace',
              style: ds.EnerstoreTypography.bodyMedium.copyWith(
                color: Colors.white.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
