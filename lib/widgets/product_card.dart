import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop/model/product_item.dart'; // For number formatting

class ProductCard extends StatelessWidget {
  final ProductItem product;
  final VoidCallback? onAddToCart; // Optional callback for add to cart action

  const ProductCard({
    super.key,
    required this.product,
    this.onAddToCart, 
  });

  // Formats price for display
  String _formatPrice(double price) {
    final formatter = NumberFormat(
      '#,##0',
      'en_US',
    ); // Use en_US for US-style commas
    return '\$${formatter.format(price)}'; // Use $ as currency symbol
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 5, // shadow on backgorund
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Expanded(
            flex: 3, // Image takes more space
            child: Image.asset(
              product.imagePath,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          // Product Details
          Expanded(
            flex: 2, // Details take less space
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween, // Use spaceBetween
                children: [
                  // Product Name
                  Text(
                    product.name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF37474F),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),

                  // Price
                  Text(
                    _formatPrice(product.price),
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: const Color(0xFF00ACC1), // Teal color
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),

                  // Product ID (optional, can be removed if not needed on card)
                  Text(
                    'ID: ${product.id}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: const Color.fromARGB(255, 37, 99, 169),
                    ),
                  ),

                  // Spacer to push button to bottom
                  const Spacer(),

                  // Add to Cart Button
                  Align(
                    alignment:
                        Alignment.bottomRight, // Align button to the right
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.add_shopping_cart, size: 18),
                      label: const Text('Add'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 3, 75, 85), // Teal
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: onAddToCart != null
                          ? () =>
                                onAddToCart!() // Call the callback if provided
                          : null, // Disable button if no callback
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
