import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/provider/cart_provider.dart';


class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  final _pinController = TextEditingController();

  bool _isProcessing = false;

  void _pay() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isProcessing = true);

    // fake confirmation of pay
    await Future.delayed(Duration(seconds: 2));

    setState(() => _isProcessing = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Thanks for Choosing us')),
    );
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final total = context.watch<CartProvider>().totalPrice;
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Payment ', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          _buildBackground(),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: _buildPaymentForm(total),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurple, Colors.blueAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }

  Widget _buildPaymentForm(double total) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
        //backdropFilter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${total.toStringAsFixed(0)} Toman',
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold,color: Colors.white),
          ),
          const SizedBox(height: 20),
          // pay forms
          Form(
            key: _formKey,
            child: Column(
              children: [
                _buildTextField(
                  controller: _cardNumberController,
                  label: 'Card number',
                  hint: '1234 4567 7890 8907',
                  icon: Icons.credit_card,
                  validator: (val) {
                    if (val == null || val.isEmpty) return 'Enter your card number';
                    if (val.replaceAll(' ', '').length != 16) return '16 digits ';
                    return null;
                  },
                ),
                const SizedBox(height: 15),

                _buildTextField(
                  controller: _expiryController,
                  label: 'Expire Date',
                  hint: 'ex: 12/5',
                  icon: Icons.date_range,
                  validator: (val) {
                    if (val == null || val.isEmpty) return 'Enter your expirement date';
                    if (!RegExp(r'^(0[1-9]|1[0-2])\/\d{2}$').hasMatch(val))
                      return 'Correct Form month year: 12/25';
                    return null;
                  },
                ),
                const SizedBox(height: 15),

                _buildTextField(
                  controller: _cvvController,
                  label: 'CVV',
                  hint: ' 123',
                  icon: Icons.lock,
                  validator: (val) {
                    if (val == null || val.isEmpty) return 'entering Cvv is neccessry';
                    if (val.length != 3) return 'At least 3 digits';
                    return null;
                  },
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 15),

                _buildTextField(
                  controller: _pinController,
                  label: 'Ramz Poya',
                  hint: '6 digits code',
                  icon: Icons.security,
                  validator: (val) {
                    if (val == null || val.isEmpty) return 'Enter your Ramz poya';
                    if (val.length != 6) return '6 digits';
                    return null;
                  },
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 30),

                ElevatedButton(
                  onPressed: _isProcessing ? null : _pay,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.deepPurple,
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: _isProcessing
                      ? CircularProgressIndicator(color: Colors.deepPurple)
                      : Text(
                          'Pay',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        hintStyle: TextStyle(color: Colors.white54),
        labelStyle: TextStyle(color: Colors.white70),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
