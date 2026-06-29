import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop/model/product_item.dart';
import 'package:shop/screens/about_screen.dart';
import 'package:shop/screens/basket_screen.dart';
import 'package:shop/screens/products_detail_screen.dart';
import 'package:shop/screens/profile_screen.dart';
import 'package:shop/widgets/product_card.dart';
 

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
      // final userName = Provider.of<UserProvider>(context).username;
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor, // White background
      appBar: AppBar(
        title: Row(
          children: [
           const Text('TechLand')
          ],
        ),
        backgroundColor: Colors.white,
        foregroundColor: const Color.fromARGB(255, 40, 152, 208),
        elevation: 0,
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.menu_rounded),
            onSelected: (value) {
              if (value == 'about') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AboutScreen()),
                );
              }

              if (value == 'payment') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BasketScreen(),
                  ),
                );
              }
              if(value=='profile'){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()),);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem<String>(
                value: 'about',
                child: Row(
                  children: [
                    Icon(Icons.account_box_outlined, color: Colors.blueAccent),
                    SizedBox(width: 8),
                    Text('About'),
                  ],
                ),
              ),

              const PopupMenuItem<String>(
                value: 'payment',
                child: Row(
                  children: [
                    Icon(Icons.shopify_sharp, color: Colors.blueAccent),
                    SizedBox(width: 8),
                    Text('Payment'),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'profile',
                child: Row(
                  children: [
                    Icon(Icons.person,color: Colors.blueAccent,),
                    SizedBox(width: 8,),
                    Text('Profile')
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(width: 10), // فاصله بعد
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
