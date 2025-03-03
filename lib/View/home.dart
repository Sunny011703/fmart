import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fmart/View/ProductDetalis.dart';
import 'package:fmart/View/searchProductScreen.dart';
import 'package:fmart/View/shopping.dart';
import 'package:fmart/View/widgets/TitleByCategoriesName.dart';
import 'package:fmart/View/widgets/categoriesbyItmesName.dart';
import 'package:fmart/View/widgets/drawer.dart';
import 'package:fmart/models/modelsApi.dart';
import 'package:fmart/viewModels/services/Apisrevices.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

    log(
      "API Response: ${data.toString()}",
    ); // Debugging के लिए पूरा response log करो

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

  //------------------> List Images Items  <------------------

  final List<String> carouselSliderImages = [
    "assets/images/slider1.jpg",
    "assets/images/slider2.jpg",
    "assets/images/slider.jpg",
    "assets/images/slider3.jpg",
    "assets/images/slider4.webp",
  ];

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
            width: screenWidth * 0.5,
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
          _buildIcon(Icons.notifications, () {}),
          SizedBox(width: 10),
          _buildIcon(Icons.shopping_bag, () {}),
        ],
      ),
      drawer: Drawer(child: DRAWERWIDGET()),
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
                            height: Get.width * 0.2,
                            width: Get.width * 0.3,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
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
              : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 0.0,
                    horizontal: 16.0,
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          "Explore Fashion",
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          "Find Your Perfect Style..!",
                          style: GoogleFonts.poppins(fontSize: 14),
                        ),
                      ),

                      CarouselSlider(
                        items:
                            carouselSliderImages
                                .map(
                                  (imagePath) => ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      imagePath,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                                .toList(),
                        options: CarouselOptions(
                          height: 200,
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.8,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration: Duration(
                            milliseconds: 800,
                          ),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.3,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                      SizedBox(height: 10),
                      RowItemsCategories(),
                      //SizedBox(height: 5,),
                      TitleForCategories(
                        title: 'Best Sale Product',
                        onTapButton: () {
                          Get.to(
                            () => ShoppingScreen(),
                            transition: Transition.rightToLeftWithFade,
                            duration: Duration(milliseconds: 400),
                          );
                        },
                      ),
                      // SizedBox(height: 5,),
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
                          return GestureDetector(
                            onTap: () {
                              Get.to(
                                () => ProductDetails(
                                  product: product,
                                  imagesPath: product.image ?? "",
                                  Category: product.category ?? "No category",
                                  productPrice: product.price!,
                                  productdescription:
                                      product.description ?? "No description",
                                ),
                                transition: Transition.rightToLeftWithFade,
                                duration: Duration(milliseconds: 400),
                              );
                            },
                            child: Container(
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
                                      fit: BoxFit.cover,
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
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
    );
  }

  Widget _buildIcon(IconData icon, VoidCallback onTapButton) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(width: 0.5, color: Colors.black12),
      ),
      child: IconButton(
        onPressed: onTapButton,
        icon: Icon(icon, color: Colors.blueAccent),
      ),
    );
  }
}
