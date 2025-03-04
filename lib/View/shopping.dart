import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fmart/View/ProductDetalis.dart';
import 'package:fmart/View/searchProductScreen.dart';
import 'package:fmart/models/modelsApi.dart';
import 'package:fmart/viewModels/services/Apisrevices.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({super.key});

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
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

    log("API Response: \${data.toString()}");

    if (data != null && data.products != null && data.products!.isNotEmpty) {
      setState(() {
        productsList = data.products!;
        isLoading = false;
      });
      log("Total Products Fetched: \${productsList.length}");
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
        title: GestureDetector(
          onTap: () {
            Get.to(
              () => Searchproductscreen(),
              transition: Transition.rightToLeftWithFade,
              duration: Duration(milliseconds: 400),
            );
          },
          child: Container(
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
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
        ],
      ),
      body:
          isLoading
              ? Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: ListView.builder(
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: screenWidth * 0.2,
                            width: screenWidth * 0.3,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 10,
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  width: 100,
                                  height: 10,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
              : ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: productsList.length,
                itemBuilder: (context, index) {
                  final product = productsList[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(
                        () => ProductDetails(
                          product: product,
                          imagesPath: product.image ?? "",
                          Category: product.category ?? "No category",
                          productPrice: product.price ?? 0.0,
                          productdescription:
                              product.description ?? "No description",
                        ),
                        transition: Transition.rightToLeftWithFade,
                        duration: Duration(milliseconds: 400),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.all(6),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(width: 0.5, color: Colors.black12),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network(
                              product.image ??
                                  "https://via.placeholder.com/150",
                              width: screenWidth * 0.3,
                              height: screenHeight * 0.09,
                              fit: BoxFit.fill,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.network(
                                  "https://via.placeholder.com/150",
                                  width: screenWidth * 0.3,
                                  height: screenHeight * 0.2,
                                  fit: BoxFit.fill,
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.category ?? "No Category",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  product.title ?? "No Title",
                                  style: TextStyle(fontSize: 12),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "\$${product.price?.toStringAsFixed(2) ?? '0.00'}",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.favorite),
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
