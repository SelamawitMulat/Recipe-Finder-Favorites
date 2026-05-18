import 'package:flutter/material.dart';

class FavoriteButton extends StatelessWidget {
  final bool isFav;
  final VoidCallback onTap;

  const FavoriteButton({super.key, required this.isFav, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(isFav ? Icons.favorite : Icons.favorite_border,
          color: isFav ? Colors.red : Colors.white),
      onPressed: onTap,
    );
  }
}
