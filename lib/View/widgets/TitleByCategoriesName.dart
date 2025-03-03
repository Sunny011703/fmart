import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleForCategories extends StatelessWidget {
  const TitleForCategories({
    super.key,
    required this.title,
    this.text = "See All",
    this.onTapButton,
  });

  final String title;
  final String text;
  final VoidCallback? onTapButton; // Function nullable hai

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// 🏷 **Category Title**
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),

        /// 🔘 **Conditional "See All" Button**
        if (onTapButton != null) // Agar function null nahi hai tabhi show hoga
          TextButton(
            onPressed: onTapButton,
            child: Text(
              text,
              style: GoogleFonts.aBeeZee(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.deepOrange,
              ),
            ),
          ),
      ],
    );
  }
}
