import 'package:angkas_app_clone/app_colors.dart';
import 'package:flutter/material.dart';

class ActionSelectionView extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback? onTap;

  const ActionSelectionView({super.key, required this.title, required this.image, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Image(width: 24, image: AssetImage(image)),
            Text(title),
          ],
        ),
      ),
    );
  }
}
