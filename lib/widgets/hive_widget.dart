import 'package:flutter/material.dart';
import 'package:flutter_app/pages/Hives_Pages/specific_hive.dart';
import 'package:get/get.dart';
import 'package:flutter_app/pages/Nectar_Center_Pages/nectar_center.dart';

class HiveWidget extends StatefulWidget {
  final Color hiveColor;
  final Icon hiveIcon;
  final String hiveName;
  final SpecificHive hivePage;
  final VoidCallback? onTap;
  const HiveWidget({required this.hiveColor, required this.hiveIcon, required this.hiveName, required this.hivePage, this.onTap, super.key});

  @override
  State<HiveWidget> createState() => _HiveWidgetState();
}

class _HiveWidgetState extends State<HiveWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!();
        } else {
          Get.to(() => widget.hivePage);
        }
      },
      child: Container(
        width: 250.0,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: widget.hiveColor,
            width: 2.0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(widget.hiveIcon.icon, color: widget.hiveColor, size: 30),
            const SizedBox(width: 10),
            Text(
              widget.hiveName,
              style: TextStyle(
                color: widget.hiveColor,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
