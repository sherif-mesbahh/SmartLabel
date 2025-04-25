import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';

class OnBoardingTitels extends StatelessWidget {
  const OnBoardingTitels({
    super.key,
    required this.currentPage,
  });

  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedOpacity(
            opacity: currentPage == 0 ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: Text(
              'Your Smart Shopping Experience Starts Here!',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: screenWidth(context) * 0.05,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
                color: Colors.black,
                shadows: [
                  Shadow(
                    offset: Offset(1.0, 1.0),
                    blurRadius: 4.0,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                ],
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: currentPage == 1 ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: Text(
              'Easily Manage Your Products, Anytime!',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: screenWidth(context) * 0.05,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
                color: Colors.black,
                shadows: [
                  Shadow(
                    offset: Offset(1.0, 1.0),
                    blurRadius: 4.0,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                ],
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: currentPage == 2 ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: Text(
              'Shop Smarter with Real-Time Price Updates!',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: screenWidth(context) * 0.05,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
                color: Colors.black,
                shadows: [
                  Shadow(
                    offset: Offset(1.0, 1.0),
                    blurRadius: 4.0,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
