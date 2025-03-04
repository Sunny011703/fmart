import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fmart/View/BuyNowProduct.dart';
import 'package:fmart/models/modelsApi.dart';
import 'package:fmart/viewModels/services/Apisrevices.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

class ProductDetails extends StatefulWidget {
  final String imagesPath;
  final String Category;
  final double productPrice;
  final String productdescription;

  const ProductDetails({
    super.key,
    required this.imagesPath,
    required this.Category,
    required this.productPrice,
    required this.productdescription,
    required FreeProductApiModel product,
  });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isLoading = true;
  List<FreeProductApiModel> productsList = [];

  @override
  void initState() {
    super.initState();
    fetchProductsData();
  }

  Future<void> fetchProductsData() async {
    final apiService = ProductsApiService();
    final data = await apiService.fetchProducts();

    log("API Response: ${data.toString()}");

    if (data != null && data.products != null && data.products!.isNotEmpty) {
      setState(() {
        productsList = data.products!;
        isLoading = false;
      });
      log("Total Products Fetched: ${productsList.length}");
    } else {
      setState(() {
        isLoading = false;
      });
      log("No products found!");
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Container(
          width: screenWidth * 0.7,
          height: screenHeight * 0.04,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(width: 0.5, color: Colors.black12),
          ),
          child: Text(
            "Search Product",
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_bag, color: Colors.blueAccent),
          ),
        ],
      ),
      body:
          isLoading
              ? Center(child: CupertinoActivityIndicator())
              : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: screenWidth * 0.6,
                          height: screenHeight * 0.3,
                          decoration: BoxDecoration(),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(widget.imagesPath),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            widget.Category,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.favorite),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Price ${widget.productPrice}',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "rating",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      ReadMoreText(
                        widget.productdescription,
                        trimMode: TrimMode.Line,
                        trimLines: 2,
                        colorClickableText: Colors.blueAccent,
                        trimCollapsedText: 'Show more',
                        trimExpandedText: 'Show less',
                        moreStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Divider(),
                      Text(
                        "All Product",
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10),
                      GridView.builder(
                        itemCount: productsList.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 255,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 8.0,
                        ),
                        itemBuilder: (context, index) {
                          final product = productsList[index];
                          return Container(
                            margin: EdgeInsets.all(2),
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(8),
                                  ),
                                  child: Image.network(
                                    product.image ??
                                        "https://via.placeholder.com/150",
                                    width: screenWidth * 0.6,
                                    height: screenHeight * 0.2,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.category ?? "No Title",
                                        style: GoogleFonts.poppins(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "\$${product.price?.toStringAsFixed(2) ?? '0.00'}",
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Spacer(),
                                          Icon(Icons.favorite),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton(
                icon: Icons.add_box_rounded,
                text: "Add TO Cart",
                textColor: Colors.black,
                backgroundColor: Colors.white,
                borderColor: Colors.grey.shade200,
                onPressed: () {
                  // Save button action
                },
              ),
              _buildButton(
                icon: Icons.shopping_bag_outlined,
                text: "Buy Now",
                textColor: Colors.white,
                backgroundColor: Colors.blueAccent,
                borderColor: Colors.blueAccent,
                onPressed: () {
                  Get.to(
                    () => Buynowproduct(),
                    transition: Transition.rightToLeftWithFade,
                    duration: Duration(microseconds: 400),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildButton({
  required IconData icon,
  required String text,
  required Color textColor,
  required Color backgroundColor,
  required Color borderColor,
  required VoidCallback onPressed,
}) {
  return Container(
    width: 150,
    height: 50,
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: borderColor),
    ),
    child: TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: textColor),
          SizedBox(width: 8),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    ),
  );
}
