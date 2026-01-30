import 'dart:ui';
import 'package:flutter/material.dart';

class SecondaryNavBar extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onHome;
  final VoidCallback onHives;

  const SecondaryNavBar({
    super.key,
    required this.onBack,
    required this.onHome,
    required this.onHives,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: Color(0xFFF3A31A),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, size: 28, color: Colors.black),
            onPressed: onBack,
          ),
          IconButton(
            icon: const Icon(Icons.home_outlined, size: 28, color: Colors.black),
            onPressed: onHome,
          ),
          IconButton(
            icon: const Icon(Icons.groups_outlined, size: 28, color: Colors.black,),
            onPressed: onHives,
          ),
        ],
      ),
    );
  }
}