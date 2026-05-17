import 'package:flutter/material.dart';

/// Small / Medium / Large with short gaps between chips.
class CoffeeSizeChips extends StatelessWidget {
  const CoffeeSizeChips({
    super.key,
    required this.selectedSize,
    required this.onSizeSelected,
  });

  final String selectedSize;
  final ValueChanged<String> onSizeSelected;

  static const List<String> sizes = ['Small', 'Medium', 'Large'];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < sizes.length; i++) ...[
          if (i > 0) const SizedBox(width: 6),
          _chip(sizes[i]),
        ],
      ],
    );
  }

  Widget _chip(String size) {
    final selected = selectedSize == size;
    return GestureDetector(
      onTap: () => onSizeSelected(size),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: selected ? Colors.brown : Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          size,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: selected ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}

/// Narrower, shorter add-to-cart control for detail screens.
class CompactAddToCartBar extends StatelessWidget {
  const CompactAddToCartBar({
    super.key,
    required this.priceText,
    required this.onTap,
  });

  final String priceText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
      child: Material(
        color: Colors.brown,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            height: 36,
            width: double.infinity,
            child: Center(
              child: Text(
                'Add to Cart | $priceText',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
