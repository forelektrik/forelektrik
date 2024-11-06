// lib/presentation/pages/home/home_page.dart

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('For Elektrik'),
      ),
      body: const Center(
        child: Text('Ana Sayfa'),
      ),
    );
  }
}
