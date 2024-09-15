import 'package:angkas_app_clone/app_colors.dart';
import 'package:flutter/material.dart';

class LocationSelectionView extends StatelessWidget {
  final String title;
  final String address;
  final VoidCallback? onTap;

  const LocationSelectionView({super.key, required this.title, required this.address, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            Text(
              address,
              style: TextStyle(color: AppColor.textColor),
            ),
          ],
        ),
      ),
    );
  }
}
