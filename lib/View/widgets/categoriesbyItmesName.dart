import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RowItemsCategories extends StatefulWidget {
  const RowItemsCategories({super.key});

  @override
  _RowItemsCategoriesState createState() => _RowItemsCategoriesState();
}

class _RowItemsCategoriesState extends State<RowItemsCategories> {
  int selectedCategory = 0; // Default selected "All"

  final List<String> categories = ["All", "Men", "Women", "Girls", "Kids"];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          bool isSelected = selectedCategory == index;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedCategory = index; // Update selected category
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: isSelected
                          ? Colors.blueAccent
                          : Colors.grey[300],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Center(
                      child: Text(
                        categories[index],
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isSelected ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
