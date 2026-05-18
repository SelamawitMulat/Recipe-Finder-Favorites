import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final Color backgroundColor;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.backgroundColor = Colors.orange,
  });

  @override
  Widget build(BuildContext context) {
    final labelWidget = Text(label,
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold));

    return SizedBox(
      width: double.infinity,
      child: icon != null
          ? ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  backgroundColor: backgroundColor,
                  padding: const EdgeInsets.symmetric(vertical: 12)),
              icon: Icon(icon, color: Colors.black),
              label: labelWidget,
              onPressed: onPressed,
            )
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: backgroundColor,
                  padding: const EdgeInsets.symmetric(vertical: 12)),
              onPressed: onPressed,
              child: labelWidget,
            ),
    );
  }
}
