import 'package:flutter/material.dart';

class SkeletonCard extends StatelessWidget {
  const SkeletonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        height: 240,
        padding: const EdgeInsets.all(12.0),
        color: Colors.grey[900],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                color: Colors.white12,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              height: 20,
              width: 150,
              color: Colors.white12,
            ),
            const SizedBox(height: 8),
            Container(
              height: 14,
              width: 80,
              color: Colors.white12,
            ),
          ],
        ),
      ),
    );
  }
}
