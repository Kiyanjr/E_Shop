import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/model/product_item.dart';
import 'package:intl/intl.dart';
import 'package:shop/provider/cart_provider.dart';
import 'package:shop/view/basket_screen.dart'; // formatting numbers

class ProductDetailScreen extends StatefulWidget {
  final ProductItem product;
  final Function(ProductItem) onAddToCart; // Callback function

  const ProductDetailScreen({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1; // Default quantity

  // Formats price for display (e.g., "$1,234,567")
  String _formatPrice(double price) {
    final formatter = NumberFormat('#,##0', 'en_US'); // Using en_US for US-style commas
    return '\$${formatter.format(price)}'; // Using $ as currency symbol
  }

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(widget.product.name),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF37474F),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.asset(
                    widget.product.imagePath, // Use the single image path
                    width: screenSize.width * 0.8,
                    height: screenSize.height * 0.35,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Product Title
              Text(
                widget.product.name,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF37474F),
                ),
              ),
              const SizedBox(height: 8),

              // Price Display
              Text(
                _formatPrice(widget.product.price),
                style: theme.textTheme.titleLarge?.copyWith(
                  color: const Color(0xFF00ACC1), // Teal color for price
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),

              // Quantity Selector
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Quantity:',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: const Color(0xFF37474F),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFECEFF1), // Light grey background
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove, size: 20),
                          color: const Color(0xFF37474F),
                          onPressed: _decrementQuantity,
                          padding: EdgeInsets.zero,
                        ),
                        const SizedBox(width: 16),
                        Text(
                          '$_quantity',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF37474F),
                          ),
                        ),
                        const SizedBox(width: 16),
                        IconButton(
                          icon: const Icon(Icons.add, size: 20),
                          color: const Color(0xFF37474F),
                          onPressed: _incrementQuantity,
                          padding: EdgeInsets.zero,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Product Description
              Text(
                'Description:',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF37474F),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.product.description,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: const Color.fromARGB(255, 37, 95, 124).withOpacity(0.8),
                  height: 1.5, // Line spacing
                ),
              ),
              const SizedBox(height: 32),

              // Add to Cart Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.shopping_cart_outlined),
                  label: const Text('Add to Cart'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00ACC1), // Teal color
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    final cartItem = widget.product.copyWith(numbersOfProduct: 1); // No quantity needed in the product itself for this example
                       context.read<CartProvider>().adddToCart(cartItem);

                    // Show a confirmation snackbar
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${widget.product.name} added to cart!'),
                        duration: const Duration(seconds: 2),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.push(context, MaterialPageRoute(builder: (context) => BasketScreen(),));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
