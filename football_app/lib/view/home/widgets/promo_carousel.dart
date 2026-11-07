import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PromoCarousel extends StatefulWidget {
  const PromoCarousel({super.key});

  @override
  State<PromoCarousel> createState() => _PromoCarouselState();
}

class _PromoCarouselState extends State<PromoCarousel> {
  int _activeIndex = 0;

  final List<Map<String, String>> _banners = [
    {
      'image': 'assets/images/futsal1.jpg',
      'title': 'Ready for the next match?',
      'subtitle': 'Discover and register for futsal tournaments.',
      'button': 'Explore Tournaments',
    },
    {
      'image': 'assets/images/futsal2.jpg',
      'title': 'Build your dream squad',
      'subtitle': 'Create a team and invite your friends to play.',
      'button': 'Create Team',
    },
    {
      'image': 'assets/images/futsal3.jpg',
      'title': 'Book your court today',
      'subtitle': 'Find nearby futsal grounds and reserve a slot.',
      'button': 'Book Now',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: _banners.length,
          options: CarouselOptions(
            height: 190,
            viewportFraction: 0.92,
            enlargeCenterPage: true,
            enlargeFactor: 0.12,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 700),
            autoPlayCurve: Curves.easeInOutCubic,
            onPageChanged: (index, reason) =>
                setState(() => _activeIndex = index),
          ),
          itemBuilder: (context, index, realIndex) {
            final banner = _banners[index];
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      banner['image']!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) =>
                          Container(color: const Color(0xFF1C1C1E)),
                    ),
                    // Gradient overlay for readable text
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.black.withValues(alpha: 0.85),
                            Colors.black.withValues(alpha: 0.35),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18, 18, 18, 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            banner['title']!,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            banner['subtitle']!,
                            style: GoogleFonts.poppins(
                              color: Colors.white70,
                              fontSize: 11,
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 34,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                banner['button']!,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        AnimatedSmoothIndicator(
          activeIndex: _activeIndex,
          count: _banners.length,
          effect: WormEffect(
            dotHeight: 6,
            dotWidth: 6,
            strokeWidth: 0,
            spacing: 6,
            activeDotColor: Colors.green,
            dotColor: Colors.grey,
          ),
        ),
      ],
    );
  }
}
