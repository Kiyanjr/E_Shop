import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/provider/user_provider.dart';
import 'package:shop/view_model/glassinput.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _GlowCircle extends StatelessWidget {
  final Color color;
  final double size;

  const _GlowCircle({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(0.22),
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  final Widget child;

  const _HeaderCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.06),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.white.withOpacity(0.10)),
          ),
          child: child,
        ),
      ),
    );
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;

  bool _isEditing = false;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
    _emailController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      if (userProvider.username.isEmpty && userProvider.useremail.isEmpty) {
        await userProvider.loadUser();
      }

      // fillinf inputs with entred data before
      _nameController.text = userProvider.username;
      _emailController.text = userProvider.useremail;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _enterEditingMode() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    setState(() {
      _isEditing = true;
      _nameController.text = userProvider.username;
      _emailController.text = userProvider.useremail;
    });
  }

  Future<void> _saveProfile() async {
    if (!_isEditing) return;

    final form = _formKey.currentState;
    if (form == null) return;
    if (!form.validate()) return;

    setState(() => _isProcessing = true);

    final newName = _nameController.text.trim();
    final newEmail = _emailController.text.trim();

    await Provider.of<UserProvider>(
      context,
      listen: false,
    ).setUser(newName, newEmail);

    if (!mounted) return;

    setState(() {
      _isProcessing = false;
      _isEditing = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('new Changes have been added.✅')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    const padding = EdgeInsets.symmetric(horizontal: 20, vertical: 16);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 70, 101, 204),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _isProcessing
                ? null
                : () async {
                    setState(() => _isProcessing = true);

                    await Provider.of<UserProvider>(
                      context,
                      listen: false,
                    ).logout();

                    if (!mounted) return;

                    setState(() => _isProcessing = false);

                    Navigator.of(context).pop(); 
                  },
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            top: -120,
            left: -120,
            child: const _GlowCircle(color: Colors.purpleAccent, size: 280),
          ),
          Positioned(
            top: 60,
            right: -140,
            child: const _GlowCircle(color: Colors.blueAccent, size: 320),
          ),
          Positioned(
            bottom: -160,
            left: 80,
            child: const _GlowCircle(color: Colors.tealAccent, size: 260),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 10, bottom: 24),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 8),

                      _HeaderCard(
                        child: Column(
                          children: [
                            const SizedBox(height: 12),
                            CircleAvatar(
                              radius: 42,
                              backgroundColor: Colors.white.withOpacity(0.12),
                              child: const Icon(
                                Icons.person,
                                size: 44,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              userProvider.username.isNotEmpty
                                  ? userProvider.username
                                  : 'Guest',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              userProvider.username.isNotEmpty
                                  ? 'Your Profile'
                                  : 'Sing up please',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      ClipRRect(
                        borderRadius: BorderRadius.circular(22),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                          child: Container(
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.06),
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.10),
                              ),
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  GlassInput(
                                    controller: _nameController,
                                    label: 'name',
                                    hint: _isEditing
                                        ? 'Type ur new Name'
                                        : 'Name',
                                    icon: Icons.badge_outlined,
                                    readOnly: !_isEditing,
                                    validator: (v) {
                                      if (!_isEditing) return null;
                                      final value = v?.trim() ?? '';
                                      if (value.isEmpty)
                                        return 'enter the name';
                                      if (value.length < 3)
                                        return 'At least Three characters';
                                      return null;
                                    },
                                  ),

                                  const SizedBox(height: 12),

                                  GlassInput(
                                    controller: _emailController,
                                    label: 'email',
                                    hint: _isEditing
                                        ? 'New Email'
                                        : 'Your Email',
                                    icon: Icons.email_outlined,
                                    keyboardType: TextInputType.emailAddress,
                                    readOnly: !_isEditing,
                                    validator: (v) {
                                      if (!_isEditing) return null;
                                      final value = v?.trim() ?? '';
                                      if (value.isEmpty)
                                        return 'enter ypur email';
                                      final ok = RegExp(
                                        r'^[^@]+@[^@]+\.[^@]+$',
                                      ).hasMatch(value);
                                      if (!ok)
                                        return 'Email format isnt correct';
                                      return null;
                                    },
                                  ),

                                  const SizedBox(height: 18),

                                  SizedBox(
                                    height: 48,
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: _isProcessing
                                          ? null
                                          : (_isEditing
                                                ? _saveProfile
                                                : _enterEditingMode),
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        backgroundColor: _isEditing
                                            ? Colors.white
                                            : Colors.transparent,
                                        foregroundColor: _isEditing
                                            ? const Color(0xFF0B1020)
                                            : Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          side: _isEditing
                                              ? BorderSide.none
                                              : const BorderSide(
                                                  color: Colors.white54,
                                                ),
                                        ),
                                      ),
                                      child: _isProcessing
                                          ? const SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                              ),
                                            )
                                          : Text(
                                              _isEditing
                                                  ? 'Saving changes'
                                                  : 'Editing infos',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: TextButton(
                          onPressed: _isProcessing
                              ? null
                              : () async {
                                  await Provider.of<UserProvider>(
                                    context,
                                    listen: false,
                                  ).logout();
                                  if (!mounted) return;

                                  setState(() {
                                    _isEditing = false;
                                    _nameController.text = '';
                                    _emailController.text = '';
                                  });

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Logged out')),
                                  );
                                },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.redAccent,
                            side: const BorderSide(color: Colors.redAccent),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Deleting your account'),
                        ),
                      ),

                      const Center(
                        child: Text(
                          'Your data are Save with us✨',
                          style: TextStyle(color: Colors.white54, fontSize: 12),
                        ),
                      ),

                      const SizedBox(height: 6),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
