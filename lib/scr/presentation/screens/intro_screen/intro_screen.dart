import 'package:flutter/material.dart';
import 'package:e_commerce_frontend/scr/core/utils/values/colors.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> introData = [
    {
      'title': 'Discover something new',
      'subtitle': 'Special new arrivals just for you',
      'image': 'assets/images/intro_0.png',
    },
    {
      'title': 'Update trendy outfit',
      'subtitle': 'Favorite brands and hottest trends',
      'image': 'assets/images/intro_1.png',
    },
    {
      'title': 'Explore your true style',
      'subtitle': 'Relax and let us bring the style to you',
      'image': 'assets/images/intro_2.png',
    },
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorLight.background2,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemCount: introData.length,
              itemBuilder: (context, index) {
                final item = introData[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
                  child: Column(
                    children: [
                      const SizedBox(height: 32),
                      Text(
                        item['title']!,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: ColorLight.titleText,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item['subtitle']!,
                        style: TextStyle(
                          fontSize: 14,
                          color: ColorLight.subtitleText,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            item['image']!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              introData.length,
                  (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index
                      ? ColorLight.primary
                      : ColorLight.subtitleText.withOpacity(0.4),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  // Navigate to Login screen
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: ColorLight.buttonText),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  foregroundColor: ColorLight.buttonText,
                ),
                child: const Text("Shopping now"),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}