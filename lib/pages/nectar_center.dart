import 'package:flutter/material.dart';

class NectarCenter extends StatelessWidget {
  const NectarCenter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nectar Center'),
      ),
      body: const Center(
        child: Text('Nectar Center Page'),
      ),
    );
  }
}
