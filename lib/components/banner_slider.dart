import 'package:flutter/material.dart';
import 'dart:async';
import 'header.dart';

class BannerSlider extends StatefulWidget {
  final ActiveTab category;
  
  const BannerSlider({
    super.key,
    this.category = ActiveTab.food,
  });

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  // Get banner images based on category
  List<String> get _bannerImages {
    switch (widget.category) {
      case ActiveTab.food:
        return [
          'assets/images/slider1.png',
          'assets/images/slider2.png',
          'assets/images/slider3.png',
        ];
      case ActiveTab.grocery:
        return [
          'assets/images/grocery1.png',
          'assets/images/grocery2.png',
          'assets/images/grocery3.png',
        ];
      case ActiveTab.milk:
        return [
          'assets/images/milk1.png',
          'assets/images/milk2.png',
          'assets/images/milk3.png',
        ];
    }
  }

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_pageController.hasClients) {
        if (_currentPage < _bannerImages.length - 1) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bannerHeight = screenWidth * 0.4; // Responsive height - 40% of screen width
    
    return Column(
      children: [
        SizedBox(
          height: bannerHeight,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: _bannerImages.length,
            itemBuilder: (context, index) {
              return _buildBannerImage(_bannerImages[index]);
            },
          ),
        ),
        const SizedBox(height: 12),
        // Page Indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _bannerImages.length,
            (index) => _buildIndicator(index == _currentPage),
          ),
        ),
      ],
    );
  }

  Widget _buildBannerImage(String imagePath) {
    return ClipRRect(
      child: Image.asset(
        imagePath,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          // Category-specific placeholder colors
          List<Color> gradientColors;
          IconData icon;
          
          switch (widget.category) {
            case ActiveTab.food:
              gradientColors = [
                Colors.orange.shade400,
                Colors.orange.shade600,
                Colors.orange.shade800,
              ];
              icon = Icons.restaurant;
              break;
            case ActiveTab.grocery:
              gradientColors = [
                Colors.green.shade400,
                Colors.green.shade600,
                Colors.green.shade800,
              ];
              icon = Icons.shopping_cart;
              break;
            case ActiveTab.milk:
              gradientColors = [
                Colors.blue.shade400,
                Colors.blue.shade600,
                Colors.blue.shade800,
              ];
              icon = Icons.local_drink;
              break;
          }
          
          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: gradientColors,
              ),
            ),
            child: Center(
              child: Icon(
                icon,
                size: 50,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(4),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.8),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
    );
  }
}
