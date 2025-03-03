import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:fmart/View/Wishist.dart';
import 'package:fmart/View/home.dart';
import 'package:fmart/View/proflie.dart';
import 'package:fmart/View/shopping.dart';
import 'package:fmart/viewModels/Controller/AnimatedBottomNavationBArController.dart';
import 'package:get/get.dart';


class AnimatedBottomNavigationBar extends StatelessWidget {
  AnimatedBottomNavigationBar({super.key});
  final BottomNavController controller = Get.put(BottomNavController()); //---------->Inject GetX Controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        onPageChanged: (index) {
          controller.selectedIndex.value = index; //----------------->Update index
        },
        children: const [
          HomeScreen(),
          ShoppingScreen(),
          WishistScreen(),
          UserprofileScreen(),
          
        ],
      ),

      bottomNavigationBar: Obx(() => CurvedNavigationBar(
            index: controller.selectedIndex.value, //--------------> Only updating this value
            height: 50,
            backgroundColor: Colors.white,
            color: Colors.blueAccent,
            animationDuration: Duration(milliseconds: 300),
            items: const [
              Icon(Icons.home, size: 30, color: Colors.white),
              Icon(Icons.shopping_bag, size: 30, color: Colors.white),
              Icon(Icons.favorite, size: 30, color: Colors.white),
              Icon(Icons.person, size: 30, color: Colors.white),
            ],
            onTap: (index) {
              controller.changePage(index);
            },
          )),
    );
  }
}
