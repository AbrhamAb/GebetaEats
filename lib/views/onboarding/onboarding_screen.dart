import 'package:flutter/material.dart';
import '../../theme.dart';

class OnboardingPage {
  final String imageUrl;
  final String title;
  final String description;

  OnboardingPage({
    required this.imageUrl,
    required this.title,
    required this.description,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _page = 0;

  // Local onboarding pages
  final List<OnboardingPage> _pages = [
    OnboardingPage(
      imageUrl:
          'https://kajabi-storefronts-production.kajabi-cdn.com/kajabi-storefronts-production/file-uploads/blogs/2147704672/images/1adf4-eba4-a33c-774a-0c8b431df6f4_Food-Ordering-App-iOS-System-Design.png',
      title: 'Discover Delicious Food',
      description:
          'Find your favorite meals from top local restaurants and get them delivered fast.',
    ),
    OnboardingPage(
      imageUrl:
          'https://res.cloudinary.com/jerrick/image/upload/d_642250b563292b35f27461a7.png,f_jpg,fl_progressive,q_auto,w_1024/64ad00c1204a67001d7f1b7c.jpg',
      title: 'Fast Delivery',
      description: 'Enjoy quick and reliable delivery right to your doorstep.',
    ),
    OnboardingPage(
      imageUrl:
          'https://gumlet.assettype.com/down-to-earth%2Fimport%2Flibrary%2Flarge%2F2019-03-05%2F0.89399200_1551782137_fast1.jpg',
      title: 'Easy Payment',
      description:
          'Pay conveniently with multiple payment options available in the app.',
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next() {
    if (_page < _pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } else {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            children: <Widget>[
              // PageView with flexible height
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _pages.length,
                  onPageChanged: (index) => setState(() => _page = index),
                  itemBuilder: (context, index) {
                    final page = _pages[index];
                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: <Widget>[
                          const SizedBox(height: 12),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: AspectRatio(
                              aspectRatio: 4 / 5,
                              child: Image.network(
                                page.imageUrl,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Text(
                              page.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: AppColors.text,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                            ),
                            child: Text(
                              page.description,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Dots indicator
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(_pages.length, (index) {
                  final isActive = index == _page;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: isActive ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: isActive ? AppColors.primary : AppColors.border,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  );
                }),
              ),

              // Next button
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _next,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    _page == _pages.length - 1 ? "Get Started" : "Next",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
