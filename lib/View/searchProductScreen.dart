import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fmart/View/ProductDetalis.dart';
import 'package:fmart/models/modelsApi.dart';
import 'package:fmart/viewModels/services/Apisrevices.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class Searchproductscreen extends StatefulWidget {
  const Searchproductscreen({super.key});

  @override
  State<Searchproductscreen> createState() => _SearchproductscreenState();
}

class _SearchproductscreenState extends State<Searchproductscreen> {
  bool isLoading = true;
  List<FreeProductApiModel> productsList = [];
  List<FreeProductApiModel> allproduct =
      []; // ✅ Fix: allproduct ko sahi se use kiya
  List<FreeProductApiModel> filteredProduct = [];
  final ProductsApiService _productsApiService = ProductsApiService();

  @override
  void initState() {
    super.initState();
    fetchProductsData();
  }

  // ----------------------------> API Call Function
  Future<void> fetchProductsData() async {
    try {
      log("⏳ Fetching products...");
      final data = await _productsApiService.fetchProducts();

      if (data != null && data.products != null) {
        setState(() {
          productsList = data.products!;
          allproduct = productsList; // ✅ Fix: allproduct ko update kiya
          filteredProduct = productsList;
          isLoading = false;
        });
        log("✅ Total Products Fetched: ${productsList.length}");
      } else {
        setState(() {
          isLoading = false;
        });
        log("⚠️ No products found!");
      }
    } catch (e) {
      log("❌ API Fetch Error: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  // ----------------------------> Search Function
  void _Searchproducts(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredProduct = allproduct; // ✅ Fix: allproduct se search results lo
      });
      return;
    }

    setState(() {
      filteredProduct =
          allproduct
              .where(
                (product) =>
                    product.category?.toLowerCase().contains(
                      query.toLowerCase(),
                    ) ??
                    false,
              )
              .toList();
    });

    log("🔍 Search Results: ${filteredProduct.length} items found");
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
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Container(
          width: screenWidth * 0.6,
          height: screenHeight * 0.04,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(width: 0.5, color: Colors.black12),
          ),
          child: Center(
            child: TextFormField(
              onChanged: _Searchproducts,
              decoration: InputDecoration(
                hintText: 'Search Product',
                hintStyle: TextStyle(fontSize: 14),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 10),
              ),
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
              : filteredProduct.isEmpty
              ? Center(child: Text("No products found!"))
              : Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0,
                ),
                child: ListView.builder(
                  itemCount: filteredProduct.length,
                  itemBuilder: (context, index) {
                    final product = filteredProduct[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(
                          () => ProductDetails(
                            product: product,
                            imagesPath: product.image ?? "",
                            Category: product.category ?? "No category",
                            productPrice: product.price!,
                            productdescription: product.description??" No description",
                          ),
                          transition: Transition.rightToLeftWithFade,
                          duration: Duration(milliseconds: 400),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(width: 0.5, color: Colors.black12),
                        ),
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network(
                              product.image ??
                                  "https://via.placeholder.com/150",
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.network(
                                  "https://via.placeholder.com/150",
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
                          title: Text(product.category ?? "No Category"),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(product.title ?? "No Title"),
                              Text(
                                "\$${product.price?.toStringAsFixed(2) ?? '0.00'}",
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.favorite),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
    );
  }
}
