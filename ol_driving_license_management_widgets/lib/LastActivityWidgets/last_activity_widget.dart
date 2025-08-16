import 'package:flutter/material.dart';

class WDRecentActivitiesList extends StatelessWidget {
  final List<Widget> activityCards;

  const WDRecentActivitiesList({super.key, required this.activityCards});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // عشان ياخد المساحة الباقية تحت الكارت
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: activityCards.length,
        itemBuilder: (context, index) => activityCards[index],
      ),
    );
  }
}
