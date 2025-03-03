
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:google_fonts/google_fonts.dart';

class DRAWERWIDGET extends StatelessWidget {
  const DRAWERWIDGET({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        //---------Drawer Header with Image on Left & Text on Right
        DrawerHeader(
          decoration: BoxDecoration(color: Colors.blue),
          child: Row(
            children: [
              //--------- Profile Image (Left Side)
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage("assets/images/pexels-photo-415829.webp"),
              ),
              SizedBox(width: 15),
    
              //-------Name & Email (Right Side)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Muskan",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "muskan@example.com",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
    
        // --------Drawer Menu Items
        ListTile(
          leading: Icon(Icons.home),
          title: Text("Home", style: GoogleFonts.poppins(fontSize: 14)),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text("Profile", style: GoogleFonts.poppins(fontSize: 14)),
          onTap: () {
            Get.to(()=>());
          },
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text("Settings", style: GoogleFonts.poppins(fontSize: 14)),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text("Logout", style: GoogleFonts.poppins(fontSize: 14)),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
