import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Container(
        width: double.infinity,
        // background light modern
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE0F7FA), // light smooلth blue
              Colors.white,
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 26),
            child: _AboutCard(theme: theme),
          ),
        ),
      ),
    );
  }
}

class _AboutCard extends StatelessWidget {
  const _AboutCard({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      color: Colors.white.withOpacity(0.96),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Card HEADER
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0F7FA),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    Icons.info_outline,
                    color: const Color(0xFF00ACC1),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    'About Me',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF37474F),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            // main text
            Text(
              'This APPLICATION is created by Kiyan Johari (github.com/Kiyanjr)'

              'Its for my senior year of Univercity as my Final Project.',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: const Color(0xFF455A64),
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
