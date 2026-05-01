import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop/model/product_item.dart';
import 'package:shop/screens/products_detail_screen.dart';
import 'package:shop/widgets/product_card.dart'; // For number formatting

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Using the sample products directly
  final List<ProductItem> _products = sampleProducts
      .toList(); // Use .toList() to allow modification if needed

  // State for the shopping cart
  final List<ProductItem> _cartItems = [];

  // Formats price for display (e.g., "$1,234,567")
  String _formatPrice(double price) {
    final formatter = NumberFormat(
      '#,##0',
      'en_US',
    ); // Using en_US for US-style commas
    return '\$${formatter.format(price)}'; // Using $ as currency symbol
  }

  // Function to handle adding items to the cart
  void _handleAddToCart(ProductItem product) {
    // In a real app, you'd manage quantity here or in a separate cart state.
    // For this example, we'll just add the product once.
    setState(() {
      _cartItems.add(product);
    });
    print('Added ${product.name} to cart. Cart items: ${_cartItems.length}');
  }

  // Navigate to product detail page
  Future<void> _navigateToProductDetail(ProductItem product) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => ProductDetailScreen(
          product: product,
          onAddToCart: _handleAddToCart, // Pass the handler
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor, // White background
      appBar: AppBar(
        title: const Text('TechLand'),
        backgroundColor: Colors.white,
        foregroundColor: const Color.fromARGB(255, 40, 152, 208),
        elevation: 0,
        centerTitle: true,
        actions: [
          // Cart Icon Button
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            tooltip: 'View Cart',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Cart functionality not fully implemented yet!',
                  ),
                  duration: Duration(seconds: 1),
                ),
              );
              print('Cart tapped. Items in cart: ${_cartItems.length}');
            },
          ),
          const SizedBox(width: 10), // Spacing
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: _products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 columns
            crossAxisSpacing: 12.0, // Horizontal spacing
            mainAxisSpacing: 12.0, // Vertical spacing
            childAspectRatio: 0.50, // Aspect ratio for cards (width/height)
          ),
          itemBuilder: (context, index) {
            final product = _products[index];
            return GestureDetector(
              onTap: () => _navigateToProductDetail(product), // Navigate on tap
              child: ProductCard(product: product),
            );
          },
        ),
      ),
    );
  }
}
