import 'package:ani4h_app/core/route/route_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<IntroPage> _pages = [
    IntroPage(
      title: 'Welcome to Ani4h',
      description: 'Your ultimate destination for anime movies and series',
      image: 'lib/common/resource/images/intro1.png', // Replace with your actual asset
    ),
    IntroPage(
      title: 'Discover New Content',
      description: 'Explore a vast collection of anime movies and series',
      image: 'lib/common/resource/images/intro2.png', // Replace with your actual asset
    ),
    IntroPage(
      title: 'Ready to Start?',
      description: 'Begin your anime journey with Ani4h today',
      image: 'lib/common/resource/images/intro3.png', // Replace with your actual asset
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }


  void _navigateToLogin() {
    context.pushNamed(loginRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Page content
          PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: _pages.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColor.withOpacity(0.8),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Image
                      Expanded(
                        flex: 3,
                        child: Image.asset(
                          _pages[index].image,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 40),
                      // Title
                      Text(
                        _pages[index].title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      // Description
                      Text(
                        _pages[index].description,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
                      // Progress indicator
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _pages.length,
                              (index) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentPage == index
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.4),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      if (index == _pages.length - 1)
                        ElevatedButton(
                          onPressed: _navigateToLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Theme.of(context).primaryColor,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 48,
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            'Get Started',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class IntroPage {
  final String title;
  final String description;
  final String image;

  IntroPage({
    required this.title,
    required this.description,
    required this.image,
  });
}


